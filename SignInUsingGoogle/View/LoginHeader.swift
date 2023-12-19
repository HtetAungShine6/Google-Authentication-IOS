//
//  LoginHeader.swift
//  SignInUsingGoogle
//
//  Created by Akito Daiki on 14/12/2566 BE.
//

import SwiftUI

struct LoginHeader: View {
    var body: some View {
        VStack {
            Text("Hello Again!")
                .font(.largeTitle)
                .fontWeight(.medium)
                .padding()
            
            Text("Welcome to back, You've \nbeen missed")
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    LoginHeader()
}
