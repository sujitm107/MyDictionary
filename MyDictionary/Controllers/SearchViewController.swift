 //
//  SearchViewController.swift
//  MyDictionary
//
//  Created by Sujit Molleti on 6/11/20.
//  Copyright © 2020 Sujit Molleti. All rights reserved.
//

import UIKit
 
 protocol ColorChanger {
    func changeColors(color: UIColor)
 }

 class SearchViewController: UIViewController, ColorChanger {
    
    let primaryColor = CGColor(srgbRed: 255/255, green: 90/255, blue: 95/255, alpha: 1.0)
    let secondaryColor = CGColor(srgbRed: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    
    
    @IBOutlet weak var colorGear: UIButton!
    @IBOutlet weak var wordSearchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MyDictionary.getInstance().loadWordsList()
        
        wordSearchBar.layer.borderColor = primaryColor
        wordSearchBar.layer.borderWidth = 1.0
        wordSearchBar.layer.cornerRadius = 20
        
        wordSearchBar.delegate = self
        
        //hideKeyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "searchToDefinition"){
            if let wordDef = sender as? WordDefinition {
                let vc = segue.destination as! DefinitionViewController
                vc.wordDefinition = wordDef
            }
        }
        
        if(segue.identifier == "searchToColor"){
            let vc = segue.destination as! ColorViewController
            vc.colorChangerDelegate = self
        }
        
    }
    
    @IBAction func gearButtonTapped(_ sender: Any) {
        
        performSegue(withIdentifier: "searchToColor", sender: nil)
    }
    
    func changeColors(color: UIColor) {
        
        //cGColor --> UIcolor cGColor(UIColor: color) -- constructor
        //UIColor --> CGColor UIColor.cgColor -- attribute
        
        colorGear.tintColor = color
        wordSearchBar.layer.borderColor = color.cgColor
    }
    
}
 
 extension SearchViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        //make networking request
        fetchWord { (Word) in
            DispatchQueue.main.async {
                
                //save data
                MyDictionary.getInstance().saveWord(text: searchBar.text!)
                
                //perform segue
                let wordTemp = WordDefinition(word: Word)
                self.performSegue(withIdentifier: "searchToDefinition", sender: wordTemp)
            }
            
        }
        
        
    }
    
    func fetchWord(completion: @escaping (Word) -> ()){
        
        guard let searchWord = wordSearchBar.text?.lowercased() else { return }
        
        let urlString = "https://od-api.oxforddictionaries.com:443/api/v2/entries/en-us/\(searchWord)?strictMatch=false"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        
        request.addValue("5886c1ac", forHTTPHeaderField: "app_id")
        request.addValue("6398510576687de8b0a444904d422f20", forHTTPHeaderField: "app_key")
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            if data != nil && error == nil {
                
                let decoder = JSONDecoder()
                
                do {
                    let word = try decoder.decode(Word.self, from: data!)
                    completion(word)
                } catch {
                    print("error")
                }
                
            } else {
                print(error!)
            }
        }.resume()
        
    }
    
 }
 

