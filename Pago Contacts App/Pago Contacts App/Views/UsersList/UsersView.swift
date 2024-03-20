//
//  UsersView.swift
//  Pago Contacts App
//
//  Created by Santamarian Bogdan on 16.03.2024.
//

import SwiftData
import SwiftUI

struct UsersView: View {
    
    // MARK: - Properties
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: UsersViewModel
    
    init(modelContext: ModelContext) {
        _viewModel = State(initialValue: UsersViewModel(userService: UserServiceImpl(modelContext: modelContext)))
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(viewModel.users) { user in
                        NavigationLink {
                            UserDetailsView(user: user, modelContext: modelContext)
                        } label: {
                            HStack {
                                if user.id.isMultiple(of: 2) {
                                    UserProfileInitialsView(user: user)
                                } else {
                                    UserProfileImageView()
                                }
                                Text(user.name)
                            }.frame(height: 94)
                        }
                    }
                } header: {
                    Text(Constants.myContactsLocalized)
                }
            }
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    NavigationLink {
                        UserDetailsView(modelContext: modelContext)
                    } label: {
                        Image(.addUser)
                            .frame(width: 17, height: 17)
                            .padding(9)
                    }
                    .frame(width: 36, height: 36)
                    .background(.white)
                    .overlay(RoundedRectangle(cornerRadius: 7).stroke(.pagoGrayTwo, lineWidth: 2))

                }
            }
            .toolbarTitleDisplayMode(.inlineLarge)
            .navigationTitle(Constants.contactsLocalized)
            .onAppear {
                Task {
                    await viewModel.loadUsers()
                }
            }
        }
    }
}
