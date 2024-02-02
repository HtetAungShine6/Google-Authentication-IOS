//
//  LoginScreen.swift
//  SignInUsingGoogle
//
//  Created by Akito Daiki on 14/12/2566 BE.
//

import SwiftUI
import SwiftUI
import FirebaseAuth
import GoogleSignIn
import Firebase

struct LoginScreen: View {
    @StateObject private var vm = FirebAuthViewModel()
    @State private var isRegistered = false
    @State private var showRegistration = false
    @State private var errorMessage: String? = nil
    
    var body: some View {
        VStack {
            if isRegistered {
                Home()
            } else if showRegistration {
                SignUpView()
            } else {
                loginViewContent
            }
        }
    }

    private var loginViewContent: some View {
        VStack {
            // Your existing login view components like Text, Image, etc.

//            Button(action: {
//                signInWithGoogle()
//            }) {
//                // Button content
//            }
            Button{
                signInWithGoogle()
            }label: {
                ZStack{
                    Rectangle()
                        .foregroundColor(.white)
                        .cornerRadius(30)
                        .shadow(color: .gray, radius: 6, x: 0, y: 2)
                        .frame(maxWidth: 350, maxHeight: 60)
                        .padding()
                    HStack{
                        Image("google")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 50, maxHeight: 50)
                        Text("Sign In with Google")
                            .tint(Color.black)
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                }
            }
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .padding(.top, 52)
    }

    private func signInWithGoogle() {
        vm.signInWithGoogle(presenting: Application_utility.rootViewController) { error, isNewUser in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }
                if isNewUser {
                    self.showRegistration = true
                } else {
                    self.isRegistered = true
                }
            }
        }
    }
}

//struct LoginScreen: View {
//    @State var username: String = ""
//    @State var password: String = ""
//    @State private var isRegistered = false 
//    @State private var showRegistration = false
//    @StateObject private var vm = FirebAuthViewModel()
//    
//    var body: some View {
//        if isRegistered{
//            Home()
//        }
//        if showRegistration{
//            SignUpView()
//        }
//        NavigationStack {
//            VStack {
//                Text("events.au")
//                    .fontWeight(.bold)
//                    .font(.system(size: 24))
//                    .overlay(
//                        LinearGradient(gradient: Gradient(colors: [Color("red_primary"), Color("red_secondary")]), startPoint: .top, endPoint: .bottom)
//                            .mask(Text("events.au").fontWeight(.bold).font(.system(size: 24)))
//                    )
//                
//                
//                Image("OnBoardingPhoto")
//                    .resizable()
//                    .frame(width: 400, height: 400)
//                
//                Button{
//                    vm.signInWithGoogle(presenting: Application_utility.rootViewController) { error, isNewUser in
//                        print(error?.localizedDescription ?? "GG HAS")
//                        DispatchQueue.main.async {
//                            if isNewUser{
//                                self.isRegistered = true
//                                //                            UserDefaults.standard.set(true, forKey: "signIn")
//                            }else{
//                                //                            SignUpView()
//                                self.showRegistration = true
//                            }
//                        }
//                    }
//                }label: {
//                    ZStack{
//                        Rectangle()
//                            .foregroundColor(.white)
//                            .cornerRadius(30)
//                            .shadow(color: .gray, radius: 6, x: 0, y: 2)
//                            .frame(maxWidth: 350, maxHeight: 60)
//                            .padding()
//                        HStack{
//                            Image("google")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(maxWidth: 50, maxHeight: 50)
//                            Text("Sign In with Google")
//                                .tint(Color.black)
//                                .font(.title3)
//                                .fontWeight(.bold)
//                        }
//                    }
//                }
////                NavigationLink(
////                    destination: isRegistered ? AnyView(Home()) : AnyView(SignUpView()),
////                    isActive: $isRegistered
////                ) {
////                    EmptyView()
////                }
//            }
//            .padding(.top, 52)
//            Spacer()
//        }
//    }
//}


#Preview {
    LoginScreen()
}
