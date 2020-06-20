//
//  WordDefinitionCell.swift
//  MyDictionary
//
//  Created by Sujit Molleti on 6/16/20.
//  Copyright © 2020 Sujit Molleti. All rights reserved.
//

import UIKit

class WordDefinitionCell: UITableViewCell {
    
    let primaryColor = CGColor(srgbRed: 255/255, green: 90/255, blue: 95/255, alpha: 1.0)
    
    @IBOutlet weak var partOfSpeechLabel: UILabel!
    @IBOutlet weak var definitionLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    func setCell(definition: String, partOfSpeech: String){
        self.partOfSpeechLabel.text = partOfSpeech
        self.definitionLabel.text = definition
        
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cardView.layer.shadowOpacity = 0.5
        //shadowpath?
        cardView.layer.shadowRadius = 4
        cardView.clipsToBounds = true
        cardView.layer.cornerRadius = 15
        cardView.layer.masksToBounds = false
        

    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
