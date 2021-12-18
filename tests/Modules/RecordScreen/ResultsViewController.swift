//
//  ResultsViewController.swift
//  tests
//
//  Created by Сергей Ляшенко on 16.12.2021.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var records = GameSingltone.shared.records
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "RecordTableViewCell", bundle: nil), forCellReuseIdentifier: "RecordTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.reloadData()
    }
}

extension ResultsViewController: UITableViewDelegate {
    
}

extension ResultsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RecordTableViewCell", for: indexPath) as? RecordTableViewCell {
            
            let record = records.reversed()[indexPath.row]
            
            cell.dataLabel.text = record.date.formatted(date: .abbreviated, time: .shortened)
            
            cell.currentQuestionNoLabel.text =
                    """
                    РЕЗУЛЬТАТЫ ИГРЫ:
                    Заработано: \(record.earnedMoney) ₽
                    Правильных ответов: \(record.correctAnswers)
                    Ответов: \(record.percentageCorrectAnswers) %
                    """
            cell.hintsLabel.text =
                    """
                    ПОДСКАЗКИ:
                    50/50: \(record.fiftyFifty)
                    Помощь зала: \(record.hallHelp)
                    Звонок другу: \(record.callFriend)
                    """
            
            cell.cellDelegate = self
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { record in
            defaults.removeObject(forKey: record)
        }
    }
    
    @IBAction func clearUserDefaults(_ sender: Any) {
        resetDefaults()
        self.tableView.reloadData()
        print(records)
    }
}

extension ResultsViewController: RecordTableViewCellDelegate {
    
    func didTapOnScoreLabel(scoreLabelText: String) {
        print(scoreLabelText)
    }
}

