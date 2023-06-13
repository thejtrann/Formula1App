//
//  AddTrip.swift
//  TravelAid
//
//  Created by Ryan Tabor and Osman Balci on 7/3/22.
//  Copyright © 2022 Osman Balci. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData
import CoreLocation


struct AddTrip: View {

    // Enable this view to be dismissed to go back to the previous view
    @Environment(\.dismiss) private var dismiss
    
    // ❎ CoreData managedObjectContext reference
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // ❎ CoreData FetchRequest returning all ParkVisit entities in the database
    @FetchRequest(fetchRequest: TravelAid.allTravelsFetchRequest()) var allParkVisits: FetchedResults<TravelAid>
    
    // Subscribe to changes in Core Data database
    @EnvironmentObject var databaseChange: DatabaseChange
    
    //---------------------------
    // National Park Visit Entity
    //---------------------------
    @State private var dateVisited = Date()
    @State private var dateLeft = Date()
    @State private var cost = 0
    @State private var title = ""
    @State private var ratingIndex = 3  // Default: "Very Good"
    @State private var notes = ""
    @State private var rating = 0
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.generatesDecimalNumbers = true
        formatter.minimum = 0.0
        formatter.maximum = 99999.999
        return formatter
    }()
    
    //------------------------------------
    // Image Picker from Camera or Library
    //------------------------------------
    @State private var showImagePicker = false
    @State private var pickedUIImage: UIImage?
    @State private var pickedImage: Image?
    
    @State private var useCamera = false
    @State private var usePhotoLibrary = true
    
    
    
    //-----------------------------------
    // National Park Visit Rating Choices
    //-----------------------------------
    @State private var ratings = [1, 2, 3, 4, 5]
    
    //---------------
    // Alert Messages
    //---------------
    @State private var showAlertMessage = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .long     // e.g., August 14, 2020
            return formatter
        }
    
    //------------------
    // Date Closed Range
    //------------------
    var dateClosedRange: ClosedRange<Date> {
        // Set minimum date to 20 years earlier than the current year
        let minDate = Calendar.current.date(byAdding: .year, value: -20, to: Date())!
        
        // Set maximum date to 2 years later than the current year
        let maxDate = Calendar.current.date(byAdding: .year, value: 2, to: Date())!
        return minDate...maxDate
    }
    
    var body: some View {
        /*
         Create Binding between 'useCamera' and 'usePhotoLibrary' boolean @State variables so that only one of them can be true.
         get
         A closure that retrieves the binding value. The closure has no parameters.
         set
         A closure that sets the binding value. The closure has the following parameter:
         newValue stored in $0: The new value of 'useCamera' or 'usePhotoLibrary' boolean variable as true or false.
         
         Custom get and set closures are run when a newValue is obtained from the Toggle when it is turned on or off.
         */
        let camera = Binding(
            get: { useCamera },
            set: {
                useCamera = $0
                if $0 == true {
                    usePhotoLibrary = false
                }
            }
        )
        let photoLibrary = Binding(
            get: { usePhotoLibrary },
            set: {
                usePhotoLibrary = $0
                if $0 == true {
                    useCamera = false
                }
            }
        )
        
        Form {
            Section(header: Text("Trip Title")) {
                TextField("Enter a title for your trip", text: $title)
            }
            Section(header: Text("Trip Cost")) {
                TextField("", value: $cost, formatter: numberFormatter)
            }
            Section(header: Text("Trip Rating")) {
                VStack {    // Enclose within VStack so that Picker is centered
                    Picker("", selection: $ratingIndex) {
                        ForEach(0 ..< ratings.count, id: \.self) {
                            Text(String(ratings[$0]))
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
        Section(header: Text("Trip Notes"), footer:
                    Button(action: {
            self.dismissKeyboard()
        }) {
            Image(systemName: "keyboard")
                .font(Font.title.weight(.light))
                .foregroundColor(.blue)
        }
        ) {
            TextEditor(text: $notes)
                .frame(height: 100)
                .font(.custom("Helvetica", size: 14))
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
        }
            Section(header: Text("Trip Start Date")) {
                DatePicker(
                    selection: $dateVisited,
                    in: dateClosedRange,
                    displayedComponents: .date) {
                        Text("Trip Start Date")
                    }
            }
            Section(header: Text("Trip End Date")) {
                DatePicker(
                    selection: $dateLeft,
                    in: dateClosedRange,
                    displayedComponents: .date) {
                        Text("Trip End Date")
                    }
            }
            Section(header: Text("Take or Pick Photo")) {
                VStack {
                    Toggle("Use Camera", isOn: camera)
                    Toggle("Use Photo Library", isOn: photoLibrary)
                    
                    Button("Get Photo") {
                        showImagePicker = true
                    }
                    .tint(.blue)
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                }
            }
            if pickedImage != nil {
                Section(header: Text("Taken or Picked Photo")) {
                    pickedImage?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100.0, height: 100.0)
                }
            }
            
        }   // End of Form
            .font(.system(size: 14))
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .disableAutocorrection(true)
            .autocapitalization(.none)

            .navigationBarTitle(Text("Add Trip"), displayMode: .inline)
            .navigationBarItems(trailing:
                Button("Save") {
                    if inputDataValidated() {
                        saveNewTrip()
                        
                        showAlertMessage = true
                        alertTitle = "New Trip Saved!"
                        alertMessage = "Your new trip is successfully saved in the database!"
                    } else {
                        showAlertMessage = true
                        alertTitle = "Missing Input Data!"
                        alertMessage = "Required Data: trip title, notes, and cost."
                    }
                }
            )
            .alert(alertTitle, isPresented: $showAlertMessage, actions: {
                Button("OK") {
                    if alertTitle == "New Trip Saved!" {
                        // Dismiss this view and go back to the previous view
                        dismiss()
                    }
                }
            }, message: {
                Text(alertMessage)
            })
        
            .onChange(of: pickedUIImage) { _ in
                guard let uiImagePicked = pickedUIImage else { return }
                
                // Convert UIImage to SwiftUI Image
                pickedImage = Image(uiImage: uiImagePicked)
            }
            
            .sheet(isPresented: $showImagePicker) {
                /*
                 For storage and performance efficiency reasons, we scale down the photo image selected from the
                 photo library or taken by the camera to a smaller size with imageWidth and imageHeight in points.
                 
                 For high-resolution displays, 1 point = 3 pixels
                 
                 We use a square aspect ratio 1:1 for album cover photos with imageWidth = imageHeight = 200.0 points.
                 
                 You can select imageWidth and imageHeight values for other aspect ratios such as 4:3 or 16:9.
                 
                 imageWidth = 200.0 points and imageHeight = 200.0 points will produce an image with
                 imageWidth = 600.0 pixels and imageHeight = 600.0 pixels which is about 84KB to 164KB in JPG format.
                 */
                
                ImagePicker(uiImage: $pickedUIImage, sourceType: useCamera ? .camera : .photoLibrary, imageWidth: 200.0, imageHeight: 200.0)
            }
    }   // End of body var
    
    /*
     ---------------------------
     MARK: Input Data Validation
     ---------------------------
     */
    func inputDataValidated() -> Bool {
        
        if title.isEmpty || notes.isEmpty {
            return false
        }
        
        return true
    }
    
    func dismissKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    
    
    
    
    
    /*
     ***************************************************************
     *        Take Notes by Converting Your Speech to Text         *
     ***************************************************************
     */
    
    /*
     **********************************
     MARK: Save New National Park Visit
     **********************************
     */
    func saveNewTrip() {
        
        // Instantiate a DateFormatter object
        let dateFormatter = DateFormatter()
        
        // Set the date format to yyyy-MM-dd
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // Obtain DatePicker's selected date, format it as yyyy-MM-dd, and convert it to String
        let visitDateString = dateFormatter.string(from: dateVisited)
        
        let leaveDateString = dateFormatter.string(from: dateLeft)
        
        /*
         ==================================
         *   Park Visit Entity Creation   *
         ==================================
         */
        // 1️⃣ Create an instance of the ParkVisit Entity in managedObjectContext
        let tripEntity = TravelAid(context: managedObjectContext)
        
        // 2️⃣ Dress it up by specifying its attributes
        tripEntity.orderNumber = (allParkVisits.count + 1) as NSNumber
        tripEntity.photoDateTime = visitDateString
        tripEntity.title = title
        tripEntity.rating = ratings[ratingIndex] as NSNumber
        tripEntity.cost = cost as NSNumber
        tripEntity.notes = notes
        tripEntity.startDate = visitDateString
        tripEntity.endDate = leaveDateString
        
        // 3️⃣ Its relationships with Photo and Audio entities are defined below
        
        // 2️⃣ Dress it up by specifying its attributes
        
        // Convert pickedUIImage to data of type Data (Binary Data) in JPEG format with 100% quality
        if let photoData = pickedUIImage?.jpegData(compressionQuality: 1.0) {
            
            // Assign photoData to Core Data entity attribute of type Data (Binary Data)
            tripEntity.photoFilename = photoData
            
        } else {
            // Obtain default park visit photo image from Assets.xcassets as UIImage
            let photoUIImage = UIImage(named: "ImageUnavailable")
            
            // Convert photoUIImage to data of type Data (Binary Data) in JPEG format with 100% quality
            let photoData = photoUIImage?.jpegData(compressionQuality: 1.0)
            
            // Assign photoData to Core Data entity attribute of type Data (Binary Data)
            tripEntity.photoFilename = photoData!
        }
        
        //-----------------------------------------------------------
        // Obtain Current Date and Time as "yyyy-MM-dd' at 'HH:mm:ss"
        //-----------------------------------------------------------
        let dateAndTime = Date()
        
        // Create an instance of DateFormatter
        let dateTimeFormatter = DateFormatter()
        
        // Set the date format to yyyy-MM-dd at HH:mm:ss
        dateTimeFormatter.dateFormat = "yyyy-MM-dd' at 'HH:mm:ss"
        
        // Format dateAndTime under the dateTimeFormatter and convert it to String
        let currentDateTime = dateTimeFormatter.string(from: dateAndTime)
        
        
        //----------------------------------------------------------
        // Get Latitude and Longitude of Where Photo Taken or Picked
        //----------------------------------------------------------
        let photoLocation = currentLocation()       // Given in CurrentLocation.swift
        
        tripEntity.photoLatitude = photoLocation.latitude as NSNumber
        tripEntity.photoLongitude = photoLocation.longitude as NSNumber
        
        
        // ❎ Save Changes to Core Data Database
        PersistenceController.shared.saveContext()
        
        // Toggle database change indicator so that its subscribers can refresh their views
        databaseChange.indicator.toggle()
        
    }   // End of func saveNewParkVisit()
    
}

