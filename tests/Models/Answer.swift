//
//  Answer.swift
//  tests
//
//  Created by Сергей Ляшенко on 10.12.2021.
//

import Foundation
import RealmSwift

// модель для хранения данных (ответы)
class Answer: Object {
    
    @Persisted var text: String
    @Persisted var correct: Bool
}
