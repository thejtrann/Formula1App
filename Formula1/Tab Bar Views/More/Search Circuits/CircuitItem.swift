//
//  CircuitItem.swift
//  Formula1
//
//  Created by Jason Tran and Osman Balci on 12/5/22.
//

import SwiftUI

struct CircuitItem: View {
    
    // Input Parameter
    let circuit: ApiCircuitStruct
   
    var body: some View {
        HStack {
            getImageFromUrl(url: circuit.image, defaultFilename: "ImageUnavailable")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80.0)
            
            VStack(alignment: .leading) {
                Text(circuit.name)
                Text(circuit.competition)
                Text("\(circuit.city), \(circuit.country)")
            }
            .font(.system(size: 14))
        }
    }
}

