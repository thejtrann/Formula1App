//
//  TripList.swift
//  Formula1
//
//  Created by Ryan Tabor and Osman Balci on 7/25/22.
//  Copyright © 2022 Osman Balci. All rights reserved.
//

import SwiftUI
import CoreData

struct MyTrips: View {
    
    // ❎ CoreData managedObjectContext reference
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // ❎ CoreData FetchRequest returning all TravelAid entities in the database
    @FetchRequest(fetchRequest: TravelAid.allTravelsFetchRequest()) var allTravels: FetchedResults<TravelAid>
    
    // Subscribe to changes in Core Data database
    @EnvironmentObject var databaseChange: DatabaseChange
    
    @State private var toBeDeleted: IndexSet?
    @State private var showConfirmation = false
    
    var body: some View {
        NavigationView {
            List {
                /*
                 Each NSManagedObject has internally assigned unique ObjectIdentifier
                 used by ForEach to display allTravels in a dynamic scrollable list.
                 */
                ForEach(allTravels) { aTravel in
                    NavigationLink(destination: TravelDetails(travel: aTravel)) {
                        TravelItem(travel: aTravel)
                            .alert(isPresented: $showConfirmation) {
                                Alert(title: Text("Delete Confirmation"),
                                      message: Text("Are you sure to permanently delete the park visit? It cannot be undone."),
                                      primaryButton: .destructive(Text("Delete")) {
                                    /*
                                    'toBeDeleted (IndexSet).first' is an unsafe pointer to the index number of the array
                                     element to be deleted. It is nil if the array is empty. Process it as an optional.
                                    */
                                    if let index = toBeDeleted?.first {
                                       
                                        let travelToDelete = allTravels[index]
                                        
                                        // ❎ Delete Selected TravelAid entity from the database
                                        managedObjectContext.delete(travelToDelete)

                                        // ❎ Save Changes to Core Data Database
                                        PersistenceController.shared.saveContext()
                                        
                                        // Toggle database change indicator so that its subscribers can refresh their views
                                        databaseChange.indicator.toggle()
                                    }
                                    toBeDeleted = nil
                                }, secondaryButton: .cancel() {
                                    toBeDeleted = nil
                                }
                            )
                        }   // End of alert
                    }
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
                
            }   // End of List
                .navigationBarTitle(Text("My Trips"), displayMode: .inline)
                
                // Place the Edit button on left and Add (+) button on right of the navigation bar
                .navigationBarItems(leading: EditButton(), trailing:
                    NavigationLink(destination: AddTrip()) {
                        Image(systemName: "plus")
                })
            
        }   // End of NavigationView
        .customNavigationViewStyle()  // Given in NavigationStyle.swift
        
    }   // End of body var
    
    /*
     --------------------------------
     MARK: Delete Selected Park Visit
     --------------------------------
     */
    func delete(at offsets: IndexSet) {
        
         toBeDeleted = offsets
         showConfirmation = true
     }
    
    /*
     ------------------------------
     MARK: Move Selected Park Visit
     ------------------------------
     */
    private func move(from source: IndexSet, to destination: Int) {
        
        // Create an array of TravelAid entities from allTravels fetched from the database
        var arrayOfAllTravels: [TravelAid] = allTravels.map{ $0 }

        // ❎ Perform the move operation on the array
        arrayOfAllTravels.move(fromOffsets: source, toOffset: destination )

        /*
         'stride' returns a sequence from a starting value toward, and possibly including,
         an end value, stepping by the specified amount.
         
         Update the orderNumber attribute in reverse order starting from the end toward the first.
         */
        for index in stride(from: arrayOfAllTravels.count - 1, through: 0, by: -1) {
            
            arrayOfAllTravels[index].orderNumber = Int32(index) as NSNumber
        }
        
        // ❎ Save Changes to Core Data Database
        PersistenceController.shared.saveContext()
        
        // Toggle database change indicator so that its subscribers can refresh their views
        databaseChange.indicator.toggle()
    }

    
}
