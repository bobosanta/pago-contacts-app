//
//  UserProfileImageView.swift
//  Pago Contacts App
//
//  Created by Santamarian Bogdan on 19.03.2024.
//

import SwiftUI

struct UserProfileInitialsView: View {
    
    var user: User
    
    var body: some View {
        ZStack {
            Circle()
                .fill(PagoColors.lightGray)
            Text(getInitials(for: user))
                .foregroundStyle(.white)
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
