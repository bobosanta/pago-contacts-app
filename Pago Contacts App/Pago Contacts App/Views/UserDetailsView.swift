//
//  UserDetailsView.swift
//  Pago Contacts App
//
//  Created by Santamarian Bogdan on 16.03.2024.
//

import SwiftUI

struct UserDetailsView: View {
    
    // MARK: - Properties
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    
    var user: User?
    
    @State private var name = ""
    @State private var surname = ""
    @State private var phoneNumber = ""
    @State private var email = ""
    @State private var gender = ""
    @State private var status = ""
    
    var body: some View {
        List {
            CustomTextField(title: "name".localized, text: $name)
            CustomTextField(title: "surname".localized, text: $surname)
            CustomTextField(title: "phone".localized, text: $phoneNumber)
            CustomTextField(title: "email".localized, text: $email)
        }
        .listRowSpacing(24)
        .onAppear {
            if let (surname, name) = splitName(user?.name ?? "") {
                self.surname = surname
                self.name = name
            }
            
            if let user {
                self.phoneNumber = user.phoneNumber ?? ""
                self.email = user.email
            }
        }
        .navigationTitle(
            user == nil ? "addContact".localized : "editContact".localized
        )
        
        ConfirmationButton {
            saveUser()
            presentationMode.wrappedValue.dismiss()
        }
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
    
    private func updateUserFullName() -> String {
        return "\(surname) \(name)"
    }
    
    private func saveUser() {
        if let user {
            user.name = updateUserFullName()
            user.phoneNumber = phoneNumber
            user.email = email
            user.gender = gender
            user.status = status
        } else {
            let user = User(id: generateRandomId(), name: updateUserFullName(), phoneNumber: phoneNumber, email: email, gender: gender, status: status)
            modelContext.insert(user)
        }
    }
    
    private func generateRandomId() -> Int {
        return Int.random(in: 1..<99999)
    }
    
}

#Preview {
    UserDetailsView(user: User(id: 1, name: "", email: "", gender: "", status: ""))
}
