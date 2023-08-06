//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Liz-Mary on 16.07.2023.
//

import Foundation

struct WordCheckResult {
    let word: String
    let isCorrect: Bool
}

class FeedViewModel {
    private let model: FeedModel
    var wordCheckResult: ((WordCheckResult) -> Void)?
    var navigateToPost: ((String) -> Void)?
    
    init() {
        model = FeedModel(secretWord: "Ура")
    }
    
    func button1Tapped() {
        navigateToPost?("Интересный факт")
    }
    
    func button2Tapped() {
        navigateToPost?("Научные статьи")
    }
    
    func checkButtonTapped(word: String?) {
        guard let word = word else { return }
        
        let isCorrect = model.check(word: word)
        let result = WordCheckResult(word: word, isCorrect: isCorrect)
        wordCheckResult?(result)
    }
}

