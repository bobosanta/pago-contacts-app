//
//  AddNewUserView.swift
//  Pago Contacts App
//
//  Created by Santamarian Bogdan on 18.03.2024.
//

import SwiftUI

struct AddNewUserView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var name = ""
    @State private var surname = ""
    @State private var phoneNumber = ""
    @State private var email = ""
    @State private var gender = ""
    @State private var status = ""
    
    @Binding var showAddDialog: Bool
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    CustomTextField(title: "name".localized, text: $name)
                    CustomTextField(title: "surname".localized, text: $surname)
                    CustomTextField(title: "phone".localized, text: $phoneNumber)
                    CustomTextField(title: "email".localized, text: $email)
                }
            }
            .navigationTitle("addContact".localized)
            .listRowSpacing(24)
            
            ConfirmationButton {
                saveUser()
            }
        }
    }
    
    private func saveUser() {
        let user = User(id: Int.random(in: 1..<99999), name: name, email: email, gender: gender, status: status)
        modelContext.insert(user)
        showAddDialog.toggle()
    }
}

#Preview {
    AddNewUserView(showAddDialog: .constant(false))
}
