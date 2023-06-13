//
//  SearchBusiness.swift
//  TravelAid
//
//  Created by Osman Balci on 11/14/22.
//  Copyright © 2022 Jason Tran. All rights reserved.
//

import SwiftUI

struct SearchBusiness: View {
    
    //-----------------
    // Search Variables
    //-----------------
    @State private var searchFieldValue = ""
    @State private var searchFieldValue2 = ""
    @State private var searchCompleted = false
    
    //---------------
    // Alert Messages
    //---------------
    @State private var showAlertMessage = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {

            ZStack {
                Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
                Form {
                    Section(header: Text("Enter Search Term")) {
                        HStack {
                            TextField("Enter Search Term", text: $searchFieldValue)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                            
                            // Button to clear the text field
                            Button(action: {
                                searchFieldValue = ""
                            }) {
                                Image(systemName: "clear")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                            }
                        }
                    }
                    Section(header: Text("Enter Location")) {
                        HStack {
                            TextField("Enter Location", text: $searchFieldValue2)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                            
                            // Button to clear the text field
                            Button(action: {
                                searchFieldValue2 = ""
                            }) {
                                Image(systemName: "clear")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                            }
                        }
                    }
                    Section(header: Text("Search API")) {
                        HStack {
                            Spacer()
                            Button(searchCompleted ? "Search Completed" : "Search") {
                                if inputDataValidated() {
                                    searchApi()
                                    searchCompleted = true
                                } else {
                                    showAlertMessage = true
                                    alertTitle = "Missing Input Data!"
                                    alertMessage = "Location is required! Search term is optional."
                                }
                               
                            }
                            .tint(.blue)
                            .buttonStyle(.bordered)
                            .buttonBorderShape(.capsule)
                            
                            Spacer()
                        }
                    }
                    if searchCompleted {
                        Section(header: Text("List Businesses Found")) {
                            NavigationLink(destination: showSearchResults) {
                                HStack {
                                    Image(systemName: "list.bullet")
                                        .imageScale(.medium)
                                        .font(Font.title.weight(.regular))
                                    Text("List Businesses Found")
                                        .font(.system(size: 16))
                                }
                                .foregroundColor(.blue)
                            }
                        }
                        Section(header: Text("Clear")) {
                            HStack {
                                Spacer()
                                Button("Clear") {
                                    searchCompleted = false
                                    searchFieldValue = ""
                                }
                                .tint(.blue)
                                .buttonStyle(.bordered)
                                .buttonBorderShape(.capsule)
                                
                                Spacer()
                            }
                        }
                    }
                    
                }   // End of Form
                .alert(alertTitle, isPresented: $showAlertMessage, actions: {
                    Button("OK") {}
                }, message: {
                    Text(alertMessage)
                })
                
            }   // End of ZStack
            
            
        .navigationBarTitle(Text("Search Businesses"), displayMode: .inline)
        .customNavigationViewStyle()  // Given in NavigationStyle
        
    }   // End of body var
    
    /*
     ---------------------
     MARK: Search API
     ---------------------
     */
    func searchApi() {
        
        // Remove spaces, if any, at the beginning and at the end of the entered search query string
        let queryTrimmed = searchFieldValue.trimmingCharacters(in: .whitespacesAndNewlines)
        let locationTrimmed = searchFieldValue2.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // public func obtainCompanyDataFromApi is given in BookDataFromApi.swift
        getFoundBusinessFromApi(query: queryTrimmed, location: locationTrimmed)
    }
    
    /*
     -------------------------
     MARK: Show Search Results
     -------------------------
     */
    var showSearchResults: some View {
        
        if foundBusinessList.isEmpty {
            return AnyView(
                NotFound(message: "Businesses not found with given query.")
            )
        }
        
        return AnyView(BusinessList())
    }
    
    /*
     ---------------------------
     MARK: Input Data Validation
     ---------------------------
     */
    func inputDataValidated() -> Bool {
        
        // Remove spaces, if any, at the beginning and at the end of the entered search query string
        let queryTrimmed = searchFieldValue.trimmingCharacters(in: .whitespacesAndNewlines)
        let locationTrimmed = searchFieldValue2.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if locationTrimmed.isEmpty {
            return false
        }
        return true
    }
    
}

struct SearchBusiness_Previews: PreviewProvider {
    static var previews: some View {
        SearchBusiness()
    }
}


