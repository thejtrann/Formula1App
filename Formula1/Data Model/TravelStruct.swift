//
//  TravelStruct.swift
//  Formula1
//
//  Created by Ryan Tabor on 11/15/22.
//  Copyright © 2022 Ryan Tabor. All rights reserved.
//

import Foundation

//-------------------------------------------------------
// NationalParkVisit struct is used only for creating the
// National Park Visits database upon first app launch.
//-------------------------------------------------------

struct Travel: Hashable, Codable {
    
    var orderNumber: Int
    var title: String
    var cost: Double
    var rating: Int
    var startDate: String
    var endDate: String
    var notes: String
    var photoFilename: String
    var photoDateTime: String
    var photoLatitude: Double
    var photoLongitude: Double
}

