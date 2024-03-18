//
//  UserDetailsView.swift
//  Pago Contacts App
//
//  Created by Santamarian Bogdan on 16.03.2024.
//

import SwiftUI

struct UserDetailsView: View {
    
    // MARK: - Properties
    @Bindable var user: User
    
    @State private var name: String = ""
    @State private var surname: String = ""
    
    var body: some View {
        Form {
            CustomTextField(title: "name".localized, text: $name)
            CustomTextField(title: "surname".localized, text: $surname)
            CustomTextField(title: "phone".localized, text: $user.phoneNumber.toUnwrapped(defaultValue: ""))
            CustomTextField(title: "email".localized, text: $user.email)
        }
        .onAppear {
            if let (surname, name) = splitName(user.name) {
                self.surname = surname
                self.name = name
            }
        }
        .onDisappear {
            updateUserFullName()
        }
        .navigationTitle($user.name)
    }
    
    // MARK: - Private methods
    private func splitName(_ fullName: String) -> (String, String)? {
        let components = fullName.components(separatedBy: " ")
        guard components.count >= 2 else {
            return nil
        }
        
        let firstName = components.dropLast().joined(separator: " ")
        let lastName = components.last ?? ""
        
        return (firstName, lastName)
    }
    
    private func updateUserFullName() {
        user.name = "\(surname) \(name)"
    }
}

#Preview {
    UserDetailsView(user: User(id: 1, name: "", email: "", gender: "", status: ""))
}
