//
//  VideosList.swift
//  Formula1
//
//  Created by Jason Tran and Osman Balci on 11/28/22.
//

import SwiftUI

struct VideosList: View {
    
    var body: some View {
        List {
            ForEach(videoStructList) { aVideo in
                NavigationLink(destination: VideoDetails(video: aVideo)) {
                    VideoItem(video: aVideo)
                }
            }
        }
        .navigationBarTitle(Text("Formula 1 Videos"), displayMode: .inline)
        .customNavigationViewStyle()      // Given in NavigationStyle.swift
    }
}

struct VideosList_Previews: PreviewProvider {
    static var previews: some View {
        VideosList()
    }
}
