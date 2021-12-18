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
        
        let fiftyFifty = (game.gameSession?.fiftyFiftyUsed ?? false ? 1 : 0)
        let hallHelp = (game.gameSession?.hallHelpUsed ?? false ? 1 : 0)
        let callFriend = (game.gameSession?.callFriendUsed ?? false ? 1 : 0)

        resultLabel.text = """
        РЕЗУЛЬТАТ ПОСЛЕДНЕЙ ИГРЫ
        Заработано: \(earnedMoney) ₽
        Правильные ответы: \(correctAnswers) из \(game.questionsTotal)
        \n \(percentageCorrectAnswers)% от общего числа вопросов получили правильные ответы
        
        ПОДСКАЗКИ
        50/50: \(game.gameSession?.fiftyFiftyUsed ?? false ? "Да" : "Нет")
        Помощь зала: \(game.gameSession?.hallHelpUsed ?? false ? "Да" : "Нет")
        Звонок другу: \(game.gameSession?.callFriendUsed ?? false ? "Да" : "Нет")

        """
        let record = Record(date: Date(), earnedMoney: earnedMoney, correctAnswers: correctAnswers, percentageCorrectAnswers: percentageCorrectAnswers, fiftyFifty: fiftyFifty, hallHelp: hallHelp, callFriend: callFriend)
        GameSingltone.shared.addRecord(record)
        
    }
}
