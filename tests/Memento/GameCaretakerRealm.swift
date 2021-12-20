//
//  GameCaretakerRealm.swift
//  tests
//
//  Created by Сергей Ляшенко on 18.12.2021.
//

import Foundation
import RealmSwift

class GameCaretakerRealm: GameCaretakerProtocol {
    let game = Game.shared

    lazy var configuration = Realm.Configuration(schemaVersion: 21)
    lazy var realm = try! Realm(configuration: configuration)
    func delete() {
//        let records = Record()
//        realm.beginWrite()
//        realm.delete(records)
//        try? realm.commitWrite()
        
        let result = realm.objects(Record.self)
        realm.delete(result)
        
    }
    func save(records: [Record]) {
        
        do {
            let records = Record()
            
            records.earnedMoney = game.gameSession?.earnedMoneyGuaranteed ?? 0
            records.correctAnswers = (game.gameSession?.currentQuestionNo ?? 0) - 1
            records.percentageCorrectAnswers = game.percentage
            
            records.fiftyFifty = game.gameSession?.fiftyFiftyUsed ?? false ?  "Да" : "Нет"
            records.hallHelp = game.gameSession?.hallHelpUsed ?? false ? "Да" : "Нет"
            records.callFriend = game.gameSession?.callFriendUsed ?? false ? "Да" : "Нет"
            
            realm.beginWrite()
            realm.add(records)
//            print(records)
            try realm.commitWrite()
            
        } catch {
            
            print(error.localizedDescription)
        }
    }

    func printDB() {
        print(realm.configuration.fileURL as Any)
    }
    func retrieveRecords() -> [Record] {
        //прочитать объекты которые сохранили
        let records = realm.objects(Record.self)
//        print(records)
        //переделываем в массив Swift и возврвщаем назад
        return Array(records)
    }
}

