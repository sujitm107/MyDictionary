//
//  DefinitionViewController.swift
//  MyDictionary
//
//  Created by Sujit Molleti on 6/16/20.
//  Copyright © 2020 Sujit Molleti. All rights reserved.
//

import UIKit
import CoreData

class DefinitionViewController: UIViewController {
    
    @IBOutlet weak var definitionTableView: UITableView!
    @IBOutlet weak var wordLabel: UILabel!
    var wordDefinition: WordDefinition?
    
    var cwordDefinition: ListWord?

    var definitions: [Definition]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if cwordDefinition != nil {
            let savedText = cwordDefinition?.text
            wordLabel.text = savedText
            let set = cwordDefinition?.definitions as! Set<DefinitionEntry>
            print(set.startIndex)
            
        } else {
            definitions = self.wordDefinition?.getDefinitions(lexicalEntries: wordDefinition!.word.results![0].lexicalEntries!)
            self.wordLabel.text = wordDefinition?.id
        }
        
        definitionTableView.delegate = self
        definitionTableView.dataSource = self
    }
    
}

extension DefinitionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return definitions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "definitionCell", for: indexPath) as! WordDefinitionCell
        
        //print(indexPath.row)
        let cellDefinition = (definitions![indexPath.row].definition)
        let cellPartOfSpeech = (definitions![indexPath.row].partOfSpeech)
        
        cell.setCell(definition: cellDefinition, partOfSpeech: cellPartOfSpeech)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
}
