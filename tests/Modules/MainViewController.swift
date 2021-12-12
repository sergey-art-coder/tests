//
//  MainViewController.swift
//  tests
//
//  Created by Сергей Ляшенко on 11.12.2021.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {
    
    @IBOutlet weak var versionLabel: UILabel!
    
    let game = Game.shared
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        versionLabel.text = "ver. \(game.version)"
    }

}
