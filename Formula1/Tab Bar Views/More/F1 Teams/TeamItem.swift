//
//  TeamItem.swift
//  Formula1
//
//  Created by Jason Tran and Osman Balci on 12/5/22.
//

import SwiftUI

struct TeamItem: View {
    
    // Input Parameter
    let team: Team
   
    var body: some View {
        HStack {
            getImageFromUrl(url: team.logo, defaultFilename: "ImageUnavailable")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80.0)
            
            VStack(alignment: .leading) {
                Text(team.name)
                Text(team.base)
            }
            .font(.system(size: 14))
        }
    }
}
