//
//  DriverDetails.swift
//  Formula1
//
//  Created by Jason Tran and Osman Balci on 11/29/22.
//

import SwiftUI
import CoreData
import MapKit

struct DriverDetails: View {
    
    // Input Parameter
    let driver: ApiDriverStruct
    
    @State private var selectedMapTypeIndex = 0
    var mapTypes = ["Standard", "Satellite", "Hybrid", "Globe"]
    
    
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
                Section(header: Text("Driver Name")) {
                    Text(driver.name)
                }
                Section(header: Text("Driver Number")) {
                    Text("\(driver.number ?? 0)")
                }
                Section(header: Text("Driver Image")) {
                    getImageFromUrl(url: driver.url, defaultFilename: "ImageUnavailable")
                }
                Section(header: Text("Driver Nationality")) {
                    Text(driver.nationality)
                }
                Section(header: Text("Driver Birthdate")) {
                    Text(driver.birthdate)
                }
                Section(header: Text("Driver Birthplace")) {
                    Text(driver.birthplace)
                }
                Section(header: Text("Driver Podium Count")) {
                    Text("\(driver.podiums ?? 0)")
                }
                
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
