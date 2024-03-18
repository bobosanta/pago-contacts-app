//
//  ConfirmationButton.swift
//  Pago Contacts App
//
//  Created by Santamarian Bogdan on 18.03.2024.
//

import SwiftUI

struct ConfirmationButton: View {
    
    var action: () -> Void
    
    var body: some View {
        HStack {
            Button {
                action()
            } label: {
                Text("saveButtonTitle".localized)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(PagoColors.saveButtonBackgroundColor)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .shadow(color: PagoColors.saveButtonDropShadowColor.opacity(0.2), radius: 5, x: 0, y: 3)
    }
}

#Preview {
    ConfirmationButton(action: {})
}
