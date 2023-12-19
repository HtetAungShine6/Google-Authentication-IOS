//
//  Home.swift
//  SignInUsingGoogle
//
//  Created by Akito Daiki on 14/12/2566 BE.
//

import SwiftUI
import Firebase
import FirebaseAuth
import GoogleSignIn
import Kingfisher

struct Home: View {
    @State private var userName: String = ""
    @State private var isSignedOut: Bool = false
    @State private var authentication = Auth.auth()
    var body: some View {
        VStack{
            if let photoURL = authentication.currentUser?.photoURL {
                KFImage(photoURL)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(20)
                    .padding([.bottom, .trailing], 4)
            }
            HStack{
                Text("User Name : ")
                Text(authentication.currentUser?.displayName ?? "No User name found")
            }
            HStack{
                Text("Email : ")
                Text(authentication.currentUser?.email ?? "No Email Found")
            }
            HStack{
                Text("Phone Number : ")
                Text(authentication.currentUser?.phoneNumber ?? "No Phone Number Found")
            }
            Button{
                isSignedOut = true
            }label: {
                Text("Sign Out")
                .padding()
                .background(.black)
                .cornerRadius(12)
                .tint(Color.white)
                .padding()
            }
            .alert("Are you sure you want to sign out?",isPresented: $isSignedOut){
                Button("OK"){
                    let firebaseAuth = Auth.auth()
                    do{
                        try firebaseAuth.signOut()
                        UserDefaults.standard.set(false, forKey: "signIn")
                    }catch let signOutError as NSError{
                        print("Error signing out: %@", signOutError)
                    }
                }
                Button("Cancel", role: .cancel){
                    //Cancel Button
                }
            }
        }
    }
}

#Preview {
    Home()
}
