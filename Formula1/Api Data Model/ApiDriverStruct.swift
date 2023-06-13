//
//  ApiDriverStruct.swift
//  Formula1
//
//  Created by Jason Tran on 11/28/22.
//

import SwiftUI
 
struct ApiDriverStruct: Hashable, Decodable, Identifiable{
    var id : UUID
    var name: String
    var url: String
    var nationality: String
    var birthdate: String
    var birthplace: String
    var number: Int32
    var podiums: Int32
    
}
