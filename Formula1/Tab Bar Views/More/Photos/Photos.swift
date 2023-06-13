//
//  Photos.swift
//  Formula1
//
//  Created by Ryan Tabor and Osman Balci on 9/16/22.
//  Copyright © 2022 Osman Balci. All rights reserved.
//

import SwiftUI

// Preserve selected background color between views
fileprivate var selectedColor = Color.gray.opacity(0.1)

struct Photos: View {
    
    // Default selected background color
    @State private var selectedBgColor = Color.gray.opacity(0.1)
    
    var body: some View {
        ZStack {            // Background
            // Color entire background with selected color
            selectedBgColor
            
            // Place color picker at upper right corner
            VStack {        // Foreground
                HStack {
                    Spacer()
                    ColorPicker("", selection: $selectedBgColor)
                        .padding()
                }
                Spacer()
                TabView {
                    ForEach(photoStructList) { photo in
                        VStack {
                                Text(photo.title)
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.blue)
                                    .padding()
                            
                            Image(photo.filename)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }   // End of TabView
                .tabViewStyle(PageTabViewStyle())
                .onAppear() {
                    UIPageControl.appearance().currentPageIndicatorTintColor = .black
                    UIPageControl.appearance().pageIndicatorTintColor = .gray
                }
                
            }   // End of VStack
            .navigationBarTitle(Text("Formula 1 Photos"), displayMode: .inline)
            .onAppear() {
                selectedBgColor = selectedColor
            }
            .onDisappear() {
                selectedColor = selectedBgColor
            }
        }   // End of ZStack
    }   // End of body var
}

struct Photos_Previews: PreviewProvider {
    static var previews: some View {
        Photos()
    }
}

