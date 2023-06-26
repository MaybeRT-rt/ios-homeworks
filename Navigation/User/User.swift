//
//  User.swift
//  Navigation
//
//  Created by Liz-Mary on 14.06.2023.
//

import UIKit
import Foundation

class User {
    
    let login: String
    let fullName: String
    let avatar: UIImage
    let status: String
    
    init(login: String, fullName: String, avatar: UIImage, status: String) {
        self.login = login
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
}

protocol UserService {
    func getUser(login: String) -> User?
}

