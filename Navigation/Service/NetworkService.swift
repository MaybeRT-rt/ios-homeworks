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
    static func request(for configuration: AppConfigurations, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let session = URLSession.shared
        
        let task = session.dataTask(with: configuration.url) { data, response, error in
            DispatchQueue.global().async {
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                    return
                }
                
                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkError.noData))
                    }
                    return
                }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        DispatchQueue.main.async {
                            completion(.success(json))
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(.failure(NetworkError.invalidResponse))
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }
        task.resume()
    }
}
