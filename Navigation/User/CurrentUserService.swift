//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Liz-Mary on 14.06.2023.
//

import Foundation

class CurrentUserService: UserService {

    private let currentUser: User
    
    init(user: User) {
        self.currentUser = user
    }
    
    func getUser(login: String) -> User? {
        if login == currentUser.login {
            return currentUser
        } else {
            return nil
        }
    }
}
