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
import FirebaseFirestore
import FirebaseStorage
import FirebaseDatabase

struct FirebAuth {
    static let share = FirebAuth()
    
    private init() {
        //initial
    }
    
    func signinWithGoogle(presenting: UIViewController,
                          completion: @escaping (Error?, Bool) -> Void) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        DispatchQueue.main.async {
            GIDSignIn.sharedInstance.signIn(withPresenting: Application_utility.rootViewController) { result, error in
                guard let user = result?.user, let idToken = user.idToken?.tokenString else {
                    completion(error, false)
                    return
                }
                let accessToken = user.accessToken
                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken.tokenString)

                Auth.auth().signIn(with: credential) { res, error in
                    if let error = error {
                        print(error.localizedDescription)
                        completion(error, false)
                        return
                    }
                    guard let user = res?.user else {
                        completion(NSError(domain: "FirebaseAuthError", code: -1, userInfo: nil), false)
                        return
                    }
                    
                    let db = Firestore.firestore()
                    db.collection("Users").document(user.uid).getDocument { document, error in
                        if let document = document, document.exists {
                            // User exists, navigate to home screen
                            completion(nil, true)
                        } else {
                            // User does not exist, navigate to registration form
                            completion(nil, false)
                        }
                    }

                    print(user.uid)
                    print(user.displayName as Any)
                    print(user.photoURL ?? "none")
                    UserDefaults.standard.set(true, forKey: "signIn")
                }
            }
        }
    }
}


//struct FirebAuth {
//    static let share = FirebAuth()
//    
//    private init() {
//        //initial
//    }
//    
//    // Initiating Google Sign In process
//    func signinWithGoogle(presenting: UIViewController,
//                          completion: @escaping (Error?) -> Void) {
//        
//        // Uniquely identifies iOS app within the context of Firebase project. It's used by Firebase Authentication to recognize and authenticate requests coming from the specific iOS app
//        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
//
//        // Create Google Sign In configuration object (config)
//        let config = GIDConfiguration(clientID: clientID)
//        GIDSignIn.sharedInstance.configuration = config
//
//        // Start the sign in flow
//        // Can't perform the code provided in Firebase Documentation which is (withPresenting: self). So I provided dependency injection for UI which is rootViewController
//        // Handling from App crash
//        DispatchQueue.main.async {
//            GIDSignIn.sharedInstance.signIn(withPresenting: Application_utility.rootViewController){ result, error in
//                guard let user = result?.user, let idToken = user.idToken?.tokenString else {return}
//                let accessToken = user.accessToken
//                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken.tokenString)
//                Auth.auth().signIn(with: credential) { res, error in
//                    if let error = error{
//                        print(error.localizedDescription)
//                        return
//                    }
//                    guard let user = res?.user else {return}
//                    let db = Firestore.firestore()
//                    db.collection("Users").document(firebaseUser.uid).getDocument{ document, error in
//                        if let document = document, document.exists{
//                            DispatchQueue.main.async {
//                                self.currentScreen = .home
//                            }
//                        }else {
//                            DispatchQueue.main.async {
//                                self.currentScreen = .registration
//                            }
//                        }
//                        completion(nil)
//                    }
//                    print(user.uid)
//                    print(user.displayName as Any)
//                    print(user.photoURL ?? "none")
//                    UserDefaults.standard.set(true, forKey: "signIn")
//                    completion(nil)
//                }
//            }
//        }
//    }
//}
