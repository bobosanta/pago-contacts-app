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
    
    init(userService: UserService) {
        self.userService = userService
        Task {
            await loadUsers()
        }
    }
    
    private func loadUsers() async {
        let usersExistResult = userService.usersExist()
        switch usersExistResult {
        case let .success(usersExist):
            if usersExist {
                getUsersFromDb()
            } else {
                await fetchUsers()
            }
        case let .failure(error):
            self.error = error
        }
    }
    
    private func getUsersFromDb() {
        let getUsersResult = userService.getUsersFromDb()
        switch getUsersResult {
        case let .success(users):
            self.users = users
        case let .failure(error):
            self.error = error
        }
    }
    
    private func fetchUsers() async {
        let fetchUsersResult = await userService.fetchUsers()
        switch fetchUsersResult {
        case let.success(users):
            self.users = users
        case let.failure(error):
            self.error = error
        }
    }
    
}
