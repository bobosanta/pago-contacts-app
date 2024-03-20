//
//  UsersViewModelTests.swift
//  Pago Contacts AppTests
//
//  Created by Santamarian Bogdan on 20.03.2024.
//

@testable import Pago_Contacts_App
import XCTest

final class UsersViewModelTests: XCTestCase {

    var sut: UsersViewModel!
    var userService: UserServiceMock!
    
    override func setUp() {
        userService = UserServiceMock()
        sut = UsersViewModel(userService: userService)
    }
    
    override func tearDown() {
        userService = nil
        sut = nil
    }

    func testLoadUsers_usersExist() async {
        userService.doUsersExist = true
        
        await sut.loadUsers()
        XCTAssertTrue(userService.isUsersExistCalled)
        XCTAssertTrue(userService.isGetUsersFromDbCalled)
        XCTAssertFalse(userService.isFetchUsersCalled)
    }
    
    func testLoadUsers_usersDontExist() async {
        userService.doUsersExist = false
        
        await sut.loadUsers()
        XCTAssertTrue(userService.isUsersExistCalled)
        XCTAssertFalse(userService.isGetUsersFromDbCalled)
        XCTAssertTrue(userService.isFetchUsersCalled)
    }

}
