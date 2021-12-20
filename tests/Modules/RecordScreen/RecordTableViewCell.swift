//
//  RecordTableViewCell.swift
//  tests
//
//  Created by Сергей Ляшенко on 16.12.2021.
//

import UIKit

protocol RecordTableViewCellDelegate: AnyObject {
    func didTapOnScoreLabel(scoreLabelText: String)
}

class RecordTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var currentQuestionNoLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var hintsLabel: UILabel!

    weak var cellDelegate: RecordTableViewCellDelegate?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        currentQuestionNoLabel.text = ""
        dataLabel.text = ""
        hintsLabel.text = ""
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnLabel))
        currentQuestionNoLabel.addGestureRecognizer(tapGesture)
        currentQuestionNoLabel.isUserInteractionEnabled = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension RecordTableViewCell {
    @objc func didTapOnLabel() {
        
        cellDelegate?.didTapOnScoreLabel(scoreLabelText: currentQuestionNoLabel.text ?? "")
    }
    
}
