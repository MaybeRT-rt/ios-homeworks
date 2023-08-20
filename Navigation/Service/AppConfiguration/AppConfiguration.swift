//
//  AppConfiguration.swift
//  Navigation
//
//  Created by Liz-Mary on 20.08.2023.
//

import Foundation

enum AppConfiguration {
    case people, films, planet
    
    var url: URL {
        switch self{
        case .people:
            return URL(string: "https://swapi.dev/api/peoples/7")!
        case .films:
            return URL(string: "https://swapi.dev/api/films/10")!
        case .planet:
            return URL(string: "https://swapi.dev/api/planets/5")!
        }
    }
}
