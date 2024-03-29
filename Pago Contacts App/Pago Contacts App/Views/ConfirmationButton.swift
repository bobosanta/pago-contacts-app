//
//  ConfirmationButton.swift
//  Pago Contacts App
//
//  Created by Santamarian Bogdan on 18.03.2024.
//

import SwiftUI

struct ConfirmationButton: View {
    
    // MARK: - Properties
    var action: () -> Void
    
    var body: some View {
        HStack {
            Button {
                action()
            } label: {
                Text(Constants.saveButtonTitleLocalized)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.pagoGreen)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .shadow(color: .pagoDarkBlue.opacity(0.2), radius: 5, x: 0, y: 3)
    }
}

#Preview {
    ConfirmationButton(action: {})
}
