//
//  ExtAlert.swift
//  tests
//
//  Created by Сергей Ляшенко on 13.12.2021.
//

import UIKit

extension UIViewController {
    
    func alertWrongAnswer(withAlertTitle alertTitle: String, andMessage message: String, _ completion: ((UIAlertAction)->Void)? = nil) {
        
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        alert.view.tintColor = UIColor.orange
        let okAction = UIAlertAction(title: "OK", style: .default, handler: completion)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func alertExit(withAlertTitle alertTitle: String, andMessage message: String, _ completion: ((UIAlertAction)->Void)? = nil) {

        let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Да", style: .default, handler: completion)
        let cancelAction = UIAlertAction(title: "Нет", style: .cancel, handler: nil)
        
        alertController.view.tintColor = UIColor.orange
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
