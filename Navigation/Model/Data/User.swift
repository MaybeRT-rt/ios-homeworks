//
//  User.swift
//  Navigation
//
//  Created by Liz-Mary on 05.09.2023.
//

import Foundation
import UIKit

public class User {
    var login: String
    var fullName: String
    var status: String
    var avatar: UIImage
    
    init(login: String, fullName: String, status: String, avatar: UIImage) {
        self.login = login
        self.fullName = fullName
        self.status = status
        self.avatar = avatar
    }
}

protocol UserService {
    
    func autorization (login: String) -> User?
}

class CurrentUserService: UserService {
    var user: User
    
    init (user: User) {
        self.user = user
    }
    
    
    func autorization(login: String) -> User? {
        if login == user.login{
            return user
        }
        return nil
    }
}
