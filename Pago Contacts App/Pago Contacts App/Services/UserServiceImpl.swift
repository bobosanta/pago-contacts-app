//
//  UserServiceImpl.swift
//  Pago Contacts App
//
//  Created by Santamarian Bogdan on 19.03.2024.
//

import Foundation
import SwiftData

class UserServiceImpl: UserService {
    // MARK: - Properties
    private let modelContext: ModelContext
    
    private var randomId: Int {
        Int.random(in: 1..<9999999)
    }
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // MARK: - Implementation
    func usersExist() -> Result<Bool, Error> {
        do {
            return .success(try modelContext.fetchCount(FetchDescriptor<User>()) > 0)
        } catch {
            return .failure(PagoError.fetchError)
        }
    }
    
    func fetchUsers() async -> Result<[User], Error> {
        guard let url = URL(string: "https://gorest.co.in/public/v2/users") else {
            print("Invalid URL")
            return .failure(PagoError.invalidUrl)
        }
        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let users = try JSONDecoder().decode([User].self, from: data).filter { $0.status == .active }
            users.forEach {
                self.modelContext.insert($0)
            }
            return .success(users.sorted { $0.id < $1.id })
        } catch {
            print(error.localizedDescription)
            return .failure(error)
        }
    }
    
    func getUsersFromDb() -> Result<[User], Error> {
        do {
            return .success(try modelContext.fetch(FetchDescriptor<User>(sortBy: [SortDescriptor(\.id)])))
        } catch {
            print(error.localizedDescription)
            return .failure(error)
        }
    }
    
    func createUser(name: String, email: String, phoneNumber: String) {
        let user = User(id: randomId, name: name, phoneNumber: phoneNumber, email: email, status: .active)
        modelContext.insert(user)
    }
    
    func updateUser(_ user: User, name: String, email: String, phoneNumber: String) {
        user.name = name
        user.email = email
        user.phoneNumber = phoneNumber
    }
}
