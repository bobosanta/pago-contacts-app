//
//  CustomTextField.swift
//  Pago Contacts App
//
//  Created by Santamarian Bogdan on 18.03.2024.
//

import SwiftUI

struct CustomTextField: View {
    
    // MARK: - Properties
    var title = ""
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text(title)
                .foregroundStyle(.pagoGrayThree)
                .font(.system(size: 14))
            TextField("", text: $text)
                .font(.system(size: 14))
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.pagoGrayThree)
            Spacer()
        }
        .frame(height: 85)
        .background(.white)
        .textFieldStyle(.plain)
    }
}
