//
//  Checker.swift
//  Navigation
//
//  Created by Liz-Mary on 20.06.2023.
//

import Foundation

class Checker {
    
    static let shared = Checker()
    
    private let login: String
    private let password: String
    
    private init() {
        login = "adm"
        password = "a123"
    }
    
    func check(login: String, password: String) -> Bool {
        return self.login == login && self.password == password
    }
}

protocol LoginViewControllerDelegate {
    func check(login: String, password: String) throws -> Bool
}

struct LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        return Checker.shared.check(login: login, password: password)
    }
}

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}
