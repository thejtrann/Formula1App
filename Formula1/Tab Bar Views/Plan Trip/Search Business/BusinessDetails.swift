//
//  BusinessDetails.swift
//  TravelAid
//
//  Created by Osman Balci on 11/15/22.
//  Copyright © 2022 Jason Tran. All rights reserved.
//

import SwiftUI
import CoreData
import MapKit

struct BusinessDetails: View {
    
    // Input Parameter
    let business: ApiBusinessStruct
    
    @State private var selectedMapTypeIndex = 0
    var mapTypes = ["Standard", "Satellite", "Hybrid", "Globe"]
    
    @State private var selectedTransportTypeIndex = 1   // Walking
    @State private var selectedMapType2Index = 2         // Hybrid
    
    let mapTypes2 = ["Standard", "Satellite", "Hybrid"]
    let directionsTransportTypes = ["Driving", "Walking"]
    
    // Enable this view to be dismissed to go back to the previous view
    @Environment(\.dismiss) private var dismiss
    
    // Subscribe to changes in Core Data database
    @EnvironmentObject var databaseChange: DatabaseChange
    
    //---------------
    // Alert Messages
    //---------------
    @State private var showAlertMessage = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        Form {
            Group {
                Section(header: Text("Business Name")) {
                    Text(business.name)
                }
                Section(header: Text("Business Image")) {
                    getImageFromUrl(url: business.image_url, defaultFilename: "ImageUnavailable")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300)
                }
                Section(header: Text("Business Rating Out of 5 Stars")) {
                    HStack(spacing: 3) {
                        ForEach(1...Int(business.rating), id: \.self) { _ in
                            Image(systemName: "star.fill")
                                .foregroundColor(.blue)
                        }
                        if(Int(business.rating-0.5) == Int(business.rating)){
                            Image(systemName: "star.leadinghalf.fill")
                                .foregroundColor(.blue)
                        }
                        Text("based on \(business.review_count) reviews")
                    }
                    
                }
                Section(header: Text("Business Phone Number")) {
                    // Tap the phone number to display the Call phone number interface
                    HStack {
                        Image(systemName: "phone")
                            .imageScale(.medium)
                            .font(Font.title.weight(.light))
                            .foregroundColor(Color.blue)
                        
                        //**************************************************************************
                        // This Link does not work on the Simulator since Phone app is not available
                        //**************************************************************************
                        Link(business.phone, destination: URL(string: phoneNumberToCall(phoneNumber: business.phone))!)
                    }
                    // Long press the phone number to display the context menu
                    .contextMenu {
                        // Context Menu Item 1
                        //**************************************************************************
                        // This Link does not work on the Simulator since Phone app is not available
                        //**************************************************************************
                        Link(destination: URL(string: phoneNumberToCall(phoneNumber: business.phone))!) {
                            Image(systemName: "phone")
                            Text("Call")
                        }
                        
                        // Context Menu Item 2
                        Button(action: {
                            // Copy the phone number to universal clipboard for pasting elsewhere
                            UIPasteboard.general.string = business.phone
                            
                            showAlertMessage = true
                            alertTitle = "Phone Number is Copied to Clipboard"
                            alertMessage = "You can paste it on your iPhone, iPad, Mac laptop or Mac desktop each running under your Apple ID"
                        }) {
                            Image(systemName: "doc.on.doc")
                            Text("Copy Phone Number")
                        }
                    }
                }
            }
            
