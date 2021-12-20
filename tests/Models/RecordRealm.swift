//
//  RecordRealm.swift
//  tests
//
//  Created by Сергей Ляшенко on 18.12.2021.
//

import Foundation
import RealmSwift

// 1. Originator
class Record: Object {
    @objc dynamic var date: Date = Date()
    
    @objc dynamic var earnedMoney: Int = 0
    @objc dynamic var correctAnswers: Int = 0
    @objc dynamic var percentageCorrectAnswers: Int = 0

    @objc dynamic var fiftyFifty: String = ""
    @objc dynamic var hallHelp: String = ""
    @objc dynamic var callFriend: String = ""
}

