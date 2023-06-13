//
//  TravelAid.swift
//  Formula1
//
//  Created by Ryan Tabor and Osman Balci on 7/3/22.
//  Copyright © 2022 Osman Balci. All rights reserved.
//

import Foundation
import CoreData

/*
 🔴 Set Current Product Module:
    In xcdatamodeld editor, select Trip, show Data Model Inspector, and
    select Current Product Module from Module menu.
 🔴 Turn off Auto Code Generation:
    In xcdatamodeld editor, select Trip, show Data Model Inspector, and
    select Manual/None from Codegen menu.
*/

// ❎ Core Data ParkVisit entity public class
public class TravelAid: NSManagedObject, Identifiable {

    // Attributes
    @NSManaged public var orderNumber: NSNumber?
    @NSManaged public var title: String?
    @NSManaged public var cost: NSNumber?
    @NSManaged public var rating: NSNumber?
    @NSManaged public var startDate: String?
    @NSManaged public var endDate: String?
    @NSManaged public var notes: String?
    @NSManaged public var photoFilename: Data?
    @NSManaged public var photoDateTime: String?
    @NSManaged public var photoLatitude: NSNumber?
    @NSManaged public var photoLongitude: NSNumber?
    
}

extension TravelAid {
    /*
     ❎ CoreData @FetchRequest in ParksVisited.swift, ParkItem.swift, and ParkDetails.swift
        invokes this class method to fetch all of the ParkVisit entities from the database.
        The 'static' keyword designates the func as a class method invoked by using the
        class name as ParkVisit.allParkVisitsFetchRequest() in any .swift file in your project.
     */
    static func allTravelsFetchRequest() -> NSFetchRequest<TravelAid> {
        /*
         Create a fetchRequest to fetch ParkVisit entities from the database.
         Since the fetchRequest's 'predicate' property is not set to filter,
         all of the ParkVisit entities will be fetched.
         */
        let fetchRequest = NSFetchRequest<TravelAid>(entityName: "TravelAid")
        
        fetchRequest.sortDescriptors = [
            // List the fetched ParkVisit entities in ascending order with respect to orderNumber
            NSSortDescriptor(key: "orderNumber", ascending: true)
        ]
        
        return fetchRequest
    }
}
