//
//  ExperienceOnMap.swift
//  Formula1
//
//  Created by Osman Balci on 11/28/22.
//

import SwiftUI
import CoreData
import CoreLocation
import MapKit

struct Location: Identifiable {
    var id = UUID()
    var experience: Experience
    var coordinate: CLLocationCoordinate2D
}

struct ExperienceOnMap: View {
    
    // ❎ CoreData managedObjectContext reference
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // ❎ CoreData FetchRequest returning all ParkVisit entities in the database
    @FetchRequest(fetchRequest: Experience.allExpsFetchRequest()) var allExps: FetchedResults<Experience>
    
    // Subscribe to changes in Core Data database
    @EnvironmentObject var databaseChange: DatabaseChange
    
    // Map Coordinate Region
    @State private var coordinateRegion = MKCoordinateRegion(
        // Washington, D.C. is the center point of the map
        center: CLLocationCoordinate2D(
            latitude: 38.89511,
            longitude: -77.03637
        ),
        // Delta is in degrees. 1 degree = 69 miles (111 kilometers)
        span: MKCoordinateSpan(
            latitudeDelta: 100,
            longitudeDelta: 100
        )
    )
    
    var body: some View {
        NavigationView {
            photoAnnotations
                .navigationBarTitle(Text("My Experiences on Map"), displayMode: .inline)
        }
    }
    
    var photoAnnotations: some View {
        
        // Initialize the list of Location annotations
        var annotations = [Location]()
        
        // Build the list of Location annotations
        for entry in allExps {
            annotations.append(
                Location(experience: entry,
                         coordinate: CLLocationCoordinate2D(latitude: entry.photoLatitude as! CLLocationDegrees,
                                                            longitude: entry.photoLongitude as! CLLocationDegrees))
            )
        }
        
        // Return the map showing the list of Location annotations
        return AnyView(
            Map(coordinateRegion: $coordinateRegion,
                interactionModes: .all,
                showsUserLocation: false,
                annotationItems: annotations)
            { item in
                MapAnnotation(coordinate: item.coordinate) {
                    AnnotationView(entry: item.experience)
                }
            }
        )
    }
}

/*
 ============================
 MARK: Custom Annotation View
 ============================
 */
struct AnnotationView: View {
    
    let entry: Experience
    
    let mapTypes = ["Standard", "Satellite", "Hybrid"]
    @State private var selectedMapTypeIndex = 2         // Hybrid
    
    @State private var showPhotoTitle = false
    
    var body: some View {
        VStack(spacing: 0) {
            if showPhotoTitle {
                NavigationLink(destination: ExpOnMapDetails(experience: entry)) {
                    Text(entry.title ?? "")
                        .font(.caption)
                        .padding(5)
                        .background(Color.white)
                        .foregroundColor(Color.black)
                        .cornerRadius(10)
                    // Prevent title truncation
                        .fixedSize(horizontal: true, vertical: false)
                }
            }
            Image(systemName: "mappin")
                .imageScale(.large)
                .font(Font.title.weight(.regular))
                .foregroundColor(.red)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        showPhotoTitle.toggle()
                    }
                }
        }
    }
    
    var mapTypePicker: some View {
        Picker("Select Map Type", selection: $selectedMapTypeIndex) {
            ForEach(0 ..< mapTypes.count, id: \.self) { index in
                Text(mapTypes[index]).tag(index)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
    }
}

struct ExperienceOnMap_Previews: PreviewProvider {
    static var previews: some View {
        ExperienceOnMap()
    }
}

