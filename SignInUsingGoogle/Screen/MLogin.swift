//
//  MLogin.swift
//  SignInUsingGoogle
//
//  Created by Akito Daiki on 2/2/2567 BE.
//

import SwiftUI

struct MLogin: View {
    @State private var isUserLoggedIn = false
    var body: some View {
        let microsoftSignIn = SignInWithMicrosoft()

//        Button("Sign in with Microsoft") {
//            microsoftSignIn.signIn()
//        }
        if isUserLoggedIn {
            NavigationLink(destination: MHome(), isActive: $isUserLoggedIn) {
                EmptyView()
            }
        } else{
            Button{
                microsoftSignIn.signIn()
            }label: {
                Text("Sign in with Microsoft")
            }
        }
    }
}

#Preview {
    MLogin()
}
