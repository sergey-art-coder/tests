//
//  GameSession.swift
//  tests
//
//  Created by Сергей Ляшенко on 09.12.2021.
//

import Foundation
import RealmSwift

class GameSession: Object {
    
    @Persisted var currentQuestionNo: Int
    
    @Persisted var fiftyFiftyUsed: Bool
    @Persisted var hallHelpUsed: Bool
    @Persisted var callFriendUsed: Bool
    
    @Persisted var currentQuestion: Question?
    
}
