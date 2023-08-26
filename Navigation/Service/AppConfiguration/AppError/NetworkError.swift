//
//  NetworkError.swift
//  Navigation
//
//  Created by Liz-Mary on 20.08.2023.
//

import Foundation

enum NetworkError: Error {
    case invalideURL
    case requestFailed(statusCode: Int)
    case invalidResponse
    case noData
    case noEnternetConnection
}
