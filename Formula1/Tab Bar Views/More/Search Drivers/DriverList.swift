//
//  DriverList.swift
//  Formula1
//
//  Created by Jason Tran and Osman Balci on 11/29/22.
//

import SwiftUI

struct DriverList: View {
    var body: some View {
        List {
            ForEach(foundDriverList) { aDriver in
                NavigationLink(destination: DriverDetails(driver: aDriver)) {
                    DriverItem(driver: aDriver)
                }
            }
        }
        .navigationBarTitle(Text("Driver Search Results"), displayMode: .inline)
        
    }   // End of body
}
