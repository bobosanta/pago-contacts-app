//
//  UserServiceMock.swift
//  Pago Contacts AppTests
//
//  Created by Santamarian Bogdan on 20.03.2024.
//

import Foundation
@testable import Pago_Contacts_App

class UserServiceMock: UserService {
    
    var doUsersExist = false
    private(set) var isUsersExistCalled = false
    private(set) var isFetchUsersCalled = false
    private(set) var isGetUsersFromDbCalled = false
    private(set) var isCreateUserCalled = false
    private(set) var isUpdateUserCalled = false
    
    func usersExist() -> Result<Bool, Error> {
        isUsersExistCalled = true
        return doUsersExist ? .success(true) : .success(false)
    }
    
    func fetchUsers() async -> Result<[User], Error> {
        isFetchUsersCalled = true
        return .success([])
    }
    
    func getUsersFromDb() -> Result<[User], Error> {
        isGetUsersFromDbCalled = true
        return .success([])
    }
    
    func createUser(name: String, email: String, phoneNumber: String) {
        isCreateUserCalled = true
    }
    
    func updateUser(_ user: Pago_Contacts_App.User, name: String, email: String, phoneNumber: String) {
        isUpdateUserCalled = true
    }
    
}
