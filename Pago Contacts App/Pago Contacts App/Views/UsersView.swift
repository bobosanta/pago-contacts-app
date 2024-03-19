//
//  UsersView.swift
//  Pago Contacts App
//
//  Created by Santamarian Bogdan on 16.03.2024.
//

import SwiftUI
import SwiftData

struct UsersView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User]
    
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
                                    ZStack {
                                        Circle()
                                            .fill(PagoColors.lightGray)
                                        Text(getInitials(for: user))
                                            .foregroundStyle(.white)
                                    }
                                    .frame(width: 46, height: 46)
                                } else {
                                    AsyncImage(url: URL(string: "https://picsum.photos/200/200")) { phase in
                                        switch phase {
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 46, height: 46)
                                                .clipShape(.circle)
                                        case .failure(let error):
                                            Text("Failed to load image: \(error.localizedDescription)")
                                        case .empty:
                                            ProgressView()
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                }
                                Text(user.name)
                            }.frame(height: 94)
                        }
                    }
                } header: {
                    Text("myContacts".localized)
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    NavigationLink {
                        UserDetailsView(user: nil)
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
            .listStyle(.plain)
            .onAppear(perform: {
                // For testing purposes only
//                deleteData()
                do {
                    if try modelContext.fetchCount(FetchDescriptor<User>()) == 0 {
                        getUsers()
                    }
                } catch {
                    print("Cannot fetch modelContext count")
                }
            })
            .navigationTitle("contacts".localized)
            
            .toolbarTitleDisplayMode(.inlineLarge)
        }
        .ignoresSafeArea(.all)
    }
    
    private func getUsers() {
        guard let url = URL(string: "https://gorest.co.in/public/v2/users") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                let activeUsers = users.filter { $0.status == "active" }
                activeUsers.forEach {
                    self.modelContext.insert($0)
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        task.resume()
    }
    
    private func deleteData() {
        users.forEach {
            modelContext.delete($0)
        }
    }
    
    private func addUser() {
        
    }
    
    private func getInitials(for user: User) -> String {
        let words = user.name.split(separator: " ")
        let firstLetters = words.map { String($0.first ?? Character("")) }.prefix(2)
        return firstLetters.joined()
    }
}

#Preview {
    UsersView()
        .modelContainer(for: User.self, inMemory: true)
}
