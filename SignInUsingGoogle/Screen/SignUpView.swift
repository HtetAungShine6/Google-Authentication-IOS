//
//  SignUpView.swift
//  SignInUsingGoogle
//
//  Created by Akito Daiki on 28/12/2566 BE.
//

import SwiftUI
import Firebase
import FirebaseAuth
import GoogleSignIn
    
struct SignUpView: View {

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var gender = ""
    @State private var age = ""
    @State private var phoneNumber = ""
    @StateObject private var facts = FactViewModel()
    @State private var navigateToLogin = false
    @State private var authentication = Auth.auth()

    func createUser() {
        // API endpoint
        let baseUrl = "https://events-au.vercel.app/user/create"
        guard let url = URL(string: baseUrl) else {
            return
        }
        // Prepare the request body
        let unitNames = facts.facts.first?._id
        var parameters: [String: Any] = [
            "id": authentication.currentUser?.uid ?? "nil",
            "username": authentication.currentUser?.displayName ?? "",
            "firstName": firstName,
            "lastName": lastName,
            "units": unitNames ?? "nil",
            "gender": gender,
            "age": Int(age) ?? 0,
            "phoneNumber": Int(phoneNumber) ?? 0,
            "email": authentication.currentUser?.email ?? ""
        ]
        
        guard let body = try? JSONSerialization.data(withJSONObject: parameters) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                // Handle error
                return
            }
            
            // Process response
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
                // Handle status code
            }
            
            if let data = data {
                // Process data if needed
                print("Response data: \(String(data: data, encoding: .utf8) ?? "")")
            }
        }.resume()
    }
    
    var body: some View {
        NavigationView{
            VStack {
                Text("events.au")
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                    .overlay(
                        LinearGradient(gradient: Gradient(colors: [Color("red_primary"), Color("red_secondary")]), startPoint: .top, endPoint: .bottom)
                            .mask(Text("events.au").fontWeight(.bold).font(.system(size: 24)))
                    )
                Spacer()
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("text_color_grey"))
                    .fill(.white)
                    .overlay(
                        HStack(alignment: .center){
                            TextField("First Name", text: $firstName)
                        }.padding()
                    ).frame(width: 300, height: 50)
                Spacer()
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("text_color_grey"))
                    .fill(.white)
                    .overlay(
                        HStack(alignment: .center){
                            TextField("Last Name", text: $lastName)
                        }.padding()
                    ).frame(width: 300, height: 50)
                Spacer()
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("text_color_grey"))
                    .fill(.white)
                    .overlay(
                        Picker(selection: $gender, label: Text("Gender")) {
                            Text("Select your gender").tag("")
                            Text("Male").tag("Male")
                            Text("Female").tag("Female")
                        }
                            .tint(LinearGradient(gradient: Gradient(colors: [Color("red_primary"), Color("red_secondary")]), startPoint: .top, endPoint: .bottom))
                            .pickerStyle(MenuPickerStyle())
                            .padding()
                            .foregroundColor(.black)
                    ).frame(width: 300, height: 50)
                Spacer()
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("text_color_grey"))
                    .fill(.white)
                    .overlay(
                        HStack(alignment: .center){
                            TextField("Age", text: $age)
                        }.padding()
                    ).frame(width: 300, height: 50)
                Spacer()
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("text_color_grey"))
                    .fill(.white)
                    .overlay(
                        HStack(alignment: .center){
                            TextField("Phone Number", text: $phoneNumber)
                        }.padding()
                    ).frame(width: 300, height: 50)
                Spacer()

                if !facts.facts.isEmpty {
                    ForEach(facts.facts, id: \.self) { fact in
                        Text(fact.name)
                            .padding()
                    }
                } else {
                    Text("No facts available")
                        .padding()
                        .onAppear {
                            // Fetch facts if they are not available
                            if facts.facts.isEmpty {
                                facts.getFacts()
                            }
                        }
                }
                
                NavigationLink(destination: Home(), isActive: $navigateToLogin) {
                    EmptyView()
                }
                
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
                        Button("Create User") {
                            createUser()
                            navigateToLogin = true
                        }
                            .tint(Color.white)
                    )
                    .padding()
            }
            .padding()
            .onAppear()
        }
    }
}

#Preview {
    SignUpView()
}
