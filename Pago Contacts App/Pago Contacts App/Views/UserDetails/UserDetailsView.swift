//
//  UserDetailsView.swift
//  Pago Contacts App
//
//  Created by Santamarian Bogdan on 16.03.2024.
//

import SwiftData
import SwiftUI

struct UserDetailsView: View {
    
    // MARK: - Properties
    @Environment(\.presentationMode) private var presentationMode
    @State private var viewModel: UserDetailsViewModel
    
    init(user: User? = nil, modelContext: ModelContext) {
        _viewModel = State(
            initialValue: UserDetailsViewModel(
                editedUser: user,
                userService: UserServiceImpl(modelContext: modelContext)
            )
        )
    }
    
    var body: some View {
        List {
            CustomTextField(title: Constants.nameLocalized, text: $viewModel.name)
            CustomTextField(title: Constants.surnameLocalized, text: $viewModel.surname)
            CustomTextField(title: Constants.phoneLocalized, text: $viewModel.phoneNumber)
            CustomTextField(title: Constants.emailLocalized, text: $viewModel.email)
        }
        .listRowSpacing(24)
        .navigationTitle(
            viewModel.editedUser == nil ? Constants.addContactLocalized : Constants.editContactLocalized
        )
        
        ConfirmationButton {
            viewModel.saveUser()
            presentationMode.wrappedValue.dismiss()
        }
    }
}
