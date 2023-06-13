//
//  BusinessItem.swift
//  TravelAid
//
//  Created by Osman Balci on 11/15/22.
//  Copyright © 2022 Jason Tran. All rights reserved.
//

import SwiftUI

struct BusinessItem: View {
    
    // Input Parameter
    let business: ApiBusinessStruct
   
    var body: some View {
        HStack {
            getImageFromUrl(url: business.image_url, defaultFilename: "ImageUnavailable")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80.0)
            
            VStack(alignment: .leading) {
                Text(business.name)
                HStack(spacing: 1){
                    Image(systemName: "phone")
                    Text(business.phone)
                }
                HStack(spacing: 1){
                    Text(String(business.rating))
                    Text("stars rating")
                }
                
            }
            .font(.system(size: 14))
        }
    }
}
