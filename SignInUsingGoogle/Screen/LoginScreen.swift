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
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
            VStack {
                LoginHeader()
                    .padding(.bottom)
                
                CustomTextfield(text: $username)
           
                CustomTextfield(text: $username)
                
                HStack {
                    Spacer()
                    Button(action: {}) {
                        Text("Forgot Password?")
                    }
                }
                .padding(.trailing, 24)
                
                CustomButton()
                
                
                Text("or")
                    .padding()
                
                GoogleSiginBtn {
                    // TODO: - Call the sign method here
                    FirebAuth.share.signinWithGoogle(presenting: Application_utility.rootViewController) { error in
                        // TODO: Handle ERROR
                        print(error?.localizedDescription as Any)
                    }
                } // GoogleSiginBtn
            } // VStack
            .padding(.top, 52)
            Spacer()
        }
    }
}


#Preview {
    LoginScreen()
}
