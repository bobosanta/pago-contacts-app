//
//  UsersViewModel.swift
//  Pago Contacts App
//
//  Created by Santamarian Bogdan on 20.03.2024.
//

import Combine
import Foundation
import SwiftData

@Observable
final class UsersViewModel {
    
    var error: Error?
    private let userService: UserService
    
    private(set) var users: [User] = []
    
    init(modelContext: ModelContext) {
        self.userService = UserService(modelContext: modelContext)
        Task {
            await loadUsers()
        }
    }
    
    func loadUsers() async {
        let usersExistResult = userService.usersExist()
        switch usersExistResult {
        case let .success(usersExist):
            if !usersExist {
                let fetchUsersResult = await userService.fetchUsers()
                switch fetchUsersResult {
                case let.success(users):
                    self.users = users
                case let.failure(error):
                    self.error = error
                }
            }
        case let .failure(error):
            self.error = error
        }
    }
    
}
