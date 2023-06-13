//
//  MainView.swift
//  Formula1
//
//  Created by Osman Balci on 12/4/22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            
            Home()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            MyExperiences()
                .tabItem {
                    Image(systemName: "car")
                    Text("My Experiences")
            }
            
            ExperienceOnMap()
                .tabItem {
                    Image(systemName: "mappin.and.ellipse")
                    Text("Experience on Map")
            }
            PlanTrip()
                .tabItem {
                    Image(systemName: "airplane")
                    Text("Plan Trip")
            }
            More()
                .tabItem {
                    Image(systemName: "ellipsis")
                    Text("More")
                }
             
        }   // End of TabView
            .font(.headline)
            .imageScale(.medium)
            .font(Font.title.weight(.regular))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

