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
                TextField("Nume", text: $name)
                TextField("Prenume", text: $surname)
                TextField("Telefon", text: $phoneNumber)
                TextField("Email", text: $email)
                TextField("Gen", text: $gender)
                TextField("Status Cont", text: $status)
            }
            
            Button(action: {
                saveUser()
            }, label: {
                Text("Salvează")
            })
        }
    }
    
    private func saveUser() {
        let user = User(id: Int.random(in: 1..<99999), name: name, surname: surname, email: email, phoneNumber: phoneNumber, gender: gender, status: status)
        modelContext.insert(user)
        showAddDialog.toggle()
    }
}
