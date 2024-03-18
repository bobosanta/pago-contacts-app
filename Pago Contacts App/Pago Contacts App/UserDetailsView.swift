//
//  UserDetailsView.swift
//  Pago Contacts App
//
//  Created by Santamarian Bogdan on 16.03.2024.
//

import SwiftUI

struct UserDetailsView: View {
    
    @Bindable var user: User
    
    var body: some View {
        Form {
            TextField("Nume", text: $user.name)
            TextField("Prenume", text: $user.surname.toUnwrapped(defaultValue: ""))
            TextField("Telefon", text: $user.phoneNumber.toUnwrapped(defaultValue: ""))
            TextField("Email", text: $user.email)
        }
    }
}

#Preview {
    UserDetailsView(user: User(id: 1, name: "", surname: "", email: "", phoneNumber: "", gender: "", status: ""))
}
