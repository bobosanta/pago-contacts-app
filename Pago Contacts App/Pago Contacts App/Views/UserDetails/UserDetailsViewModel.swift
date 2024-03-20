//
//  UserDetailsViewModel.swift
//  Pago Contacts App
//
//  Created by Santamarian Bogdan on 20.03.2024.
//

import Foundation

@Observable
final class UserDetailsViewModel {
    
    // MARK: - Properties
    var name = ""
    var surname = ""
    var phoneNumber = ""
    var email = ""
    let editedUser: User?
    private let userService: UserService
    
    init(editedUser: User? = nil, userService: UserService) {
        self.editedUser = editedUser
        self.userService = userService
        
        if let editedUser {
            let (name, surname) = splitName(editedUser.name)
            self.name = name ?? ""
            self.surname = surname ?? ""
            phoneNumber = editedUser.phoneNumber ?? ""
            email = editedUser.email
        }
    }
    
    func saveUser() {
        if let editedUser {
            userService.updateUser(
                editedUser,
                name: [surname, name].joined(separator: " "),
                email: email,
                phoneNumber: phoneNumber
            )
        } else {
            userService.createUser(
                name: [surname, name].joined(separator: " "),
                email: email,
                phoneNumber: phoneNumber
            )
        }
    }
    
    // MARK: - Private methods
    private func splitName(_ fullName: String) -> (String?, String?) {
        let components = fullName.components(separatedBy: " ")
        switch components.count {
        case 0:  return (nil, nil)
        case 1:  return (components.first, nil)
        default:
            let firstName = components.dropLast().joined(separator: " ")
            let lastName = components.last ?? ""
            
            return (lastName, firstName)
        }
    }
}
