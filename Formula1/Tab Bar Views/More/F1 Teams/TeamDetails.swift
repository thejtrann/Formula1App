//
//  TeamDetails.swift
//  Formula1
//
//  Created by Jason Tran and Osman Balci on 12/5/22.
//

import SwiftUI
import CoreData
import MapKit

struct TeamDetails: View {
    
    // Input Parameter
    let team: Team
    
    
    // Enable this view to be dismissed to go back to the previous view
    @Environment(\.dismiss) private var dismiss
    
    // Subscribe to changes in Core Data database
    @EnvironmentObject var databaseChange: DatabaseChange
    
    //---------------
    // Alert Messages
    //---------------
    @State private var showAlertMessage = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        Form {
            Group {
                Section(header: Text("Team Name")) {
                    Text(team.name)
                }
                Section(header: Text("Team Logo")) {
                    getImageFromUrl(url: team.logo, defaultFilename: "ImageUnavailable")
                }
                Section(header: Text("Team Base")) {
                    Text(team.base)
                }
                Section(header: Text("Team Website")) {
                    // Tap the website URL to display the website externally in default web browser
                    Link(destination: URL(string: team.website)!) {
                        HStack {
                            Image(systemName: "globe")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                            Text("Show Website")
                                .font(.system(size: 16))
                        }
                        .foregroundColor(.blue)
                    }
                    // Long press the website URL to display the context menu
                    .contextMenu {
                        // Context Menu Item
                        Button(action: {
                            // Copy the website URL to universal clipboard for pasting elsewhere
                            UIPasteboard.general.url = URL(string: team.website)!
                            
                            showAlertMessage = true
                            alertTitle = "Website URL is Copied to Clipboard"
                            alertMessage = "You can paste it on your iPhone, iPad, Mac laptop or Mac desktop each running under your Apple ID"
                        }) {
                            Image(systemName: "doc.on.doc")
                            Text("Copy Website URL")
                        }
                    }
                }
                Section(header: Text("Team Email Address")) {
                    // Tap the Email address to display the Mail app externally to send email
                    HStack {
                        Image(systemName: "envelope")
                            .imageScale(.medium)
                            .font(Font.title.weight(.light))
                            .foregroundColor(Color.blue)
                        
                        //*************************************************************************
                        // This Link does not work on the Simulator since Mail app is not available
                        //*************************************************************************
                        Link(team.email, destination: URL(string: "mailto:\(team.email)")!)
                    }
                    // Long press the email address to display the context menu
                    .contextMenu {
                        // Context Menu Item 1
                        //*************************************************************************
                        // This Link does not work on the Simulator since Mail app is not available
                        //*************************************************************************
                        Link(destination: URL(string: "mailto:\(team.email)")!) {
                            Image(systemName: "envelope")
                            Text("Send Email")
                        }
                        
                        // Context Menu Item 2
                        Button(action: {
                            // Copy the email address to universal clipboard for pasting elsewhere
                            UIPasteboard.general.string = team.email
                            
                            showAlertMessage = true
                            alertTitle = "Email Address is Copied to Clipboard"
                            alertMessage = "You can paste it on your iPhone, iPad, Mac laptop or Mac desktop each running under your Apple ID"
                        }) {
                            Image(systemName: "doc.on.doc")
                            Text("Copy Email Address")
                        }
                    }
                }
                Section(header: Text("Team Chief")) {
                    Text(team.teamChief)
                }
                Section(header: Text("Driver 1")) {
                    Text(team.driverName1)
                }
                Section(header: Text("Driver 2")) {
                    Text(team.driverName2)
                }
            }
            
        }   // End of Form
        .alert(alertTitle, isPresented: $showAlertMessage, actions: {
            Button("OK") {}
        }, message: {
            Text(alertMessage)
        })
        .navigationBarTitle(Text("Team Details"), displayMode: .inline)
        .font(.system(size: 14))
    }
}
