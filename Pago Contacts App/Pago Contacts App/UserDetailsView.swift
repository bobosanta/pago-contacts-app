//
//  UserDetailsView.swift
//  Pago Contacts App
//
//  Created by Santamarian Bogdan on 16.03.2024.
//

import SwiftUI

struct UserDetailsView: View {
    
    @Environment(\.modelContext) private var modelContext
    let user: User
    
    var body: some View {
        Text("User with name \(user.name)")
    }
}

#Preview {
    UserDetailsView(user: User(id: 1, name: "", surname: "", email: "", phoneNumber: "", gender: "", status: ""))
}
