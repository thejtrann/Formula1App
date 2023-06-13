//
//  ExperienceDetails.swift
//  Formula1
//
//  Created by Jason Tran and Osman Balci on 11/28/22.
//

import SwiftUI
import MapKit
import AVFoundation

struct ExperienceDetails: View {
    
    // ❎ Input parameter: Core Data ParkVisit Entity instance reference
    let experience: Experience
    
    // Subscribe to changes in Core Data database
    @EnvironmentObject var databaseChange: DatabaseChange
    
    @Environment(\.scenePhase) private var scenePhase
    
    //---------------
    // Alert Messages
    //---------------
    @State private var showAlertMessage = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        Form {
            Section(header: Text("Experience Title")) {
                Text(experience.title ?? "")
            }
            Section(header: Text("Trip Photo")) {
                getImageFromBinaryData(binaryData: experience.photoFilename, defaultFilename: "ImageUnavailable")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 300, maxWidth: 500, alignment: .center)
            }
            Section(header: Text("Experience Circuit")) {
                Text(experience.circuit ?? "")
            }
            Section(header: Text("Trip Start Date")) {
                Text(experience.startDate ?? "")
            }
            Section(header: Text("Trip End Date")) {
                Text(experience.endDate ?? "")
            }
            Section(header: Text("Select Map Type")) {
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
                Text(experience.notes ?? "")
            }
            
            
        }   // End of Form
        .navigationBarTitle(Text("Experience Details"), displayMode: .inline)
        .font(.system(size: 14))
        .alert(alertTitle, isPresented: $showAlertMessage, actions: {
            Button("OK") {}
        }, message: {
            Text(alertMessage)
        })
    }   // End of body var
    
    var photoLocationOnMap: some View {
        var mapType: MKMapType
        mapType = MKMapType.standard
        
        return AnyView(
            MapView(mapType: mapType,
                    latitude: experience.photoLatitude as! Double,
                    longitude: experience.photoLongitude as! Double,
                    delta: 15.0,
                    deltaUnit: "degrees",
                    annotationTitle: experience.title!,
                    annotationSubtitle: experience.photoDateTime!)
            
            .navigationBarTitle(Text(experience.title!), displayMode: .inline)
        )
    }
}
