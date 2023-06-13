//
//  TravelDetails.swift
//  TravelAid
//
//  Created by Ryan Tabor and Osman Balci on 5/31/22.
//  Copyright © 2022 Osman Balci. All rights reserved.
//

import SwiftUI
import MapKit

struct TravelDetails: View {
    
    // ❎ Input parameter: Core Data TravelAid Entity instance reference
    let travel: TravelAid
    
    // Subscribe to changes in Core Data database
    @EnvironmentObject var databaseChange: DatabaseChange
    
    @Environment(\.scenePhase) private var scenePhase
    
    //---------
    // Map View
    //---------
    @State private var selectedMapTypeIndex = 0
    var mapTypes = ["Standard", "Satellite", "Hybrid", "Globe"]
    
    //---------------
    // Alert Messages
    //---------------
    @State private var showAlertMessage = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        Form {
            Section(header: Text("Trip Title")) {
                Text(travel.title ?? "")
            }
            Section(header: Text("Trip Photo")) {
                getImageFromBinaryData(binaryData: travel.photoFilename,
                                       defaultFilename: "ImageUnavailable")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 200, maxWidth: 300, alignment: .center)
                    .padding()
            }
            Section(header: Text("Trip Rating out of 5 stars")) {
                HStack(spacing: 3) {
                    ForEach(1...(travel.rating as! Int), id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.blue)
                    }
                }
            }
            Section(header: Text("Trip Cost")) {
                Text("$\(travel.cost as! Int)")
            }
            Section(header: Text("Trip Start Date")) {
                Text(travel.startDate ?? "")
            }
            Section(header: Text("Trip End Date")) {
                Text(travel.endDate ?? "")
            }
            Section(header: Text("Select Map Type"), footer: Text("Map Provided by Apple Maps").italic()) {
               
                Picker("Select Map Type", selection: $selectedMapTypeIndex) {
                    ForEach(0 ..< mapTypes.count, id: \.self) { index in
                       Text(mapTypes[index])
                   }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
               
                NavigationLink(destination: photoLocationOnMap) {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .imageScale(.medium)
                            .font(Font.title.weight(.regular))
                        Text("Show Photo Location on Map")
                            .font(.system(size: 16))
                    }
                    .foregroundColor(.blue)
                }
            }
            Section(header: Text("Trip Notes")) {
                Text(travel.notes ?? "")
            }
            
        }   // End of Form
            .navigationBarTitle(Text("Trip Details"), displayMode: .inline)
            .font(.system(size: 14))
            .alert(alertTitle, isPresented: $showAlertMessage, actions: {
                  Button("OK") {}
                }, message: {
                  Text(alertMessage)
                })
            }
    var photoLocationOnMap: some View {
       
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
                    latitude: travel.photoLatitude as! Double,
                    longitude: travel.photoLongitude as! Double,
                    delta: 15.0,
                    deltaUnit: "degrees",
                    annotationTitle: travel.title!,
                    annotationSubtitle: travel.photoDateTime ?? "")
            
                .navigationBarTitle(Text(travel.title!), displayMode: .inline)
        )
    }
        
    }   // End of body var
    
    



