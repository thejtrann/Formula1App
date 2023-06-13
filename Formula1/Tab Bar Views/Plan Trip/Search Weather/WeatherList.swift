//
//  WeatherList.swift
//  TravelAid
//
//  Created by Osman Balci on 11/15/22.
//  Copyright © 2022 Jason Tran. All rights reserved.
//
import SwiftUI

struct WeatherList: View {
    var body: some View {
        List {
            ForEach(foundWeatherList) { aWeather in
                NavigationLink(destination: WeatherDetails(weather: aWeather)) {
                    WeatherItem(weather: aWeather)
                }
            }
        }
        .navigationBarTitle(Text("Business Search Results"), displayMode: .inline)
        
    }   // End of body
}
