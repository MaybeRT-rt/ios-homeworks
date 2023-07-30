//
//  PasswordBruteForce.swift
//  Navigation
//
//  Created by Liz-Mary on 30.07.2023.
//

import Foundation

class PasswordBruteForce {
    private let characters = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
    
    func generateRandomPassword(length: Int) -> String {
        var password = ""
        for _ in 0..<length {
            let randomIndex = Int.random(in: 0..<characters.count)
            password.append(characters[randomIndex])
        }
        return password
    }
    
    func bruteForce(passwordToCrack: String, completion: @escaping (String?) -> Void) {
        let passwordLength = passwordToCrack.count
        var currentPassword = ""
        
        while currentPassword != passwordToCrack {
            currentPassword = generateRandomPassword(length: passwordLength)
        }
        
        completion(currentPassword)
    }
}
