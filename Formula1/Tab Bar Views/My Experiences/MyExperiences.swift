//
//  MyExperiences.swift
//  Formula1
//
//  Created by Jason Tran and Osman Balci on 11/28/22.
//

import SwiftUI
import CoreData

struct MyExperiences: View {
    
    // ❎ CoreData managedObjectContext reference
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // ❎ CoreData FetchRequest returning all ParkVisit entities in the database
    @FetchRequest(fetchRequest: Experience.allExpsFetchRequest()) var allExps: FetchedResults<Experience>
    
    // Subscribe to changes in Core Data database
    @EnvironmentObject var databaseChange: DatabaseChange
    
    @State private var toBeDeleted: IndexSet?
    @State private var showConfirmation = false
    
    var body: some View {
        NavigationView {
            List {
                /*
                 Each NSManagedObject has internally assigned unique ObjectIdentifier
                 used by ForEach to display allTrips in a dynamic scrollable list.
                 */
                ForEach(allExps) { anExp in
                    NavigationLink(destination: ExperienceDetails(experience: anExp)) {
                        ExperienceItem(experience: anExp)
                            .alert(isPresented: $showConfirmation) {
                                Alert(title: Text("Delete Confirmation"),
                                      message: Text("Are you sure to permanently delete the experience? It cannot be undone."),
                                      primaryButton: .destructive(Text("Delete")) {
                                    /*
                                    'toBeDeleted (IndexSet).first' is an unsafe pointer to the index number of the array
                                     element to be deleted. It is nil if the array is empty. Process it as an optional.
                                    */
                                    if let index = toBeDeleted?.first {
                                       
                                        let experienceToDelete = allExps[index]
                                        
                                        // ❎ Delete Selected ParkVisit entity from the database
                                        managedObjectContext.delete(experienceToDelete)

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
                .navigationBarTitle(Text("My Experiences"), displayMode: .inline)
                
                // Place the Edit button on left and Add (+) button on right of the navigation bar
                .navigationBarItems(leading: EditButton(), trailing:
                    NavigationLink(destination: AddExperience()) {
                        Image(systemName: "plus")
                })
            
        }   // End of NavigationView
        .customNavigationViewStyle()  // Given in NavigationStyle.swift
        
    }   // End of body var
    
    /*
     --------------------------------
     MARK: Delete Selected Trip
     --------------------------------
     */
    func delete(at offsets: IndexSet) {
        
         toBeDeleted = offsets
         showConfirmation = true
     }
    
    /*
     ------------------------------
     MARK: Move Selected Trip
     ------------------------------
     */
    private func move(from source: IndexSet, to destination: Int) {
        
        // Create an array of Trip entities from allTrips fetched from the database
        var arrayOfAllExperiences: [Experience] = allExps.map{ $0 }

        // ❎ Perform the move operation on the array
        arrayOfAllExperiences.move(fromOffsets: source, toOffset: destination )

        /*
         'stride' returns a sequence from a starting value toward, and possibly including,
         an end value, stepping by the specified amount.
         
         Update the orderNumber attribute in reverse order starting from the end toward the first.
         */
        for index in stride(from: arrayOfAllExperiences.count - 1, through: 0, by: -1) {
            
            arrayOfAllExperiences[index].orderNumber = Int32(index) as NSNumber
        }
        
        // ❎ Save Changes to Core Data Database
        PersistenceController.shared.saveContext()
        
        // Toggle database change indicator so that its subscribers can refresh their views
        databaseChange.indicator.toggle()
    }

    
}

struct MyExperiences_Previews: PreviewProvider {
    static var previews: some View {
        MyExperiences()
    }
}