            Group{
                Section(header: Text("Business Website")) {
                    Link(destination: URL(string: business.url)!) {
                        HStack {
                            Image(systemName: "globe")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                            Text("Show Company Website")
                                .font(.system(size: 16))
                        }
                        .foregroundColor(.blue)
                    }
                    .contextMenu {
                        // Context Menu Item
                        Button(action: {
                            // Copy the website URL to universal clipboard for pasting elsewhere
                            UIPasteboard.general.url = URL(string: business.url)!
                            
                            showAlertMessage = true
                            alertTitle = "Website URL is Copied to Clipboard"
                            alertMessage = "You can paste it on your iPhone, iPad, Mac laptop or Mac desktop each running under your Apple ID"
                        }) {
                            Image(systemName: "doc.on.doc")
                            Text("Copy Website URL")
                        }
                    }
                }
                Section(header: Text("Business Address")) {
                    Text("\(business.address1)\n\(business.address2) \(business.address3)\n\(business.city), \(business.state) \(business.zip_code), \(business.country)")
                }
                
                Section(header: Text("Select Map Type")) {
                    
                    Picker("Select Map Type", selection: $selectedMapTypeIndex) {
                        ForEach(0 ..< mapTypes.count, id: \.self) { index in
                            Text(mapTypes[index])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    
                    NavigationLink(destination: entryLocationOnMap) {
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                            Text("Show Diary Entry Location on Map")
                                .font(.system(size: 16))
                        }
                        .foregroundColor(.blue)
                    }
                }
                Section(header: Text("Directions To Selected Business")){
                    Text("Select Directions Transport Type")
                    transportTypePicker
                    Text("Select Map Type")
                    mapTypePicker
                    Text("Select Directions on Map")
                    NavigationLink(destination: showDirectionsOnMap) {
                        HStack {
                            Image(systemName: "arrow.up.right.diamond")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                            Text("Show Directions on Map")
                                .font(.system(size: 16))
                        }
                        .foregroundColor(.blue)
                    }
                }
            }
        }   // End of Form
        .alert(alertTitle, isPresented: $showAlertMessage, actions: {
            Button("OK") {}
        }, message: {
            Text(alertMessage)
        })
        .navigationBarTitle(Text("Business Details"), displayMode: .inline)
        .font(.system(size: 14))
    }
    
    var showDirectionsOnMap: some View {
        
        var mapType: MKMapType
        
        switch selectedMapTypeIndex {
        case 0:
            mapType = MKMapType.standard
        case 1:
            mapType = MKMapType.satellite
        case 2:
            mapType = MKMapType.hybrid
        default:
            fatalError("Map type is out of range!")
        }
        
        var transportType: MKDirectionsTransportType
        
        switch selectedTransportTypeIndex {
        case 0:
            transportType = .automobile
        case 1:
            transportType = .walking
        default:
            fatalError("Transport type is out of range!")
        }
        
        // From current location
        
        // currentLocation() is given in CurrentLocation.swift
        let currentGeolocation = currentLocation()
        let latitudeFrom = currentGeolocation.latitude
        let longitudeFrom = currentGeolocation.longitude
        
        return AnyView(
            VStack {
                // Display "from current location to where" as centered multi lines
                Text("From Current Location to \(business.name)")
                    .font(.custom("Helvetica", size: 10))
                    .fixedSize(horizontal: false, vertical: true)   // Allow lines to wrap around
                    .multilineTextAlignment(.center)
                
                // Display directions on map
                DirectionsOnMap(latitudeFrom:   latitudeFrom,
                                longitudeFrom:  longitudeFrom,
                                latitudeTo:     business.latitude as! Double,
                                longitudeTo:    business.longitude as! Double,
                                mapType: mapType,
                                directionsTransportType: transportType)
                
                .navigationBarTitle(Text("\(directionsTransportTypes[selectedTransportTypeIndex]) Directions"), displayMode: .inline)
            }
        )
        
        
    }   // End of showDirectionsOnMap
    
    var transportTypePicker: some View {
        Picker("Transport Type", selection: $selectedTransportTypeIndex) {
            ForEach(0 ..< directionsTransportTypes.count, id: \.self) { index in
                Text(directionsTransportTypes[index]).tag(index)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
    }
    
    var mapTypePicker: some View {
        Picker("Select Map Type", selection: $selectedMapType2Index) {
            ForEach(0 ..< mapTypes.count, id: \.self) { index in
                Text(mapTypes[index]).tag(index)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
    }
    
    func phoneNumberToCall(phoneNumber: String) -> String {
        // phoneNumber = (540) 231-4841
        
        let cleaned1 = phoneNumber.replacingOccurrences(of: " ", with: "")
        let cleaned2 = cleaned1.replacingOccurrences(of: "(", with: "")
        let cleaned3 = cleaned2.replacingOccurrences(of: ")", with: "")
        let cleanedNumber = cleaned3.replacingOccurrences(of: "-", with: "")
        
        // cleanedNumber = 5402314841
        
        return "tel:" + cleanedNumber
    }
    var entryLocationOnMap: some View {
        
        var mapType: MKMapType
        
        switch selectedMapTypeIndex {
        case 0:
            mapType = MKMapType.standard
        case 1:
            mapType = MKMapType.satellite
        case 2:
            mapType = MKMapType.hybrid
        case 3:
            mapType = MKMapType.hybridFlyover   // Globe
        default:
            fatalError("Map type is out of range!")
        }
        
        return AnyView(
            MapView(mapType: mapType,
                    latitude: business.latitude,
                    longitude: business.longitude,
                    delta: 15.0,
                    deltaUnit: "degrees",
                    annotationTitle: business.name,
                    annotationSubtitle: business.phone)
            
            .navigationBarTitle(Text(business.name), displayMode: .inline)
        )
    }
}




