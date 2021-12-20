//
//  Game.swift
//  tests
//
//  Created by Сергей Ляшенко on 09.12.2021.
//

import Foundation

final class Game {
    
    static let shared = Game()
    private init() {}
    
    let version = "1.0."
    
    let payout = [
        1: 100,
        2: 200,
        3: 300,
        4: 500,
        5: 1_000,
        6: 2_000,
        7: 4_000,
        8: 8_000,
        9: 16_000,
        10: 32_000,
        11: 64_000,
        12: 125_000,
        13: 250_000,
        14: 500_000,
        15: 1_000_000,
    ]
    
    let letterForAnswerIndex = [
        0: "A",
        1: "B",
        2: "C",
        3: "D",
    ]
    
    let questionsTotal = 15
    let delayInterval: TimeInterval = 1.0
    
    var gameSession: GameSession?
    
    var percentage: Int {
        
        var current = self.gameSession?.currentQuestionNo ?? 0
        if current > 0 { current -= 1}
        
        return current * 100 / questionsTotal
    }
    var currentQuestion: String {
        return self.gameSession?.currentQuestion?.text ?? ""
    }
    
    var correctAnswer: String {
        return self.gameSession?.currentQuestion?.answers[self.gameSession?.currentQuestion?.correctIndex ?? 0].text ?? ""
    }
}


