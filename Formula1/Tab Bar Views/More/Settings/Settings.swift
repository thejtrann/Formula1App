//
//  Settings.swift
//  Formula1
//
//  Created by Osman Balci on 11/28/22.
//

import SwiftUI

struct Settings: View {
    
    @AppStorage("darkMode") private var darkMode = false
    
    @State private var showEnteredValues = false
    @State private var passwordEntered = ""
    @State private var passwordVerified = ""
    @State private var showUnmatchedPasswordAlert = false
    @State private var showPasswordSetAlert = false
    @State private var showPasswordRemovedAlert = false
    
    //---------------
    // Alert Messages
    //---------------
    @State private var showAlertMessage = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    let securityQuestions = ["In what city or town did your mother and father meet?", "In what city or town were you born?", "What did you want to be when you grew up?", "What do you remember most from your childhood?", "What is the name of the boy or girl that you first kissed?", "What is the name of the first school you attended?", "What is the name of your favorite childhood friend?", "What is the name of your first pet?", "What is your mother's maiden name?", "What was your favorite place to visit as a child?"]
    
    @State private var selectedSecurityQuestionIndex = 4
    @State private var answerToSelectedSecurityQuestion = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Dark Mode Setting")) {
                    Toggle("Dark Mode", isOn: $darkMode)
                }
                Section(header: Text("Show / Hide Entered Values")) {
                    Toggle("Show Entered Values", isOn: $showEnteredValues)
                }
                Section(header: Text("Select a Security Question")) {
                    Picker("Selected:", selection: $selectedSecurityQuestionIndex) {
                        ForEach(0 ..< securityQuestions.count, id: \.self) {
                            Text(securityQuestions[$0])
                        }
                    }
                }
                Section(header: Text("Enter Answer to Selected Security Question")) {
                    HStack {
                        if showEnteredValues {
                            TextField("Enter Answer", text: $answerToSelectedSecurityQuestion)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                        } else {
                            SecureField("Enter Answer", text: $answerToSelectedSecurityQuestion)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                        }
                        // Button to clear the text field
                        Button(action: {
                            answerToSelectedSecurityQuestion = ""
                        }) {
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                        .padding()
                    }
                }
                Section(header: Text("Enter Password")) {
                    HStack {
                        if showEnteredValues {
                            TextField("Enter Password", text: $passwordEntered)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                        } else {
                            SecureField("Enter Password", text: $passwordEntered)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                        }
                        // Button to clear the text field
                        Button(action: {
                            passwordEntered = ""
                        }) {
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                        .padding()
                    }   // End of HStack
                }
                Section(header: Text("Verify Password")) {
                    HStack {
                        if showEnteredValues {
                            TextField("Verify Password", text: $passwordVerified)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                        } else {
                            SecureField("Verify Password", text: $passwordVerified)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                        }
                        // Button to clear the text field
                        Button(action: {
                            passwordVerified = ""
                        }) {
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                        .padding()
                    }   // End of HStack
                }
                Section(header: Text("Set Password")) {
                    HStack {
                        Spacer()
                        Button("Set Password") {
                            if !passwordEntered.isEmpty && !answerToSelectedSecurityQuestion.isEmpty {
                                if passwordEntered == passwordVerified {
                                    /*
                                     UserDefaults provides an interface to the user’s defaults database,
                                     where you store key-value pairs persistently across launches of your app.
                                     */
                                    // Store the password in the user’s defaults database
                                    UserDefaults.standard.set(passwordEntered, forKey: "Password")
                                    
                                    // Store the selected security question index in the user’s defaults database
                                    UserDefaults.standard.set(securityQuestions[selectedSecurityQuestionIndex], forKey: "SecurityQuestion")
                                    
                                    // Store the answer to the selected security question in the user’s defaults database
                                    UserDefaults.standard.set(answerToSelectedSecurityQuestion, forKey: "SecurityAnswer")
                                    
                                    passwordEntered = ""
                                    passwordVerified = ""
                                    answerToSelectedSecurityQuestion = ""
                                    
                                    showAlertMessage = true
                                    alertTitle = "Password Set!"
                                    alertMessage = "Password you entered is set to unlock the app!"
                                } else {
                                    showAlertMessage = true
                                    alertTitle = "Unmatched Password!"
                                    alertMessage = "Two entries of the password must match!"
                                }
                            } else {
                                showAlertMessage = true
                                alertTitle = "Missing Input!"
                                alertMessage = "Please select and answer a security question and enter your password!"
                            }
                        }   // End of Button
                        .tint(.blue)
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.capsule)
                        
                        Spacer()
                    }   // End of HStack
                }
                Section(header: Text("Remove Password")) {
                    HStack {
                        Spacer()
                        Button("Remove Password") {
                            // Set password to nil in the user’s defaults database
                            UserDefaults.standard.set(nil, forKey: "Password")
                            
                            // Set security question to nil in the user’s defaults database
                            UserDefaults.standard.set(nil, forKey: "SecurityQuestion")
                            
                            showAlertMessage = true
                            alertTitle = "Password Removed!"
                            alertMessage = "You can now unclock the app without a password!"
                        }
                        .tint(.blue)
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.capsule)
                        
                        Spacer()
                    }
                }
                
            }   // End of Form
            // Set font and size for the whole Form content
            .font(.system(size: 14))
            .navigationBarTitle(Text("Settings"), displayMode: .inline)
            .alert(alertTitle, isPresented: $showAlertMessage, actions: {
                Button("OK") {}
            }, message: {
                Text(alertMessage)
            })
            
        }   // End of NavigationView
        // Use single column navigation view for iPhone and iPad
        .navigationViewStyle(StackNavigationViewStyle())
        
    }   // End of body var
    
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
