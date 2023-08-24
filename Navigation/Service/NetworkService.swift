//
//  NetworkService.swift
//  Navigation
//
//  Created by Liz-Mary on 20.08.2023.
//

import Foundation
import UIKit
//error code: -1009
import Foundation
import UIKit
//error code: -1009
struct NetworkService {
    static func request(for configuration: AppConfigurations, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: configuration.url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            

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
            }
        }
        task.resume()
    }
}
