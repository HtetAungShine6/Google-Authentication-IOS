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
    @State private var isLoggedIn = false
    
    var body: some View {
        VStack {
            VStack {
                Text("events.au")
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                    .overlay(
                        LinearGradient(gradient: Gradient(colors: [Color("red_primary"), Color("red_secondary")]), startPoint: .top, endPoint: .bottom)
                            .mask(Text("events.au").fontWeight(.bold).font(.system(size: 24)))
                    )
                
                
                Image("OnBoardingPhoto")
                    .resizable()
                    .frame(width: 400, height: 400)
                
                NavigationLink(
                    destination: isLoggedIn ? AnyView(Home()) : AnyView(SignUpView()),
                    isActive: $isLoggedIn
                ) {
                    EmptyView()
                }

                
                Button{
                    FirebAuth.share.signinWithGoogle(presenting: Application_utility.rootViewController) { error,_  in
                        // TODO: Handle ERROR
                        
                        print(error?.localizedDescription as Any)
                    }
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
            }
            .padding(.top, 52)
            Spacer()
        }
    }
    
//    func handleLogin() {
//        isLoggedIn = UserManager.shared.isUserRegistered()
//    }
}


#Preview {
    LoginScreen()
}
