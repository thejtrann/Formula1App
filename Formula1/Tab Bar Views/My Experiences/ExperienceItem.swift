//
//  ExperienceItem.swift
//  Formula1
//
//  Created by Jason Tran and Osman Balci on 11/28/22.
//

import SwiftUI

struct ExperienceItem: View {
    
    // ❎ Input parameter: CoreData Trip Entity instance reference
    let experience: Experience
    
    // Subscribe to changes in Core Data database
    @EnvironmentObject var databaseChange: DatabaseChange
    
    var body: some View {
        HStack {
            // This function is given in UtilityFunctions.swift
            getImageFromBinaryData(binaryData: experience.photoFilename, defaultFilename: "ImageUnavailable")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80.0, height: 60.0)
            
            VStack(alignment: .leading) {
                Text(experience.title ?? "")
                Text(experience.circuit ?? "")
                Text("From: \(experience.startDate ?? "")")
                Text("To: \(experience.endDate ?? "")")
            }
                // Set font and size for the whole VStack content
                .font(.system(size: 14))
        }
    }
}
