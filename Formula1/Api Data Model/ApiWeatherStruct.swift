//
//  ApiWeatherStruct.swift
//  Formula1
//
//  Created by Ryan Tabor on 12/5/22.
//

import SwiftUI
 
struct ApiWeatherStruct: Hashable, Decodable, Identifiable{
    var id : UUID
    var temp_min: Double
    var temp_max: Double
    var humidity: Int
    var description: String
    var icon: String
    var dt_txt: String
    var name: String
    var latitude: Double
    var longitude: Double
    var country: String
}
