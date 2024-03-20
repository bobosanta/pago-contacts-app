//
//  User.swift
//  Pago Contacts App
//
//  Created by Santamarian Bogdan on 16.03.2024.
//

import Foundation
import SwiftData

@Model
final class User: Codable {
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case email
        case gender
        case status
    }
    
    enum Status: String, Codable {
        case active
        case inactive
    }
    
    var id: Int
    var name: String
    var surname: String?
    var email: String
    var phoneNumber: String?
    var gender: String
    var status: Status
    
    init(id: Int, name: String, phoneNumber: String? = nil, email: String, gender: String, status: Status) {
        self.id = id
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.gender = gender
        self.status = status
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        gender = try container.decode(String.self, forKey: .gender)
        status = try container.decode(Status.self, forKey: .status)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}
