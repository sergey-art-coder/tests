////
////  GameCaretaker.swift
////  tests
////
////  Created by Сергей Ляшенко on 16.12.2021.
////
//
//import Foundation
//
//class GameCaretakerUserDefaults: GameCaretakerProtocol {
//    private let decoder = JSONDecoder()
//    private let encoder = JSONEncoder()
//    private let key = "records"
//
//    func save(records: [Record]) {
//        do {
//            // кодируем в data наши Record
//            let data = try self.encoder.encode(records)
//
//            // записываем в UserDefaults
//            UserDefaults.standard.set(data, forKey: key)
//
//        } catch {
//            print(error)
//        }
//    }
//
//    func retrieveRecords() -> [Record] {
//        guard let data = UserDefaults.standard.data(forKey: key) else {
//            return []
//        }
//        do {
//            return try self.decoder.decode([Record].self, from: data)
//        } catch {
//            print(error)
//            return []
//        }
//    }
//}
//
