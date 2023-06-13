//
//  ApiBusinessStruct.swift
//  Formula1
//
//  Created by Jason Tran on 12/5/22.
//

import SwiftUI
 
struct ApiBusinessStruct: Hashable, Decodable, Identifiable{
    var id : UUID
    var latitude: Double
    var longitude: Double
    var phone: String
    var image_url: String
    var address1: String
    var address2: String
    var address3: String
    var city: String
    var country: String
    var state: String
    var zip_code: String
    var name: String
    var rating: Double
    var review_count: Int
    var url: String
}
