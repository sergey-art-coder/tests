//
//  QuestionProvider.swift
//  tests
//
//  Created by Сергей Ляшенко on 09.12.2021.
//

import Foundation
import RealmSwift

class QuestionRealmBD {

    lazy var configuration = Realm.Configuration(schemaVersion: 21)
    lazy var realm = try! Realm(configuration: configuration)

    func fetchRandom(for difficulty: Int) -> Question? {
        let questions = realm.objects(Question.self).filter("difficulty == \(difficulty)")
        return questions.count > 0 ? questions[Int.random(in: 0...questions.count - 1)] : nil
    }
    
    func numberOfQuestions(for difficulty: Int) -> Int? {
        
        return realm.objects(Question.self).filter("difficulty == \(difficulty)").count
    }
}

