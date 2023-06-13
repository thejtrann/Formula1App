//
//  AppDelegate.swift
//  Formula1
//
//  Created by Osman Balci on 11/27/22.
//

import SwiftUI
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        /*
        ***********************************
        *   Create Experience Database   *
        ***********************************
        */
        createExperienceDatabase()      // Given in ExperienceData.swift
        createTripDatabase()
        getPermissionForLocation()              // In CurrentLocation.swift
        
        /*
         ******************************************
         Read Formula 1 Data Files upon App Launch
         ******************************************
         */
        readFormulaOneDataFiles()
        
        return true
    }
}
