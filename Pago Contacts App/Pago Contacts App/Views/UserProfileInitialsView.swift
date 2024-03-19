//
//  UserProfileImageView.swift
//  Pago Contacts App
//
//  Created by Santamarian Bogdan on 19.03.2024.
//

import SwiftUI

struct UserProfileInitialsView: View {
    
    // MARK: - Properties
    var user: User
    
    var body: some View {
        ZStack {
            Circle()
                .fill(.pagoGrayTwo)
            Text(getInitials(for: user))
                .foregroundStyle(.white)
                .fontWeight(.medium)
        }
        .frame(width: 46, height: 46)
    }
    
    // MARK: - Private methods
    private func getInitials(for user: User) -> String {
        let words = user.name.split(separator: " ")
        let firstLetters = words.map { String($0.first ?? Character("")) }.prefix(2)
        return firstLetters.joined()
    }
}

#Preview {
    UserProfileInitialsView(user: User(id: 2, name: "Johnny Cage", email: "", gender: "", status: ""))
}
