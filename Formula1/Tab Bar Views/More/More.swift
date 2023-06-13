//
//  More.swift
//  Formula1
//
//  Created by Osman Balci and Jason Tran on 11/28/22.
//

import SwiftUI

struct More: View {

    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: SearchDriver()) {
                    HStack {
                        Image(systemName: "person.fill")
                            .imageScale(.large)
                            .font(Font.title.weight(.regular))
                            .frame(width: 60)
                        Text("Search Drivers with API")
                            .font(.system(size: 16))
                    }
                    .foregroundColor(.blue)
                }
                NavigationLink(destination: SearchCircuit()) {
                    HStack {
                        Image(systemName: "road.lanes")
                            .imageScale(.large)
                            .font(Font.title.weight(.regular))
                            .frame(width: 60)
                        Text("Search Circuits with API")
                            .font(.system(size: 16))
                    }
                    .foregroundColor(.blue)
                }
                NavigationLink(destination: TeamList()) {
                    HStack {
                        Image(systemName: "wrench.and.screwdriver")
                            .imageScale(.large)
                            .font(Font.title.weight(.regular))
                            .frame(width: 60)
                        Text("Formula 1 Teams")
                            .font(.system(size: 16))
                    }
                    .foregroundColor(.blue)
                }
                NavigationLink(destination: VideosList()) {
                    HStack {
                        Image(systemName: "video")
                            .imageScale(.large)
                            .font(Font.title.weight(.regular))
                            .frame(width: 60)
                        Text("Formula 1 Videos")
                            .font(.system(size: 16))
                    }
                    .foregroundColor(.blue)
                }
                NavigationLink(destination: Photos()) {
                    HStack {
                        Image(systemName: "photo")
                            .imageScale(.large)
                            .font(Font.title.weight(.regular))
                            .frame(width: 60)
                        Text("Formula 1 Photos")
                            .font(.system(size: 16))
                    }
                    .foregroundColor(.blue)
                }
                NavigationLink(destination: Settings()) {
                    HStack {
                        Image(systemName: "gear")
                            .imageScale(.large)
                            .font(Font.title.weight(.regular))
                            .frame(width: 60)
                        Text("Settings")
                            .font(.system(size: 16))
                    }
                    .foregroundColor(.blue)
                }
                
            }   // End of List
            .navigationBarTitle(Text("More"), displayMode: .inline)
            
        }   // End of NavigationView
        // Use single column navigation view for iPhone and iPad
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct More_Previews: PreviewProvider {
    static var previews: some View {
        More()
    }
}


