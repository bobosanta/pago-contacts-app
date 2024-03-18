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
            Form {
                TextField("name".localized, text: $name)
                TextField("surname".localized, text: $surname)
                TextField("phone".localized, text: $phoneNumber)
                TextField("email".localized, text: $email)
            }
            .navigationTitle("addContact".localized)
            
            Button(action: {
                saveUser()
            }, label: {
                Text("saveButtonTitle".localized)
            })
        }
    }
    
    private func saveUser() {
        let user = User(id: Int.random(in: 1..<99999), name: name, email: email, gender: gender, status: status)
        modelContext.insert(user)
        showAddDialog.toggle()
    }
}
