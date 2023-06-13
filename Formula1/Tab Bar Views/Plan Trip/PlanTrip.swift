//
//  PlanTrip.swift
//  Formula1
//
//  Created by Jason Tran and Osman Balci on 11/28/22.
//


import SwiftUI

struct PlanTrip: View {

    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: SearchBusiness()) {
                    HStack {
                        Image(systemName: "magnifyingglass.circle")
                            .imageScale(.large)
                            .font(Font.title.weight(.regular))
                            .frame(width: 60)
                        Text("Search Yelp API for Hotels")
                            .font(.system(size: 16))
                    }
                    .foregroundColor(.blue)
                }
                NavigationLink(destination: SearchWeather()) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .imageScale(.large)
                            .font(Font.title.weight(.regular))
                            .frame(width: 60)
                        Text("Search Weather at Location")
                            .font(.system(size: 16))
                    }
                    .foregroundColor(.blue)
                }
                NavigationLink(destination: MyTrips()) {
                    HStack {
                        Image(systemName: "airplane")
                            .imageScale(.large)
                            .font(Font.title.weight(.regular))
                            .frame(width: 60)
                        Text("Planned Trips")
                            .font(.system(size: 16))
                    }
                    .foregroundColor(.blue)
                }
                
            }   // End of List
            .navigationBarTitle(Text("Plan Trip"), displayMode: .inline)
            
        }   // End of NavigationView
        // Use single column navigation view for iPhone and iPad
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct PlanTrip_Previews: PreviewProvider {
    static var previews: some View {
        PlanTrip()
    }
}



