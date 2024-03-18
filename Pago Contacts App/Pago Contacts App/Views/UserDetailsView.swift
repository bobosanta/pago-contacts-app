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
            TextField("name".localized, text: $user.name)
            TextField("surname".localized, text: $user.surname.toUnwrapped(defaultValue: ""))
            TextField("phone".localized, text: $user.phoneNumber.toUnwrapped(defaultValue: ""))
            TextField("email".localized, text: $user.email)
        }
        .navigationTitle($user.name)
    }
}

#Preview {
    UserDetailsView(user: User(id: 1, name: "", surname: "", email: "", phoneNumber: "", gender: "", status: ""))
}
