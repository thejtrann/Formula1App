//
//  ApiCircuitStruct.swift
//  Formula1
//
//  Created by Jason Tran on 12/5/22.
//

import SwiftUI
 
struct ApiCircuitStruct: Hashable, Decodable, Identifiable{
    var id : UUID
    var name: String
    var image: String
    var competition: String
    var country: String
    var city: String
    var firstGp: Int32
    var laps: Int32
    var recordTime: String
    var recordHolder: String
    var recordYear: String
}
