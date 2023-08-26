//
//  Planet.swift
//  Navigation
//
//  Created by Liz-Mary on 24.08.2023.
//

import Foundation

struct Planet: Decodable {
    let name: String
    let orbitalPeriod: String
    let residents: [URL]
    
    enum CodingKeys: String, CodingKey {
        case name
        case orbitalPeriod = "orbital_period"
        case residents
    }
}
