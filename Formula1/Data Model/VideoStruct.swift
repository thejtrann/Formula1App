//
//  VideoStruct.swift
//  Formula1
//
//  Created by Jason Tran on 11/28/22.
//

import SwiftUI

struct Video: Hashable, Codable, Identifiable {
    
    var id: Int
    var title: String
    var youTubeId: String
    var releaseDate: String
    var duration: String        // hh:mm:ss
}
