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
    
    var sorted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wordListTableView.dataSource = self
        wordListTableView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        wordListTableView.reloadData()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }
        
        
        if(sorted){
            //sort words
            MyDictionary.getInstance().sortWords()
            print("Sorted Words")
        } else{
            //shuffle words
            MyDictionary.getInstance().shuffleWords()
            print("Shuffled Words")
        }
        
        sorted = !sorted
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
        
///code for attributed string if I want to use it later
//        let text: String = word.value(forKeyPath: "text") as! String
//        let attributedString = NSMutableAttributedString(string: text)
//        let strRange = (text as NSString).range(of: text)
//        let fontSize = cell.textLabel?.font
//
//        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: T##CGFloat), range: T##NSRange)
        
        cell.textLabel?.text = word.value(forKeyPath: "text") as? String
        
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: cell.textLabel?.font.pointSize ?? 14)
        
        return cell
    }
    
    // deleting listWord item from memory and from list
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        MyDictionary.getInstance().removeWord(index: indexPath.row)
        wordListTableView.deleteRows(at: [indexPath], with: .fade)
        self.wordListTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    //seguing to definition screen
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let savedWord = MyDictionary.getInstance().getWordsList()[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "listToDefinition", sender: savedWord)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "listToDefinition"){
            let vc = segue.destination as! DefinitionViewController
            vc.cwordDefinition = sender as? ListWord
        }
    }
    
    
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .delete
//    }
    
    
}
