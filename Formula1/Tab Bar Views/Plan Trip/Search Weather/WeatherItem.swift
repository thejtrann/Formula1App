//
//  WeatherItem.swift
//  TravelAid
//
//  Created by Osman Balci on 11/15/22.
//  Copyright © 2022 Jason Tran. All rights reserved.
//

import SwiftUI

struct WeatherItem: View {
    
    // Input Parameter
    let weather: ApiWeatherStruct
   
    var body: some View {
        HStack {
            getImageFromUrl(url: "https://openweathermap.org/img/wn/\(weather.icon)@2x.png", defaultFilename: "ImageUnavailable")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80.0)
            
            VStack(alignment: .leading) {
                Text(weather.dt_txt)
                Text(weather.description)
                Text("Humidity: \(weather.humidity)%")
                
            }
            .font(.system(size: 14))
        }
    }
}
