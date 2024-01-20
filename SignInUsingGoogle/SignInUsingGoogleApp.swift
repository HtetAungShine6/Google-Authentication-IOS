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
    @AppStorage("signIn") var isSignIn = false
    @AppStorage("isFirstTimeSignIn") var isFirstTimeSignIn = true
    @State private var currentScreen: AppScreen = .login
    var body: some Scene {
        WindowGroup {
            switch currentScreen {
            case .login:
                LoginScreen()
            case .home:
                Home()
            case .registration:
                SignUpView()
            }
        }
    }
}

enum AppScreen {
    case login
    case home
    case registration
}
