//
//  SignInWithMicrosoft.swift
//  SignInUsingGoogle
//
//  Created by Akito Daiki on 2/2/2567 BE.
//

import Foundation
import Firebase
import FirebaseAuth

//https://dcodeevent.firebaseapp.com/__/auth/handler

class SignInWithMicrosoft: ObservableObject {
    private var microsoftProvider: OAuthProvider?

    init() {
        self.microsoftProvider = OAuthProvider(providerID: "microsoft.com")
    }

    func signIn() {
        microsoftProvider?.getCredentialWith(nil) { credential, error in
            if let error = error {
                // Handle the error here.
                print("Error during Microsoft sign-in: \(error.localizedDescription)")
                return
            }

            if let credential = credential {
                Auth.auth().signIn(with: credential) { authResult, error in
                    if let error = error {
                        // Handle the error here.
                        print("Error during Firebase authentication: \(error.localizedDescription)")
                        return
                    }

                    if let authResult = authResult {
                        // Successfully authenticated with Firebase.
                        print("Authenticated user: \(authResult.user.displayName ?? "No name")")
                        
                        // You can access the user's information like displayName, email, etc.
                        // authResult.user.displayName
                        // authResult.user.email
                        // ...
                        
                        // You can also get the Microsoft access token if needed.
                        let microsoftCredential = authResult.credential as! OAuthCredential
                        let accessToken = microsoftCredential.accessToken
                        print("Microsoft access token: \(accessToken ?? "No access token")")
                        
                        // Now you can use the Firebase user or the Microsoft access token as needed.
                        if let currentUser = Auth.auth().currentUser {
                            let displayName = currentUser.displayName
                            print("Current User's Display Name:", displayName ?? "No Display Name")
                        } else {
                            print("No user is currently signed in.")
                        }
                    }
                }
            }
        }
    }
}

