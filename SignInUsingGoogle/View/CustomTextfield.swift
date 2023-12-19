//
//  CustomTextfield.swift
//  SignInUsingGoogle
//
//  Created by Akito Daiki on 14/12/2566 BE.
//

import SwiftUI

struct CustomTextfield: View {
    @Binding var text: String
    
    var body: some View {
        TextField("Username", text: $text)
            .padding(16)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke()
            )
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
    }
}

#Preview {
    CustomTextfield(text: .constant("") )
}
