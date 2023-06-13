//
//  ExpOnMapDetails.swift
//  Formula1
//
//  Created by Osman Balci on 11/28/22.
//

import SwiftUI
import MapKit
import AVKit

struct ExpOnMapDetails: View {
    
    // ❎ Input parameter: Core Data ParkVisit Entity instance reference
    let experience: Experience
    
    // Subscribe to changes in Core Data database
    @EnvironmentObject var databaseChange: DatabaseChange
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        Form {
            Section(header: Text("Experience Title")) {
                Text(experience.title ?? "")
            }
            Section(header: Text("Experience Photo")) {
                getImageFromBinaryData(binaryData: experience.photoFilename, defaultFilename: "ImageUnavailable")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 300, maxWidth: 500, alignment: .center)
            }
            Section(header: Text("Circuit")) {
                Text(experience.circuit ?? "")
            }
            Section(header: Text("Trip Start Date")) {
                Text(experience.startDate ?? "")
            }
            Section(header: Text("Trip End Date")) {
                Text(experience.endDate ?? "")
            }
        }   // End of Form
        .navigationBarTitle(Text("Experience Details"), displayMode: .inline)
        .font(.system(size: 14))
    }   // End of body var
}




