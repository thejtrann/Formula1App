//
//  NotFound.swift
//  Formula1
//
//  Created by Osman Balci on 11/27/22.
//

import SwiftUI
 
struct NotFound: View {
    
    // Input parameter
    let message: String
    
    var body: some View {
        ZStack {        // Color Background to Ivory
            Color(red: 1.0, green: 1.0, blue: 240/255)
            
            VStack {    // Foreground
                Image(systemName: "exclamationmark.triangle")
                    .imageScale(.large)
                    .font(Font.title.weight(.medium))
                    .foregroundColor(.red)
                    .padding()
                Text(message)
                    .fixedSize(horizontal: false, vertical: true)   // Allow lines to wrap around
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 128/255, green: 0.0, blue: 0.0))    // Maroon
                    .padding()
            }
        }
    }
}

struct NotFound_Previews: PreviewProvider {
    static var previews: some View {
        NotFound(message: "")
    }
}



