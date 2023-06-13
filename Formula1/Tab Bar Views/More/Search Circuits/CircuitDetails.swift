//
//  CircuitDetails.swift
//  Formula1
//
//  Created by Jason Tran and Osman Balci on 12/5/22.
//

import SwiftUI
import CoreData
import MapKit

struct CircuitDetails: View {
    
    // Input Parameter
    let circuit: ApiCircuitStruct
    
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
                Section(header: Text("Circuit Name")) {
                    Text(circuit.name)
                }
                Section(header: Text("Circuit Image")) {
                    getImageFromUrl(url: circuit.image, defaultFilename: "ImageUnavailable")
                }
                Section(header: Text("Circuit Competition")) {
                    Text(circuit.competition)
                }
                Section(header: Text("Circuit City")) {
                    Text(circuit.city)
                }
                Section(header: Text("Circuit Country")) {
                    Text(circuit.country)
                }
                Section(header: Text("First Grand Prix")) {
                    Text("\(circuit.firstGp ?? 0)")
                }
                Section(header: Text("Number of Laps")) {
                    Text("\(circuit.laps ?? 0)")
                }
                Section(header: Text("Circuit Record")) {
                    Text("\(circuit.recordTime)\n\(circuit.recordHolder)\n\(circuit.recordYear)")
                }
                
                
                
                /**
                 var id : UUID
                 var name: String
                 var image: String
                 var competition: String
                 var country: String
                 var city: String
                 var firstGp: Int32
                 var laps: Int32
                 var recordTime: String
                 var recordHolder: String
                 var recordYear: String
                 */
            }
            
        }   // End of Form
        .alert(alertTitle, isPresented: $showAlertMessage, actions: {
            Button("OK") {}
        }, message: {
            Text(alertMessage)
        })
        .navigationBarTitle(Text("Driver Details"), displayMode: .inline)
        .font(.system(size: 14))
    }
}
