//
//  AppError.swift
//  Navigation
//
//  Created by Liz-Mary on 06.08.2023.
//

import UIKit

enum AppError: Error {
    case loginFailed
    case emptyLoginField
    case emptyPasswordField
    case bruteForceError
    case userServiceError(String)
    case unknownError
    case userExists
}
