//
//  CustomTextField.swift
//  Pago Contacts App
//
//  Created by Santamarian Bogdan on 18.03.2024.
//

import SwiftUI

struct CustomTextField: View {
    
    var title = ""
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundStyle(PagoColors.textFieldTitleLabelColor)
            TextField("", text: $text)
        }
        .textFieldStyle(.plain)
    }
}

#Preview {
    CustomTextField(title: "Title", text: .constant("Sample Text"))
}
