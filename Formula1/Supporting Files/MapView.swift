//
//  MapView.swift
//  Formula1
//
//  Created by Osman Balci on 11/27/22.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: UIViewRepresentable {
    
    //=======================
    //   Input Parameters   |
    //=======================
    
    /*
     ------------------------- mapType possible values -------------------------------
     .standard
     A street map that shows the position of all roads and some road names.
     
     .satellite
     Satellite imagery of the area.
     
     .hybrid
     A satellite image of the area with road and road name information layered on top.
     
     .hybridFlyover     --> Globe View
     A hybrid satellite image with flyover data where available.
     
     .satelliteFlyover  --> Globe View
     A satellite image of the area with flyover data where available.
     ---------------------------------------------------------------------------------
     */
    var mapType: MKMapType
    
    // Map center coordinate latitude
    var latitude: Double
    
    // Map center coordinate longitude
    var longitude: Double
    
    // North-to-south and east-to-west distance from center
    var delta: Double
    
    // Delta unit = "degrees" or "meters"
    var deltaUnit: String
    
    // Annotation title and subtitle to be displayed on map center
    var annotationTitle: String
    var annotationSubtitle: String
    
    //==================
    //   Make UIView   |
    //==================
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    //====================
    //   Update UIView   |
    //====================
    func updateUIView(_ view: MKMapView, context: Context) {
        
        // Set map view attributes
        view.mapType = mapType
        view.isZoomEnabled = true
        view.isScrollEnabled = true
        view.isRotateEnabled = false
        
        if (mapType == .hybridFlyover || mapType == .satelliteFlyover) && latitude == 0 && longitude == 0 {
            
            //-------------------------------
            //   Show Only the Globe View   |
            //-------------------------------
            /*
             Create an instance from the MKCoordinateRegion() struct with .world parameter
             and store its instance reference into local variable mapRegion.
             The .world parameter defines the region as the entire world (globe).
             */
            let mapRegion = MKCoordinateRegion(.world)
            
            // Set the view to show the globe with animation
            view.setRegion(mapRegion, animated: true)
            
            return
        }
        
        //---------------------------
        //   Show Any Type of Map   |
        //---------------------------
        
        // Set Map's Center Location Coordinate
        let centerLocationCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        /*
         Create an instance from the MKCoordinateRegion() struct
         and store its instance reference into local variable mapRegion.
         */
        var mapRegion = MKCoordinateRegion()
        
        if deltaUnit == "degrees" {
            /*
             deltaUnit = "degrees" --> used for large maps such as a country map
                --------------------------------------------
                |   1 degree = 111 kilometers = 69 miles   |
                --------------------------------------------
             MKCoordinateSpan identifies width and height of a map region.
             latitudeDelta:   North-to-south distance in degrees to display in the map region.
             longitudeDelta:  East-to-west distance in degrees to display in the map region.
             */
            let mapSpan = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
            
            // Create a rectangular geographic map region around centerLocationCoordinate
            mapRegion = MKCoordinateRegion(center: centerLocationCoordinate, span: mapSpan)
            
        } else {
            /*
             deltaUnit = "meters" --> used for small maps such as a campus or city map
                ----------------------------------------------
                |   1609.344 meters = 1.609344 km = 1 mile   |
                ----------------------------------------------
             latitudinalMeters:   North-to-south distance in meters to display in the map region.
             longitudinalMeters:  East-to-west distance in meters to display in the map region.
             */
            
            // Create a rectangular geographic map region around centerLocationCoordinate
            mapRegion = MKCoordinateRegion(center: centerLocationCoordinate, latitudinalMeters: delta, longitudinalMeters: delta)
        }
        
        // Set the view to show the map region with animation
        view.setRegion(mapRegion, animated: true)
        
        //-----------------------------------------
        // Prepare and Set Annotation on Map Center
        //-----------------------------------------
        
        // Instantiate an object from the MKPointAnnotation() class and
        // store its object reference into local variable annotation
        let annotation = MKPointAnnotation()
        
        // Dress up the newly created MKPointAnnotation() object
        annotation.coordinate = centerLocationCoordinate
        annotation.title = annotationTitle
        annotation.subtitle = annotationSubtitle
        
        // Add the created and dressed up MKPointAnnotation() object to the map view
        view.addAnnotation(annotation)
    }
    
}





