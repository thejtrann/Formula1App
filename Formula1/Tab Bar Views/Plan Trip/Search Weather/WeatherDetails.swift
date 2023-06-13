//
//  WeatherDetails.swift
//  TravelAid
//
//  Created by Osman Balci on 11/15/22.
//  Copyright © 2022 Jason Tran. All rights reserved.
//

import SwiftUI
import CoreData
import MapKit

struct WeatherDetails: View {
    
    // Input Parameter
    let weather: ApiWeatherStruct
    
    @State private var selectedMapTypeIndex = 0
    var mapTypes = ["Standard", "Satellite", "Hybrid", "Globe"]
    
    
    // Enable this view to be dismissed to go back to the previous view
    @Environment(\.dismiss) private var dismiss
    
    // Subscribe to changes in Core Data database
    @EnvironmentObject var databaseChange: DatabaseChange
    
    //---------------
    // Alert Messages
    //---------------
    @State private var showAlertMessage = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        Form {
            Group {
                Section(header: Text("Forecast Location")) {
                    Text("\(weather.name), \(weather.country)")
                }
                Section(header: Text("Show Forcast Location on Map")) {
                    
                    Picker("Select Map Type", selection: $selectedMapTypeIndex) {
                        ForEach(0 ..< mapTypes.count, id: \.self) { index in
                            Text(mapTypes[index])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    
                    NavigationLink(destination: entryLocationOnMap) {
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                            Text("Show Diary Entry Location on Map")
                                .font(.system(size: 16))
                        }
                        .foregroundColor(.blue)
                    }
                }
                Section(header: Text("Date and Time 3-Hour Forecast")) {
                    Text(weather.dt_txt)
                }
                
                Section(header: Text("Weather Icon")) {
                    getImageFromUrl(url: "https://openweathermap.org/img/wn/\(weather.icon)@2x.png", defaultFilename: "ImageUnavailable")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300)
                }
                Section(header: Text("Description")) {
                    Text(weather.description)
                }
                Section(header: Text("Humidity Percentage")) {
                    Text("\(weather.humidity)%")
                }
                Section(header: Text("Minimum Temperature")) {
                    let min = String(format: "%.2f", weather.temp_min)
                    Text("\(min)°F")
                }
                Section(header: Text("Maximum Temperature")) {
                    let max = String(format: "%.2f", weather.temp_max)
                    Text("\(max)°F")
                }
            }
            
        }   // End of Form
        .alert(alertTitle, isPresented: $showAlertMessage, actions: {
            Button("OK") {}
        }, message: {
            Text(alertMessage)
        })
        .navigationBarTitle(Text("3-Hour Forecast"), displayMode: .inline)
        .font(.system(size: 14))
    }
    var entryLocationOnMap: some View {
        
        var mapType: MKMapType
        
        switch selectedMapTypeIndex {
        case 0:
            mapType = MKMapType.standard
        case 1:
            mapType = MKMapType.satellite
        case 2:
            mapType = MKMapType.hybrid
        case 3:
            mapType = MKMapType.hybridFlyover   // Globe
        default:
            fatalError("Map type is out of range!")
        }
        
        return AnyView(
            MapView(mapType: mapType,
                    latitude: weather.latitude,
                    longitude: weather.longitude,
                    delta: 15.0,
                    deltaUnit: "degrees",
                    annotationTitle: weather.name,
                    annotationSubtitle: weather.country)
            
            .navigationBarTitle(Text("\(weather.name), \(weather.country)"), displayMode: .inline)
        )
    }
}





