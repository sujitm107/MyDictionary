//
//  WordListViewController.swift
//  MyDictionary
//
//  Created by Sujit Molleti on 6/17/20.
//  Copyright © 2020 Sujit Molleti. All rights reserved.
//

import UIKit
import CoreData

class WordListViewController: UIViewController {

    @IBOutlet weak var wordListTableView: UITableView!
    
    let wordList: [String] = ["Apples", "Bannanas", "Cars"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wordListTableView.dataSource = self
        wordListTableView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        wordListTableView.reloadData()
    }
    
}

extension WordListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyDictionary.getInstance().getWordsList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath)

        let word = MyDictionary.getInstance().getWordsList()[indexPath.row]
        
        cell.textLabel?.text = word.value(forKeyPath: "text") as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        MyDictionary.getInstance().removeWord(index: indexPath.row)
        wordListTableView.deleteRows(at: [indexPath], with: .fade)
        self.wordListTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "listToDefinition"){
            let vc = segue.destination as! DefinitionViewController
            vc.cwordDefinition = sender as? ListWord
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let savedWord = MyDictionary.getInstance().getWordsList()[indexPath.row]
        performSegue(withIdentifier: "listToDefinition", sender: savedWord)
    }
    
    
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .delete
//    }
    
    
}
