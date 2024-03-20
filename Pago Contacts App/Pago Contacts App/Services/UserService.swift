//
//  UserService.swift
//  Pago Contacts App
//
//  Created by Santamarian Bogdan on 20.03.2024.
//

import Foundation

protocol UserService {
    func usersExist() -> Result<Bool, Error>
    func fetchUsers() async -> Result<[User], Error>
    func getUsersFromDb() -> Result<[User], Error>
    func createUser(name: String, email: String, phoneNumber: String)
    func updateUser(_ user: User, name: String, email: String, phoneNumber: String)
}
