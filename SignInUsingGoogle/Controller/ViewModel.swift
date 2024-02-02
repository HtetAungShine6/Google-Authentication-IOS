//
//  FirebAuth.swift
//  SignInUsingGoogle
//
//  Created by Akito Daiki on 14/12/2566 BE.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import Firebase
import FirebaseAuth

class FirebAuthViewModel: ObservableObject {
 
    init() {
        // Initialization
    }
 
    func signInWithGoogle(presenting: UIViewController, completion: @escaping (Error?, Bool) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
 
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: Application_utility.rootViewController) { user, error in
            if let error = error {
                // Handle the error if Google Sign-In failed
                DispatchQueue.main.async {
                    completion(error, false)
                }
                return
            }
 
            guard let user = user?.user, let idToken = user.idToken else {
                // If user is nil, it means the user cancelled the Google Sign-In
                // Do not proceed with Firebase authentication
                DispatchQueue.main.async {
                    completion(nil, false) // or use a custom error to indicate cancellation
                }
                return
            }
 
            let accessToken = user.accessToken
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
 
            // Check for existing user with the same email before Firebase authentication
            Auth.auth().fetchSignInMethods(forEmail: user.profile?.email ?? "No Email") { providers, error in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(error, false)
                    }
                    return
                }
 
                // If providers are not empty, the user exists with at least one provider
                if let providers = providers, !providers.isEmpty {
                    DispatchQueue.main.async {
                        completion(nil, false) // Handle existing user (e.g., navigate to home page)
                    }
                    return
                }
 
                // Otherwise, proceed with Firebase authentication for new user creation
                Auth.auth().signIn(with: credential) { authResult, error in
                    if let error = error {
                        DispatchQueue.main.async {
                            completion(error, false)
                        }
                        return
                    }
 
                    guard let authResult = authResult else {
                        DispatchQueue.main.async {
                            completion(NSError(domain: "FirebaseAuthError", code: -1, userInfo: nil), false)
                        }
                        return
                    }
 
                    let isNewUser = authResult.additionalUserInfo?.isNewUser ?? false
                    DispatchQueue.main.async {
                        completion(nil, isNewUser)
                    }
                }
            }
        }
    }
}

//class FirebAuthViewModel: ObservableObject {
//
//    init() {
//        // Initialization
//    }
//
//    func signInWithGoogle(presenting: UIViewController, completion: @escaping (Error?, Bool) -> Void) {
//        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
//
//        let config = GIDConfiguration(clientID: clientID)
//        GIDSignIn.sharedInstance.configuration = config
//        GIDSignIn.sharedInstance.signIn(withPresenting: Application_utility.rootViewController) { user, error in
//            if let error = error {
//                // Handle the error if Google Sign-In failed
//                DispatchQueue.main.async {
//                    completion(error, false)
//                }
//                return
//            }
//
//            guard let user = user?.user, let idToken = user.idToken else {
//                // If user is nil, it means the user cancelled the Google Sign-In
//                // Do not proceed with Firebase authentication
//                DispatchQueue.main.async {
//                    completion(nil, false) // or use a custom error to indicate cancellation
//                }
//                return
//            }
//
//            let accessToken = user.accessToken
//            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
//
//            // Continue with Firebase authentication
//            Auth.auth().signIn(with: credential) { authResult, error in
//                if let error = error {
//                    DispatchQueue.main.async {
//                        completion(error, false)
//                    }
//                    return
//                }
//
//                guard let authResult = authResult else {
//                    DispatchQueue.main.async {
//                        completion(NSError(domain: "FirebaseAuthError", code: -1, userInfo: nil), false)
//                    }
//                    return
//                }
//
//                let isNewUser = authResult.additionalUserInfo?.isNewUser ?? false
//                DispatchQueue.main.async {
//                    completion(nil, isNewUser)
//                }
//            }
//        }
//    }
//}
//

//
//class FirebAuthViewModel: ObservableObject {
//
//    init() {
//        // Initialization
//    }
//
//    func signInWithGoogle(presenting: UIViewController, completion: @escaping (Error?, Bool) -> Void) {
//        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
//
//        let config = GIDConfiguration(clientID: clientID)
//        GIDSignIn.sharedInstance.configuration = config
//        GIDSignIn.sharedInstance.signIn(withPresenting: Application_utility.rootViewController) { user, error in
//            if let error = error {
//                DispatchQueue.main.async {
//                    completion(error, false)
//                }
//                return
//            }
//
//            guard let user = user?.user, let idToken = user.idToken else { return }
//            let accessToken = user.accessToken
//            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
//            Auth.auth().signIn(with: credential) { authResult, error in
//                if let error = error {
//                    DispatchQueue.main.async {
//                        completion(error, false)
//                    }
//                    return
//                }
//
//                guard let authResult = authResult else {
//                    DispatchQueue.main.async {
//                        completion(NSError(domain: "FirebaseAuthError", code: -1, userInfo: nil), false)
//                    }
//                    return
//                }
//
//                // isNewUser is false if the user already exists in Firebase Authentication
//                let isNewUser = authResult.additionalUserInfo?.isNewUser ?? false
//                DispatchQueue.main.async {
//                    completion(nil, isNewUser)
//                }
//            }
//        }
//    }
//}
