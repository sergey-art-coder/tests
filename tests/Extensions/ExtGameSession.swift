//
//  GameSession.swift
//  tests
//
//  Created by Сергей Ляшенко on 13.12.2021.
//

import Foundation

extension GameSession {
    
    // Заработанные деньги.
    var earnedMoney: Int {
        
        let game = Game.shared
        return game.payout[self.currentQuestionNo - 1] ?? 0
    }
    
    // Гарантированные заработанные деньги.
    var earnedMoneyGuaranteed: Int {
        
        let game = Game.shared
        
        switch self.currentQuestionNo {
        case 0...5: return 0
        case 6...10: return game.payout[5] ?? 0
        case 11...15: return game.payout[10] ?? 0
        default: return 0
        }
    }
}
