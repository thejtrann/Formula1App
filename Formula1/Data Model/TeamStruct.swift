//
//  TeamStruct.swift
//  Formula1
//
//  Created by Jason Tran on 12/5/22.
//

import SwiftUI

struct Team: Hashable, Codable, Identifiable {
    
    var id: Int
    var name: String
    var base: String
    var email: String
    var website: String
    var logo: String
    var teamChief: String
    var driverName1: String
    var driverName2: String
}

/*
 "id": 1,
 "name": "Oracle Red Bull Racing",
 "base": "Milton Keynes, United Kingdom",
 "email": "conferences.events@redbullracing.com",
 "website": "https://www.redbullracing.com/int-en",
 "logo": "https://media.api-sports.io/formula-1/teams/1.png",
 "teamChief": "Christian Horner",
 "driverName1": "Max Verstappen",
 "driverName2": "Sergio Perez"
 */
