
//  TravelItem.swift
//  TravelAid
//
//  Created by Ryan Tabor and Osman Balci on 4/6/22.
//  Copyright © 2022 Osman Balci. All rights reserved.
//

import SwiftUI

struct TravelItem: View {
    
    // ❎ Input parameter: CoreData TravelAid Entity instance reference
    let travel: TravelAid
    
    // Subscribe to changes in Core Data database
    @EnvironmentObject var databaseChange: DatabaseChange
    
    var body: some View {
        HStack {
            // This function is given in UtilityFunctions.swift
            getImageFromBinaryData(binaryData: travel.photoFilename,
                                   defaultFilename: "ImageUnavailable")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80.0, height: 60.0)
            
            VStack(alignment: .leading) {
                Text(travel.title ?? "")
                
                HStack(spacing: 3) {
                    ForEach(1...(travel.rating as! Int), id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.gray)
                    }
                }
                    Text("From: \(travel.startDate ?? "")")
                    
                    Text("To: \(travel.endDate ?? "")")
                    
                }
                
            }
            // Set font and size for the whole VStack content
            .font(.system(size: 14))
        }
    }
