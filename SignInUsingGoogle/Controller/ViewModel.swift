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

struct FirebAuth {
    static let share = FirebAuth()
    
    private init() {
        //initial
    }
    
    // Initiating Google Sign In process
    func signinWithGoogle(presenting: UIViewController,
                          completion: @escaping (Error?) -> Void) {
        
        // Uniquely identifies iOS app within the context of Firebase project. It's used by Firebase Authentication to recognize and authenticate requests coming from the specific iOS app
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object (config)
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow
        // Can't perform the code provided in Firebase Documentation which is (withPresenting: self). So I provided dependency injection for UI which is rootViewController
        GIDSignIn.sharedInstance.signIn(withPresenting: Application_utility.rootViewController){ result, error in
            guard let user = result?.user, let idToken = user.idToken?.tokenString else {return}
            let accessToken = user.accessToken
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken.tokenString)
            Auth.auth().signIn(with: credential) { res, error in
                if let error = error{
                    print(error.localizedDescription)
                    return
                }
                guard let user = res?.user else {return}
                print(user.displayName as Any)
                print(user.photoURL ?? "none")
                UserDefaults.standard.set(true, forKey: "signIn")
            }
        }
    }
}

//        if let rootViewController = UIApplication.shared.getRootViewController(){
//            GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
//                guard let user = result?.user,
//                        let idToken = user.idToken?.tokenString else {return}
//                let accessToken = user.accessToken
//                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken.tokenString)
//                Auth.auth().signIn(with: credential){ res, error in
//                    if let error = error{
//                        print(error.localizedDescription)
//                        return
//                    }
//                    guard let user = res?.user else {return}
//                    print(user.displayName as Any)
//                    UserDefaults.standard.set(true, forKey: "signIn")
//                }
//            }
//        }

//            guard
////                let authentication = user?.authentication,
//                let idToken = authentication.idToken
//            else {
//                return
//            }
//
//            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
//                                                           accessToken: authentication.accessToken)
//
//            Auth.auth().signIn(with: credential) { result, error in
//                guard error == nil else {
//                    completion(error)
//                    return
//                }
//                print("SIGN IN")
//                UserDefaults.standard.set(true, forKey: "signIn") // When this change to true, it will go to the home screen
//            }
