//
//  Question.swift
//  tests
//
//  Created by Сергей Ляшенко on 09.12.2021.
//

import Foundation
import RealmSwift

// модель для хранения данных (вопросы)
class Question: Object {
    
    @Persisted var difficulty: Int
    @Persisted var text: String
    @Persisted var answers: List<Answer>
}
