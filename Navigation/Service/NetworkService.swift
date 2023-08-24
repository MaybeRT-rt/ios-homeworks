//
//  NetworkService.swift
//  Navigation
//
//  Created by Liz-Mary on 20.08.2023.
//

import Foundation
import UIKit
//error code: -1009
struct NetworkService {
    static func request(for configuration: AppConfigurations, completion: @escaping (Result<String, Error>) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: configuration.url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                completion(.success(dataString))
            }
        }
        task.resume()
    }
}
