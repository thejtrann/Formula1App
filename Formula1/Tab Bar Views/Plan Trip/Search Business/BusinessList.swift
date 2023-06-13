//
//  BusinessList.swift
//  TravelAid
//
//  Created by Osman Balci on 11/15/22.
//  Copyright © 2022 Jason Tran. All rights reserved.
//
import SwiftUI

struct BusinessList: View {
    
    var body: some View {
        List {
            ForEach(foundBusinessList) { aBusiness in
                NavigationLink(destination: BusinessDetails(business: aBusiness)) {
                    BusinessItem(business: aBusiness)
                }
            }
        }
        .navigationBarTitle(Text("Business Search Results"), displayMode: .inline)
        
    }   // End of body
}
