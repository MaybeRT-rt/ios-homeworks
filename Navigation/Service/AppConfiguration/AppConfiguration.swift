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
            return URL(string: "https://swapi.dev/api/peoples/")!
        case .films:
            return URL(string: "https://swapi.dev/api/films/")!
        case .planets:
            return URL(string: "https://swapi.dev/api/planets/")!
        }
    }
}

struct AppConfigurations {
    let url: URL
}

