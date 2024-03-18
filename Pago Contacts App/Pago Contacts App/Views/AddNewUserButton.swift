//
//  AddNewUserButton.swift
//  Pago Contacts App
//
//  Created by Santamarian Bogdan on 18.03.2024.
//

import SwiftUI

struct AddNewUserButton: View {
    
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(uiImage: UIImage(named: "addUser.png") ?? UIImage())
                .frame(width:17, height: 17)
                .padding(9)
        }
        .frame(width: 36, height: 36)
        .background(.white)
        .overlay(RoundedRectangle(cornerRadius: 7).stroke(PagoColors.mediumGray, lineWidth: 2))
    }
}

#Preview {
    AddNewUserButton {
        
    }
}
