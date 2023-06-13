//
//  TeamList.swift
//  Formula1
//
//  Created by Jason Tran and Osman Balci on 12/5/22.
//

import SwiftUI

struct TeamList: View {
    
    var body: some View {
        List {
            ForEach(teamStructList) { aTeam in
                NavigationLink(destination: TeamDetails(team: aTeam)) {
                    TeamItem(team: aTeam)
                }
            }
        }
        .navigationBarTitle(Text("Formula 1 Teams"), displayMode: .inline)
        .customNavigationViewStyle()      // Given in NavigationStyle.swift
    }
}

struct TeamList_Previews: PreviewProvider {
    static var previews: some View {
        TeamList()
    }
}
