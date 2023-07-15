//
//  TestUserService.swift
//  Navigation
//
//  Created by Liz-Mary on 14.06.2023.
//

import Foundation

class TestUserService: UserService {

    private let testUser: User
    
    init(user: User) {
        self.testUser = user
    }
    
    func getUser(login: String) -> User? {
        if login == testUser.login {
            return testUser
        } else {
            return nil
        }
    }
}
