//
//  ExperienceData.swift
//  Formula1
//
//  Created by Osman Balci on 11/27/22.
//

import SwiftUI
import CoreData

var videoStructList = [Video]()
var teamStructList = [Team]()
var photoStructList = [Photo]()

public func createExperienceDatabase() {
    // ❎ Get object reference of Core Data managedObjectContext from the persistent container
    let managedObjectContext = PersistenceController.shared.persistentContainer.viewContext
    
    //----------------------------
    // ❎ Define the Fetch Request
    //----------------------------
    let fetchRequest = NSFetchRequest<Experience>(entityName: "Experience")
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "orderNumber", ascending: true)]
    
    var listOfAllExpEntitiesInDatabase = [Experience]()
    
    do {
        //-----------------------------
        // ❎ Execute the Fetch Request
        //-----------------------------
        listOfAllExpEntitiesInDatabase = try managedObjectContext.fetch(fetchRequest)
    } catch {
        print("Database Creation Failed!")
        return
    }
    
    if listOfAllExpEntitiesInDatabase.count > 0 {
        print("Database has already been created!")
        return
    }
    
    print("Database will be created!")
    
    
    var arrayOfExperienceStructs = [ExperienceStruct]()
    arrayOfExperienceStructs = decodeJsonFileIntoArrayOfStructs(fullFilename: "ExperienceData.json", fileLocation: "Main Bundle")

    for anExp in arrayOfExperienceStructs {
        /*
         ===============================
         *   Trip Entity Creation   *
         ===============================
         */
        
        // 1️⃣ Create an instance of the Photo entity in managedObjectContext
        let experienceEntitity = Experience(context: managedObjectContext)
        
        // 2️⃣ Dress it up by specifying its attributes
        experienceEntitity.orderNumber = anExp.orderNumber as NSNumber
        experienceEntitity.title = anExp.title
        experienceEntitity.circuit = anExp.circuit
        experienceEntitity.startDate = anExp.startDate
        experienceEntitity.endDate = anExp.endDate
        experienceEntitity.notes = anExp.notes
        
        // Obtain the park visit photo image from Assets.xcassets as UIImage
        let photoUIImage = UIImage(named: anExp.photoFilename)
        
        // Convert photoUIImage to data of type Data (Binary Data) in JPEG format with 100% quality
        let photoData = photoUIImage?.jpegData(compressionQuality: 1.0)
        
        // Assign photoData to Core Data entity attribute of type Data (Binary Data)
        experienceEntitity.photoFilename = photoData!
        
        experienceEntitity.photoDateTime = anExp.photoDateTime
        experienceEntitity.photoLatitude = anExp.photoLatitude as NSNumber
        experienceEntitity.photoLongitude = anExp.photoLongitude as NSNumber

        // ❎ Save Changes to Core Data Database
        PersistenceController.shared.saveContext()
        
    }   // End of for loop
}

public func createTripDatabase() {
    // ❎ Get object reference of Core Data managedObjectContext from the persistent container
    let managedObjectContext = PersistenceController.shared.persistentContainer.viewContext
    
    //----------------------------
    // ❎ Define the Fetch Request
    //----------------------------
    let fetchRequest = NSFetchRequest<TravelAid>(entityName: "TravelAid")
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "orderNumber", ascending: true)]
    
    var listOfAllTripEntitiesInDatabase = [TravelAid]()
    
    do {
        //-----------------------------
        // ❎ Execute the Fetch Request
        //-----------------------------
        listOfAllTripEntitiesInDatabase = try managedObjectContext.fetch(fetchRequest)
    } catch {
        print("Database Creation Failed!")
        return
    }
    
    if listOfAllTripEntitiesInDatabase.count > 0 {
        print("Database has already been created!")
        return
    }
    
    print("Database will be created!")
    
    
    var arrayOfTripStructs = [Travel]()
    arrayOfTripStructs = decodeJsonFileIntoArrayOfStructs(fullFilename: "TravelData.json", fileLocation: "Main Bundle")

    for anExp in arrayOfTripStructs {
        /*
         ===============================
         *   Trip Entity Creation   *
         ===============================
         */
        
        // 1️⃣ Create an instance of the Photo entity in managedObjectContext
        let experienceEntitity = TravelAid(context: managedObjectContext)
        
        // 2️⃣ Dress it up by specifying its attributes
        experienceEntitity.orderNumber = anExp.orderNumber as NSNumber
        experienceEntitity.title = anExp.title
        experienceEntitity.cost = anExp.cost as NSNumber
        experienceEntitity.rating = anExp.rating as NSNumber
        experienceEntitity.startDate = anExp.startDate
        experienceEntitity.endDate = anExp.endDate
        experienceEntitity.notes = anExp.notes

        
        // Obtain the park visit photo image from Assets.xcassets as UIImage
        let photoUIImage = UIImage(named: anExp.photoFilename)
        
        // Convert photoUIImage to data of type Data (Binary Data) in JPEG format with 100% quality
        let photoData = photoUIImage?.jpegData(compressionQuality: 1.0)
        
        // Assign photoData to Core Data entity attribute of type Data (Binary Data)
        experienceEntitity.photoFilename = photoData!
        
        experienceEntitity.photoDateTime = anExp.photoDateTime
        experienceEntitity.photoLatitude = anExp.photoLatitude as NSNumber
        experienceEntitity.photoLongitude = anExp.photoLongitude as NSNumber

        // ❎ Save Changes to Core Data Database
        PersistenceController.shared.saveContext()
        
    }   // End of for loop
}
public func readFormulaOneDataFiles() {
    videoStructList         = decodeJsonFileIntoArrayOfStructs(fullFilename: "VideosData.json", fileLocation: "Main Bundle")
    teamStructList         = decodeJsonFileIntoArrayOfStructs(fullFilename: "ConstructorData.json", fileLocation: "Main Bundle")
    photoStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: "PhotosData.json", fileLocation: "Main Bundle")
}


