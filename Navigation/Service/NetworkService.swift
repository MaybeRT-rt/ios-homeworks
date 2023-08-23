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
    static func request(for configuration: AppConfiguration, completion: @escaping (Result<String, Error>) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: configuration.url) { data, response, error in
            if let error = error {
                if let urlError = error as? URLError {
                    if urlError.code == .notConnectedToInternet {
                        print("No internet connection: \(urlError.localizedDescription)")
                    } else {
                        print("Network error: \(urlError.localizedDescription)")
                    }
                } else {
                    print("Error: \(error.localizedDescription)")
                }
            }
            
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Data:", dataString)
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("Status Code:", httpResponse.statusCode)
                    print("Headers:", httpResponse.allHeaderFields)
                }
                
                completion(.success(dataString))
            }
        }
        task.resume()
    }
}
