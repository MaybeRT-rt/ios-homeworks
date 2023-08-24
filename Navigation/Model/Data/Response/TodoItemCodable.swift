//
//  TodoItemCodable.swift
//  Navigation
//
//  Created by Liz-Mary on 24.08.2023.
//

import Foundation

struct TodoItem: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
