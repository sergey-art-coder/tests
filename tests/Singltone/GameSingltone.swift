//
//  Game.swift
//  tests
//
//  Created by Сергей Ляшенко on 16.12.2021.
//

import Foundation

final class GameSingltone {
    
    static let shared = GameSingltone()
    
    private(set) var records: [Record] = [] {
        
        didSet {
            recordsCaretaker.save(records: self.records)
        }
    }

    private let recordsCaretaker: GameCaretakerProtocol

    private init() {
        self.recordsCaretaker = GameCaretakerRealm()
        self.records = self.recordsCaretaker.retrieveRecords()
    }
    
    func addRecord(_ record: Record) {
        self.records.append(record)
//        print(record)
    }
    
    func clearRecords() {
        self.records = []
    }
}
