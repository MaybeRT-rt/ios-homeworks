//
//  CheckerService.swift
//  Navigation
//
//  Created by Liz-Mary on 05.09.2023.
//

import Foundation
import Firebase

protocol LoginFactory {
    func makeLoginInspector () -> CheckerService
}

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> CheckerService {
        CheckerService()
    }
}

protocol CheckerServiceProtocol {
    
    func checkCredentials(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func createUser(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func checkIfUserExists(email: String, completion: @escaping (Bool) -> Void)
}

class CheckerService: CheckerServiceProtocol {
    
    func checkCredentials(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    func createUser(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func checkIfUserExists(email: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().fetchSignInMethods(forEmail: email) { (methods, error) in
            if let error = error {
                print("Ошибка при проверке существования пользователя: \(error.localizedDescription)")
                completion(false)
            } else if let methods = methods {
                completion(methods.isEmpty)
            } else {
                completion(false)
            }
        }
    }
}


