//
//  VideoDetails.swift
//  Formula1
//
//  Created by Jason Tran and Osman Balci on 11/28/22.
//

import SwiftUI

struct VideoDetails: View {
    
    // Input Parameter
    let video: Video
    
    var body: some View {
        Form {
            Section(header: Text("Video Title")) {
                Text(video.title)
            }
            Section(header: Text("Video Thumbnail Image"), footer: Text(video.youTubeId)) {
                getImageFromUrl(url: "https://img.youtube.com/vi/\(video.youTubeId)/mqdefault.jpg", defaultFilename: "ImageUnavailable")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                     // Thumbnail medium quality (mqdefault.jpg) size: 320x180 -> 16:9 ratio
                    .frame(minWidth: 320, maxWidth: 640, alignment: .center)
            }
            Section(header: Text("Play Video")) {
                NavigationLink(destination:
                    WebView(url: "https://www.youtube.com/watch?v=\(video.youTubeId)")
                        .edgesIgnoringSafeArea(.all)
                   /*
                    ---------------------------------------------------------------------------------------
                    Some YouTube videos do not allow playing as "embed"ed within WebView in an app.
                    In that case, the video can be played on YouTube website by using the "watch" parameter.
                    WebView(url: "https://www.youtube.com/watch?v=\(video.youTubeId)")
                    ---------------------------------------------------------------------------------------
                    */
                ){
                    HStack {
                        Image(systemName: "play.rectangle.fill")
                            .imageScale(.medium)
                            .font(Font.title.weight(.regular))
                            .foregroundColor(.red)
                        Text("Play YouTube Video")
                            .font(.system(size: 16))
                            .foregroundColor(.blue)
                    }
                }
            }
            Section(header: Text("Video Release Date")) {
                videoReleaseDate
            }
            Section(header: Text("Video Duration Time"), footer: Text("hours:mins:secs")) {
                Text(video.duration)
            }
            
        }   // End of Form
        .navigationBarTitle(Text("YouTube Video"), displayMode: .inline)
        // Set font and size for the whole Form content
        .font(.system(size: 14))
        
    }   // End of body var
    
    var videoReleaseDate: Text {
         
        // Create an instance of DateFormatter
        let dateFormatter = DateFormatter()
         
        // Set the date format to yyyy-MM-dd
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US")
         
        // Convert date String from "yyyy-MM-dd" to Date struct
        let dateStruct = dateFormatter.date(from: video.releaseDate)
         
        // Create a new instance of DateFormatter
        let newDateFormatter = DateFormatter()
         
        newDateFormatter.locale = Locale(identifier: "en_US")
        newDateFormatter.dateStyle = .full      // Thursday, November 7, 2019
        newDateFormatter.timeStyle = .none
         
        // Obtain newly formatted Date String as "Thursday, November 7, 2019"
        let dateWithNewFormat = newDateFormatter.string(from: dateStruct!)
        
        return Text(dateWithNewFormat)
    }
}

struct VideoDetails_Previews: PreviewProvider {
    static var previews: some View {
        VideoDetails(video: videoStructList[0])
    }
}

