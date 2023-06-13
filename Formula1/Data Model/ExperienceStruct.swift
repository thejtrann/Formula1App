//
//  ExperienceStruct.swift
//  Formula1
//
//  Created by Jason Tran on 11/27/22.
//

import Foundation

struct ExperienceStruct: Hashable, Codable{
    
    var orderNumber: Int32
    var title: String
    var circuit: String
    var startDate: String
    var endDate: String
    var notes: String
    var photoFilename: String
    //var videoFilename: String
    var photoDateTime: String
    var photoLatitude: Double
    var photoLongitude: Double
}
