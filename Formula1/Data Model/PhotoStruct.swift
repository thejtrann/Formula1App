//
//  PhotoStruct.swift
//  Formula1
//
//  Created by Ryan Tabor on 9/16/22.
//  Copyright © 2022 Ryan Tabor. All rights reserved.
//

import SwiftUI

struct Photo: Hashable, Codable, Identifiable {
    var id: Int
    var title: String
    var filename: String
}
