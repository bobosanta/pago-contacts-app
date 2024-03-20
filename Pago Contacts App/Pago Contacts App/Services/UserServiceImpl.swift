//
//  UserServiceImpl.swift
//  Pago Contacts App
//
//  Created by Santamarian Bogdan on 19.03.2024.
//

import Foundation
import SwiftData

class UserServiceImpl: UserService {
    
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
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

            return .success(users)
        } catch {
            print(error.localizedDescription)
            return .failure(error)
        }
    }
    
    func getUsersFromDb() -> Result<[User], Error> {
        do {
            return .success(try modelContext.fetch(FetchDescriptor<User>()))
        } catch {
            print(error.localizedDescription)
            return .failure(error)
        }
    }
    
}
