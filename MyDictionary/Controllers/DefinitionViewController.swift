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
    @IBOutlet weak var addButton: UIButton!
    
    var wordDefinition: WordDefinition?
    var cwordDefinition: ListWord?

    var definitions: [Definition]?
    var set: [DefinitionEntry]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton.tintColor = ColorViewController.theme
        
        if cwordDefinition != nil { //getting word from network request
            let savedText = cwordDefinition?.text
            wordLabel.text = savedText
            set = cwordDefinition?.definitions?.allObjects as! [DefinitionEntry]
            
            let definitionSet = convertToDefinitionSet(set: set!)
            definitions = definitionSet
            
            
        } else { //getting word from core data
            definitions = self.wordDefinition?.getDefinitions(lexicalEntries: wordDefinition!.word.results![0].lexicalEntries!)
            MyDictionary.getInstance().addDefinition(word: wordDefinition!.id, defintions: definitions!)
            self.wordLabel.text = wordDefinition?.id
        }
        
        definitionTableView.delegate = self
        definitionTableView.dataSource = self
    }
    
    func convertToDefinitionSet(set: [DefinitionEntry]) -> [Definition]{
        
        var definitionSet: [Definition] = []
        
        for entry in set {
            let partOfSpeech = entry.partOfSpeech
            let definition = entry.definition
            
            let temp = Definition(partOfSpeech: partOfSpeech!, definition: definition!)
            
            definitionSet.append(temp)
        }
        
        return definitionSet
        
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "New Note", message: "Enter a note.", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter a note..."
        }
        
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (UIAlertAction) in
            
            //have to make this dummy proof
            let temp = Definition(partOfSpeech: "MyNote", definition: alert.textFields![0].text!)
            self.definitions?.append(temp) //we're adding it here, however, when we form the cells later, we are not using this to retrieve

            let wordstr: String = (self.wordDefinition?.id != nil) ? self.wordDefinition!.id : self.cwordDefinition!.text!
            MyDictionary.getInstance().addDefinition(word: wordstr, defintions: [temp]) //saving data
            
            self.definitionTableView.reloadData()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
            print("Cancel")
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}

extension DefinitionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return definitions?.count ?? 10
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
    
    // deleting definition item from memory and from list
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if cwordDefinition == nil { return }
        
        MyDictionary.getInstance().removeDefinition(string: self.wordLabel!.text!, definition: set![indexPath.row])
        definitions?.remove(at: indexPath.row)
        definitionTableView.deleteRows(at: [indexPath], with: .fade)
        self.definitionTableView.reloadData()
    }
    
}
