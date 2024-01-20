//
//  Unit.swift
//  SignInUsingGoogle
//
//  Created by Akito Daiki on 28/12/2566 BE.
//

import Foundation
struct FactResponse: Codable {
    var success: Bool
    var message: [Fact]
}

struct Fact: Codable, Hashable {
    var _id: String
    var name: String
    var description: String
    var eventList: [String]
    var __v: Int
}
