//
//  FactViewModel.swift
//  SignInUsingGoogle
//
//  Created by Akito Daiki on 28/12/2566 BE.

import Foundation
class FactViewModel: ObservableObject {
    @Published var facts: [Fact] = []
    
    func getFacts() {
        if let url = URL(string: "https://events-au.vercel.app/unit/getAll") { // Replace with your API endpoint
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { [weak self] (data, response, error) in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error fetching data: \(error)")
                } else if let data = data {
                    print("Data received successfully")
                    self.dataFetch(data)
                }
            }
            task.resume()
        } else {
            print("Invalid URL")
        }
    }
    
    func dataFetch(_ data : Data) {
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(FactResponse.self, from: data)
            print(result)
            self.facts = result.message
        } catch {
            print(error)
        }
    }
}
