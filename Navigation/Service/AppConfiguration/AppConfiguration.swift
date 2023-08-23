//
//  AppConfiguration.swift
//  Navigation
//
//  Created by Liz-Mary on 20.08.2023.
//

import Foundation

enum AppConfiguration {
    case people, films, planets
    
    var url: URL {
        switch self{
        case .people:
            return URL(string: "https://swapi.dev/api/peoples/3")!
        case .films:
            return URL(string: "https://swapi.dev/api/films/3")!
        case .planets:
            return URL(string: "https://swapi.dev/api/planets/7")!
        }
    }
}
