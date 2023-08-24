//
//  LoginManager.swift
//  Navigation
//
//  Created by Liz-Mary on 06.08.2023.
//

import UIKit


struct LoginManager {
    static func login(
        withLogin login: String,
        password: String,
        delegate: LoginViewControllerDelegate,
        navigationController: UINavigationController?,
        userService: UserService,
        completion: @escaping (Result<User, AppError>) -> Void
    ) {
        guard !login.isEmpty else {
            completion(.failure(.emptyLoginField))
            return
        }
        
        guard !password.isEmpty else {
            completion(.failure(.emptyPasswordField))
            return
        }
        
        do {
            let isValid = try delegate.check(login: login, password: password)
            
            if isValid {
                guard let user = userService.getUser(login: login) else {
                    completion(.failure(.userServiceError("User not found")))
                    return
                }
                completion(.success(user))
            } else {
                completion(.failure(.loginFailed))
            }
        } catch AppError.userServiceError(let message) {
            completion(.failure(.userServiceError(message)))
        } catch {
            completion(.failure(.unknownError))
        }
    }
}
