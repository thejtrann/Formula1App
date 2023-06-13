//
//  DatabaseChange.swift
//  Formula1
//
//  Created by Osman Balci on 11/27/22.
//

import Combine
import SwiftUI

final class DatabaseChange: ObservableObject {

    /*
     The 'indicator' value will be toggled to indicate that the Core Data database
     has changed upon which all subscribing views shall refresh their views.
     */
    @Published var indicator = false
}
