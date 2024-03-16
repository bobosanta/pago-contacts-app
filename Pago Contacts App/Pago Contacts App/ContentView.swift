//
//  ContentView.swift
//  Pago Contacts App
//
//  Created by Santamarian Bogdan on 16.03.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User]
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(users) { user in
                        NavigationLink {
                            Text("User with name \(user.name)")
                        } label: {
                            Text(user.name)
                        }
                    }
                } header: {
                    Text("Contactele mele")
                }
                
            }.onAppear(perform: {
                //            deleteData()
                do {
                    if try modelContext.fetchCount(FetchDescriptor<User>()) == 0 {
                        getUsers()
                    }
                } catch {
                    print("Cannot fetch modelContext count")
                }
            })
            .toolbar {
                ToolbarItem {
                    Button(action: addUser) {
                        Label("Add User", systemImage: "plus")
                    }
                }
            }
        }
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
                users.forEach {
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
}

#Preview {
    ContentView()
        .modelContainer(for: User.self, inMemory: true)
}
