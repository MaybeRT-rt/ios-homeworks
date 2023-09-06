//
//  FeedModel.swift
//  Navigation
//
//  Created by Liz-Mary on 05.09.2023.
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
