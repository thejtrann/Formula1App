//
//  Experience.swift
//  Formula1
//
//  Created by Jason Tran and Osman Balci on 11/27/22.
//

import Foundation
import CoreData

// ❎ Core Data Trip entity public class
public class Experience: NSManagedObject, Identifiable {

    // Attributes
    @NSManaged public var orderNumber: NSNumber?
    @NSManaged public var title: String?
    @NSManaged public var circuit: String?
    @NSManaged public var startDate: String?
    @NSManaged public var endDate: String?
    @NSManaged public var notes: String?
    @NSManaged public var photoFilename: Data?
    @NSManaged public var photoDateTime: String?
    @NSManaged public var photoLatitude: NSNumber?
    @NSManaged public var photoLongitude: NSNumber?
    
    // Relationships

}

extension Experience {
    /*
     ❎ CoreData @FetchRequest in FavoritesList.swift invokes this class method
        to fetch all of the Trip entities from the database.
        The 'static' keyword designates the func as a class method invoked by using the
        class name as Company.allTripsFetchRequest() in any .swift file in your project.
     */
    static func allExpsFetchRequest() -> NSFetchRequest<Experience> {
        /*
         Create a fetchRequest to fetch Trip entities from the database.
         Since the fetchRequest's 'predicate' property is not set to filter,
         all of the Trip entities will be fetched.
         */
        let fetchRequest = NSFetchRequest<Experience>(entityName: "Experience")

        fetchRequest.sortDescriptors = [
            // List the fetched Trip entities in ascending order with respect to orderNumber
            NSSortDescriptor(key: "orderNumber", ascending: true)
        ]
        
        return fetchRequest
    }

}




