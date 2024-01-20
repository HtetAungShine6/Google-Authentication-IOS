//
//  OnBoardingScreen1.swift
//  SignInUsingGoogle
//
//  Created by Akito Daiki on 28/12/2566 BE.
//

import SwiftUI

struct OnBoardingScreen1: View {
    var body: some View {
        NavigationView{
            VStack{
                Text("Welcome to")
                    .foregroundColor(Color("text_color_grey"))
                Text("EVENTS.AU")
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
                    .font(.system(size: 30))
                    .padding()
                    .foregroundColor(Color.red)
                Image("OnBoardingPhoto")
                    .resizable()
                    .frame(width: 400, height: 400)
                NavigationLink(destination: LoginScreen()) {
                    RoundedRectangle(cornerRadius: 50)
                        .fill(
                            LinearGradient(
                                colors: [Color("red_primary"),
                                         Color("red_secondary")],
                                startPoint: .top,
                                endPoint: .bottom)
                        )
                        .frame(width: 300, height: 50)
                        .overlay(
                            Text("Get Started")
                                .foregroundColor(.white)
                            , alignment: .center
                        )
                }
            }
        }
    }
}

#Preview {
    OnBoardingScreen1()
}
