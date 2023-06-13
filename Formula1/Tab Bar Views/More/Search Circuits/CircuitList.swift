//
//  CircuitList.swift
//  Formula1
//
//  Created by Jason Tran and Osman Balci on 12/5/22.
//

import SwiftUI

struct CircuitList: View {
    var body: some View {
        List {
            ForEach(foundCircuitList) { aCircuit in
                NavigationLink(destination: CircuitDetails(circuit: aCircuit)) {
                    CircuitItem(circuit: aCircuit)
                }
            }
        }
        .navigationBarTitle(Text("Circuit Search Results"), displayMode: .inline)
        
    }   // End of body
}

