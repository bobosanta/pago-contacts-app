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
    @Query private var users: [User]
    @StateObject private var usersService = UsersService()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(users) { user in
                        NavigationLink {
                            UserDetailsView(user: user)
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
                        UserDetailsView(user: nil)
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
            .onAppear(perform: {
                // For testing purposes only
//                deleteData()
                do {
                    if try modelContext.fetchCount(FetchDescriptor<User>()) == 0 {
                        usersService.getUsers()
                    }
                } catch {
                    print("Cannot fetch modelContext count")
                }
            })
            .navigationTitle(Constants.contactsLocalized)
        }
    }
    
    // MARK: - Private Methods
    private func deleteData() {
        users.forEach {
            modelContext.delete($0)
        }
    }
}

#Preview {
    UsersView()
        .modelContainer(for: User.self, inMemory: true)
}
