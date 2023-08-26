//
//  extensionURLSession.swift
//  Navigation
//
//  Created by Liz-Mary on 25.08.2023.
//

import Foundation

extension URLSession {
    func decode<T: Decodable>(from url: URL) async throws -> T {
        let (data, _) = try await data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
