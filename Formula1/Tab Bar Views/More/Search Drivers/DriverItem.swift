//
//  DriverItem.swift
//  Formula1
//
//  Created by Jason Tran and Osman Balci on 11/29/22.
//

import SwiftUI

struct DriverItem: View {
    
    // Input Parameter
    let driver: ApiDriverStruct
   
    var body: some View {
        HStack {
            getImageFromUrl(url: driver.url, defaultFilename: "ImageUnavailable")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80.0)
            
            VStack(alignment: .leading) {
                Text(driver.name)
                Text("#\(driver.number ?? 0)")
            }
            .font(.system(size: 14))
        }
    }
}
