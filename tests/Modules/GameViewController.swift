//
//  ViewController.swift
//  tests
//
//  Created by Сергей Ляшенко on 08.12.2021.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var amountMoneyWonLabel: UILabel!
    @IBOutlet weak var currentQuestionNumberLabel: UILabel!
    @IBOutlet weak var currentQuestionLabel: UILabel!
    
    @IBOutlet weak var answerButtonA: UIButton!
    @IBOutlet weak var answerButtonB: UIButton!
    @IBOutlet weak var answerButtonC: UIButton!
    @IBOutlet weak var answerButtonD: UIButton!
    
    
    @IBOutlet weak var fiftyFiftyButton: UIButton!
    @IBOutlet weak var hallHelpButton: UIButton!
    @IBOutlet weak var callFriendButton: UIButton!
    
    @IBOutlet weak var takeMoneyButton: UIButton!

    
    // MARK: - Array of answer buttons.
    
    lazy var answerButtons = [answerButtonA, answerButtonB, answerButtonC, answerButtonD]
    
    // MARK: - Instances.
    
    let game = Game.shared
    let gameSession = GameSession()
    let questionRealmBD = QuestionRealmBD()
    
    
    // MARK: - Messages.
    
    let audienceTitle = "Помощь зала"
    let audienceMessage = "Большинство зрителей в зале считает, что правильный ответ — "
    
    let friendTitle = "Звонок другу"
    let friendMessage = "Извини, приятель, точно не знаю, но больше склоняюсь к варианту "
    
    let endGameTitle = "Забрать выиграш?"
    lazy var endGameMessage = """
        Вы уверены что хотите завершить игру
        и забрать ваш выигрыш
        \(gameSession.earnedMoney.formatted) ₽?
        """
    
    let gameOverTitle = "Вы ошиблись"
    lazy var gameOverMessage = """
        Ответ неверный!
        Ваш выигрыш \(gameSession.earnedMoneyGuaranteed > 0 ? "в размере несгораемого остатка равен \("\n" + gameSession.earnedMoneyGuaranteed.formatted) ₽." : "равен нулю.")
        Игра окончена.
        """
    
    let gameWinTitle = "Поздравляю! Вы выиграли"
    let gameWinMessage = """
        Поздравляю! Вы выиграли три миллиона рублей!
        """
    
    // MARK: - Private methods.
    
    private func addButtonActions() {
        
        for button in answerButtons {
            button?.addTarget(self, action: #selector(answerButtonAction), for: .touchUpInside)
        }
    }
    
    private func resetGameSession() {
        
        gameSession.currentQuestionNo = 1
        gameSession.fiftyFiftyUsed = false
        gameSession.hallHelpUsed = false
        gameSession.callFriendUsed = false
    }
    
    private func displayQuestion() {
        
        let difficultyIndex = gameSession.currentQuestionNo
        
        updateButtons()
        
        guard let question = questionRealmBD.fetchRandom(for: difficultyIndex) else { return }
        guard let questionValue = game.payout[difficultyIndex] else { return }
        
        amountMoneyWonLabel.text = "\(questionValue.formatted) ₽"
        currentQuestionNumberLabel.text = "ВОПРОС  \(difficultyIndex) из \(game.questionsTotal) "
        currentQuestionLabel.text = question.text
        
        for (index, answer) in question.answers.enumerated() {
            answerButtons[index]?.setTitle(answer.text, for: .normal)
            answerButtons[index]?.backgroundColor = .unanswered
            answerButtons[index]?.alpha = 1.0
            answerButtons[index]?.isEnabled = true
            answerButtons[index]?.isHidden = false
        }
        
        gameSession.currentQuestion = question
    }
    
    private func disableButtons(_ answerIndex: Int) {
        
        fiftyFiftyButton.isEnabled = false
        fiftyFiftyButton.alpha = 0.75
        
        hallHelpButton.isEnabled = false
        hallHelpButton.alpha = 0.75
        
        callFriendButton.isEnabled = false
        callFriendButton.alpha = 0.75

        takeMoneyButton.isEnabled = false
        takeMoneyButton.alpha = 0.75
        
        for button in answerButtons {
            button?.isEnabled = false
            button?.alpha = button?.tag != answerIndex ? 0.75 : 1.0
        }
    }
    
    private func isCorrect(_ answerIndex: Int) -> Bool {
        
        return gameSession.currentQuestion?.answers[answerIndex].correct ?? false
    }
    
    private func updateButtons() {
        
        if gameSession.fiftyFiftyUsed {
            fiftyFiftyButton.isEnabled = false
            fiftyFiftyButton.alpha = 0.75
        } else {
            fiftyFiftyButton.isEnabled = true
            fiftyFiftyButton.alpha = 1.0
        }
        
        if gameSession.hallHelpUsed {
            hallHelpButton.isEnabled = false
            hallHelpButton.alpha = 0.75
        } else {
            hallHelpButton.isEnabled = true
            hallHelpButton.alpha = 1.0
        }
        
        if gameSession.callFriendUsed {
            callFriendButton.isEnabled = false
            callFriendButton.alpha = 0.75
        } else {
            callFriendButton.isEnabled = true
            callFriendButton.alpha = 1.0
        }

        if gameSession.earnedMoney == 0 {
            
            takeMoneyButton.setTitle("Забрать деньги и завершить игру.", for: .normal)
            takeMoneyButton.isEnabled = false
            takeMoneyButton.alpha = 0.75
            
        } else {
            
            takeMoneyButton.setTitle("Забрать \(gameSession.earnedMoney.formatted) ₽ и завершить игру.", for: .normal)
            takeMoneyButton.isEnabled = true
            takeMoneyButton.alpha = 1.0
        }
    }
    
    // MARK: - Actions.
    
    @objc func answerButtonAction(_ sender: UIButton!) {
        
        let answerIndex = sender.tag
     
        disableButtons(answerIndex)
        answerButtons[answerIndex]?.backgroundColor = .answered
        
        delay { [self] in
            
            if isCorrect(answerIndex) {
                // Ответ верный. Идём дальше
                answerButtons[answerIndex]?.backgroundColor = .correct
                delay {
                    if gameSession.currentQuestionNo < game.questionsTotal {
                        nextQuestion()
                    } else {
                        // Игра окончена. Игрок выиграл максимальную суммму.
                        gameWin(answerIndex)
                    }
                }
            } else {
                // Ответ неверный. Завершаем игру.
                gameOver(answerIndex)
            }
        }
     }
    
    @IBAction func fiftyFiftyAction(_ sender: Any) {
        
        guard let firstIndex = gameSession.currentQuestion?.correctIndex else { return }
        let secondIndex = Int.random(in: 0...3, excluding: firstIndex)
        
        fiftyFiftyButton.isEnabled = false
        fiftyFiftyButton.alpha = 0.75
        gameSession.fiftyFiftyUsed = true
        
        for button in answerButtons {
            
            if button?.tag != firstIndex && button?.tag != secondIndex {
                
                button?.isEnabled = false
                button?.isHidden = true
            }
        }
    }
    
    @IBAction func hallHelpAction(_ sender: Any) {
        
        guard let firstIndex = gameSession.currentQuestion?.correctIndex else { return }
        let secondIndex = Int.random(in: 0...3, excluding: firstIndex)
        
        var audienceSuggests = 0
        
        if gameSession.hallHelpUsed { audienceSuggests = firstIndex } else {
            audienceSuggests = Int.random(in: 0...1) == 1 ? firstIndex : secondIndex
        }
        
        hallHelpButton.isEnabled = false
        hallHelpButton.alpha = 0.75
        gameSession.hallHelpUsed = true
        
        let answer = game.letterForAnswerIndex[audienceSuggests] ?? "Х/З"
        
        delay { [self] in
            displayAlert(withAlertTitle: audienceTitle,
                         andMessage: audienceMessage + "\(answer).")
        }
    }
    
    @IBAction func callFriendAction(_ sender: Any) {
        
        guard let firstIndex = gameSession.currentQuestion?.correctIndex else { return }
        let secondIndex = Int.random(in: 0...3, excluding: firstIndex)
        
        var friendSuggests = 0
        
        if gameSession.callFriendUsed { friendSuggests = firstIndex } else {
            friendSuggests = Int.random(in: 0...1) == 1 ? firstIndex : secondIndex
        }
        
        callFriendButton.isEnabled = false
        callFriendButton.alpha = 0.75
        gameSession.callFriendUsed = true
        
        let answer = game.letterForAnswerIndex[friendSuggests] ?? "Х/З"
        let answerText = gameSession.currentQuestion?.answers[friendSuggests].text ?? "Х/3"
        
        delay { [self] in
            displayAlert(withAlertTitle: friendTitle,
                         andMessage: friendMessage + "\(answer). \(answerText).")
        }
    }
    
    @IBAction func takeMoneyAction(_ sender: Any) {
        
        displayYesNoAlert(withAlertTitle: endGameTitle,
                          andMessage: endGameMessage) { _ in
            _ = self.navigationController?.popToRootViewController(animated: true)
        }
    }

    // MARK: - Game lifecycle methods.
    
    func nextQuestion() {
        
        gameSession.currentQuestionNo += 1
        displayQuestion()
    }
    
    func gameOver(_ answerIndex: Int) {
        
        answerButtons[answerIndex]?.backgroundColor = .incorrect

        answerButtons[gameSession.currentQuestion?.correctIndex ?? 0]?.backgroundColor = .correct
        answerButtons[gameSession.currentQuestion?.correctIndex ?? 0]?.alpha = 1.0
        
        delay { [self] in
            displayAlert(withAlertTitle: gameOverTitle, andMessage: gameOverMessage) { _ in
                _ = navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    func gameWin(_ answerIndex: Int) {

        answerButtons[answerIndex]?.backgroundColor? = .correct
        answerButtons[gameSession.currentQuestion!.correctIndex]?.alpha = 1.0

        delay { [self] in
            displayAlert(withAlertTitle: gameWinTitle, andMessage: gameWinMessage) { _ in
                _ = navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    // MARK: - View controller methods.
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        resetGameSession()
        addButtonActions()
        displayQuestion()
    }
}
