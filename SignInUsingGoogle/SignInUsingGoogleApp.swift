//
//  SignInUsingGoogleApp.swift
//  SignInUsingGoogle
//
//  Created by Akito Daiki on 14/12/2566 BE.
//

import SwiftUI

@main
struct SignInUsingGoogleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
//    @AppStorage("signIn") var isSignIn = false
//    @StateObject var vm = FirebAuthViewModel()
    
    var body: some Scene {
        WindowGroup {
//            LoginScreen()
            MLogin()
        }
    }
}

////            ContentView()
//            if isSignIn{
//                Home()
//            } else {
//                LoginScreen()
//            }
//            if isSignIn{
//                vm.signInWithGoogle(presenting: Application_utility.rootViewController){ error, isNewUser in
//                    if isNewUser{
//                        SignUpView()
//                    }else{
//                        Home()
//                    }
//                }
//            }else{
//                LoginScreen()
//            }
