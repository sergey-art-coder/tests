//
//  GameCaretakerProtocol.swift
//  tests
//
//  Created by Сергей Ляшенко on 19.12.2021.
//

import Foundation

// 2. Memento
typealias Memento = Data

// 3. Caretaker
protocol GameCaretakerProtocol {
    func save(records: [Record])
    func retrieveRecords() -> [Record]
}
