//
//  User.swift
//  Pago Contacts App
//
//  Created by Santamarian Bogdan on 16.03.2024.
//

import Foundation
import SwiftData

@Model
final class User {
    var id: Int
    var name: String
    var email: String
    var gender: String
    var status: String
    
    init(id: Int, name: String, email: String, gender: String, status: String) {
        self.id = id
        self.name = name
        self.email = email
        self.gender = gender
        self.status = status
    }
}
