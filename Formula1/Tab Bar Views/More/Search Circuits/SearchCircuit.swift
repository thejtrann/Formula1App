//
//  SearchCircuit.swift
//  Formula1
//
//  Created by Jason Tran and Osman Balci on 12/5/22.
//

import SwiftUI

struct SearchCircuit: View {
    
    //-----------------
    // Search Variables
    //-----------------
    @State private var searchFieldValue = ""
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
                    Section(header: Text("Search Circuit")) {
                        HStack {
                            TextField("Circuit Name", text: $searchFieldValue)
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
                    Section(header: Text("Search API")) {
                        HStack {
                            Spacer()
                            Button(searchCompleted ? "Search Completed" : "Search") {
                                if inputDataValidated() {
                                    searchApi()
                                    searchCompleted = true
                                } else {
                                    showAlertMessage = true
                                    alertTitle = "Search Field is Empty!"
                                    alertMessage = "Please enter a search query!"
                                }
                               
                            }
                            .tint(.blue)
                            .buttonStyle(.bordered)
                            .buttonBorderShape(.capsule)
                            
                            Spacer()
                        }
                    }
                    if searchCompleted {
                        Section(header: Text("Show Circuits")) {
                            NavigationLink(destination: showSearchResults) {
                                HStack {
                                    Image(systemName: "list.bullet")
                                        .imageScale(.medium)
                                        .font(Font.title.weight(.regular))
                                    Text("Show Circuits")
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
            
            
        .navigationBarTitle(Text("Search Circuits"), displayMode: .inline)
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
        
        // public func obtainCompanyDataFromApi is given in BookDataFromApi.swift
        getFoundCircuitsFromApi(query: queryTrimmed)
    }
    
    /*
     -------------------------
     MARK: Show Search Results
     -------------------------
     */
    var showSearchResults: some View {
        if foundCircuitList.isEmpty {
            return AnyView(
                NotFound(message: "Circuits not found with given query.")
            )
        }
        return AnyView(CircuitList())
    }
    
    /*
     ---------------------------
     MARK: Input Data Validation
     ---------------------------
     */
    func inputDataValidated() -> Bool {
        
        // Remove spaces, if any, at the beginning and at the end of the entered search query string
        let queryTrimmed = searchFieldValue.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if queryTrimmed.isEmpty {
            return false
        }
        return true
    }
    
}
