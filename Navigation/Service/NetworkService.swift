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
<<<<<<< HEAD
    static func request(for configuration: AppConfigurations, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let session = URLSession(configuration: .default)
=======

    static func request(for configuration: AppConfigurations, completion: @escaping (Result<String, Error>) -> Void) {
        let session = URLSession.shared
>>>>>>> b9a518b39c4e59e3b95b30206575dd282081d5c3
        let task = session.dataTask(with: configuration.url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
<<<<<<< HEAD
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                let statusCodeError = NSError(domain: "HTTP", code: -1, userInfo: [NSLocalizedDescriptionKey: "HTTP request failed"])
                completion(.failure(statusCodeError))
                return
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    completion(.success(json))
                } catch {
                    completion(.failure(error))
                }
=======
            if let data = data, let dataString = String(data: data, encoding: .utf8) {

                completion(.success(dataString))
>>>>>>> b9a518b39c4e59e3b95b30206575dd282081d5c3
            }
        }
        task.resume()
    }
}
