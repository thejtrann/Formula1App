//
//  Home.swift
//  Formula1
//
//  Created by Ryan Tabor and Osman Balci on 11/27/22.
//

import SwiftUI
import CoreData

struct Home: View {
    
    // ✳️ Core Data managedObjectContext reference
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // ✳️ Core Data FetchRequest returning all Company entities from the database
    @FetchRequest(fetchRequest: Experience.allExpsFetchRequest()) var allExps: FetchedResults<Experience>
    
    @AppStorage("darkMode") private var darkMode = false
    
    @State private var index = 0
    /*
     Create a timer publisher that fires 'every' 3 seconds and updates the view.
     It runs 'on' the '.main' runloop so that it can update the view.
     It runs 'in' the '.common' mode so that it can run alongside other
     common events such as when the ScrollView is being scrolled.
     */
    @State private var timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
            
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Image("Welcome")
                    .padding(.bottom, 10)
                
                /*
                 --------------------------------------------------------------------------
                 Show an image slider of the logos of all of the companies in the database.
                 --------------------------------------------------------------------------
                 */
               
                // photo obtained from its URL
                getImageFromBinaryData(binaryData: allExps[index].photoFilename, defaultFilename: "ImageUnavailable")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 300, maxWidth: 500, maxHeight: 300, alignment: .center)
                    .padding()
                
                    // Subscribe to the timer publisher
                    .onReceive(timer) { _ in
                        index += 1
                        if index > allExps.count - 1 {
                            index = 0
                        }
                    }
                
                // Trip Caption
                Text(allExps[index].title ?? "")
                    .font(.headline)
                    // Allow lines to wrap around
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Text("Powered By")
                    .font(.system(size: 18, weight: .light, design: .serif))
                    .italic()
                    .padding(.top, 30)
                    .padding(.bottom, 20)
                
                // Show IEX Cloud API provider's website externally in default web browser
                Link(destination: URL(string: "https://api-sports.io/documentation/formula-1/v1")!, label: {
                    HStack{
                        Image(systemName: "car")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 29)
                        Text("Formula 1 API")
                    }
                })
                
                // Show IEX Cloud API provider's website externally in default web browser
                Link(destination: URL(string: "https://www.yelp.com/developers/documentation/v3")!, label: {
                    HStack{
                        Image("YelpFusionApiLogo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 29)
                        Text("Yelp Fusion API")
                    }
                })
                
                // Show IEX Cloud API provider's website externally in default web browser
                Link(destination: URL(string: "https://openweathermap.org/api")!, label: {
                    HStack{
                        Image("OpenWeatherLogo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 29)
                        Text("OpenWeather API")
                    }
                })
                .padding(.bottom, 50)
                
            }   // End of VStack
        }   // End of ScrollView
        .onAppear() {
            startTimer()
        }
        .onDisappear() {
            stopTimer()
        }

    }   // End of var
    
    func startTimer() {
        timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    }
    
    func stopTimer() {
        timer.upstream.connect().cancel()
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}



