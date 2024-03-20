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
    
    @State private var name = ""
    @State private var surname = ""
    @State private var phoneNumber = ""
    @State private var email = ""
    @State private var gender = ""
    @State private var status = ""
    
    var user: User?
    
    private var fullName: String {
        [surname, name].joined(separator: " ")
    }
    private var randomId: Int {
        Int.random(in: 1..<99999)
    }
    
    var body: some View {
        List {
            CustomTextField(title: Constants.nameLocalized, text: $name)
            CustomTextField(title: Constants.surnameLocalized, text: $surname)
            CustomTextField(title: Constants.phoneLocalized, text: $phoneNumber)
            CustomTextField(title: Constants.emailLocalized, text: $email)
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
            user == nil ? Constants.addContactLocalized : Constants.editContactLocalized
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
    
    private func saveUser() {
        if let user {
            user.name = fullName
            user.phoneNumber = phoneNumber
            user.email = email
            user.gender = gender
            user.status = .active
        } else {
            let user = User(id: randomId, name: fullName, phoneNumber: phoneNumber, email: email, gender: gender, status: User.Status(rawValue: status) ?? .active)
            modelContext.insert(user)
        }
    }
    
}

#Preview {
    UserDetailsView(user: User(id: 1, name: "", email: "", gender: "", status: .active))
}
