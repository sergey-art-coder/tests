//
//  MainViewController.swift
//  tests
//
//  Created by Сергей Ляшенко on 11.12.2021.
//

import UIKit
import RealmSwift
import SwiftUI

class MainViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    
    let game = Game.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        if game.gameSession == nil { resultLabel.text = "" }
        versionLabel.text = "ver. \(game.version)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { switch segue.identifier {

    case "toGameVC":

        guard let destination = segue.destination as? GameViewController else { return }
        destination.gameDelegate = self
    default:
        break
    }

    }
    
    // Создаем метод который будет маркером для перехода назад (Unwind Segue)
    @IBAction func backToLogin (unwindSegue: UIStoryboardSegue) {

    }
}

extension MainViewController: GameViewControllerDelegate {
    
    func didEndGame(withResult result: GameSession) {
        
        game.gameSession = result
        
        let earnedMoney = (game.gameSession?.earnedMoneyGuaranteed ?? 0)
        let correctAnswers = ((game.gameSession?.currentQuestionNo ?? 0) - 1)
        let percentageCorrectAnswers = (game.percentage)

        let fiftyFifty = (game.gameSession?.fiftyFiftyUsed ?? false ?  "Да" : "Нет")
        let hallHelp = (game.gameSession?.hallHelpUsed ?? false ? "Да" : "Нет")
        let callFriend = (game.gameSession?.callFriendUsed ?? false ? "Да" : "Нет")

        resultLabel.text = """
        РЕЗУЛЬТАТ ПОСЛЕДНЕЙ ИГРЫ
        Заработано: \(result.earnedMoneyGuaranteed ) ₽
        Правильные ответы: \((result.currentQuestionNo ) - 1) из \(game.questionsTotal)
        \n \(game.percentage)% от общего числа вопросов получили правильные ответы
        
        ПОДСКАЗКИ
        50/50: \(result.fiftyFiftyUsed ? "Да" : "Нет")
        Помощь зала: \(result.hallHelpUsed ? "Да" : "Нет")
        Звонок другу: \(result.callFriendUsed ? "Да" : "Нет")

        """
//        let record = Record(date: Date(), earnedMoney: earnedMoney, correctAnswers: correctAnswers, percentageCorrectAnswers: percentageCorrectAnswers, fiftyFifty: fiftyFifty, hallHelp: hallHelp, callFriend: callFriend)
        let record = Record()

        GameSingltone.shared.addRecord(record)
        
    }
}
