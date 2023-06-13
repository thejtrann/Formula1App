//
//  VideoItem.swift
//  Formula1
//
//  Created by Jason Tran and Osman Balci on 11/28/22.
//

import SwiftUI

struct VideoItem: View {
    
    // Input Parameter
    let video: Video
    
    var body: some View {
        HStack {
            getImageFromUrl(url: "https://img.youtube.com/vi/\(video.youTubeId)/mqdefault.jpg", defaultFilename: "ImageUnavailable")
                .resizable()
                .aspectRatio(contentMode: .fit)
                /*
                You can obtain YouTube thumbnail image with the quality and size you desire:
                    Default:               default.jpg          120x90
                    Medium Quality:        mqdefault.jpg        320x180
                    High Quality:          hqdefault.jpg        480x360
                    Standard Definition:   sddefault.jpg        640x480
                    Maximum Resolution:    maxresdefault.jpg    1280x720

                 Thumbnail medium quality (mqdefault.jpg) size: 320x180 -> 16:9 ratio
                 Select frame width and height with 16:9 ratio
                 Do not use high quality size! It leaves black bars on top and bottom.
                 */
                .frame(width: 128.0, height: 72.0)
            
            VStack(alignment: .leading) {
                Text(video.title)
                Text(video.releaseDate)
                Text(video.duration)
            }
            // Set font and size for the whole VStack content
            .font(.system(size: 14))
        }
    }
}

struct VideoItem_Previews: PreviewProvider {
    static var previews: some View {
        VideoItem(video: videoStructList[0])
    }
}
