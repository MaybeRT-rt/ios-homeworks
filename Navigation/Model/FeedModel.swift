//
//  FeedModel.swift
//  Navigation
//
//  Created by Liz-Mary on 13.07.2023.
//

import Foundation

class FeedModel {
    var secretWord: String
    
    init(secretWord: String) {
        self.secretWord = secretWord
    }
    
    func check(word: String) -> Bool {
        return word == secretWord
    }
}
