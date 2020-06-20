//
//  WordList.swift
//  MyDictionary
//
//  Created by Sujit Molleti on 6/17/20.
//  Copyright © 2020 Sujit Molleti. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class MyDictionary{
    
    private static var dictionary = MyDictionary()
    private var wordsList: [NSManagedObject] = []
    
    private init(){
        
    }
    
    static func getInstance() -> MyDictionary {
        return dictionary
    }
    
    func getWordsList() -> [NSManagedObject]{
        return wordsList
    }
    
    func saveWord(text: String){
        //1 Getting context of persistent container inside the app delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2 Links entity to NSManagedObject at runtime
        let entity = NSEntityDescription.entity(forEntityName: "ListWord", in: managedContext)!
        
        let word = NSManagedObject(entity: entity, insertInto: managedContext)
        
        //3 Inserting the item into the entity that we created in step 2
        word.setValue(text, forKey: "text")
        
        //4 Appending the new object, surround in do-catch bc managedContext.save throws an error
        do {
            try managedContext.save()
            wordsList.append(word)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func addDefinition(word: ListWord, defintions: [Definition]){
        
        for definition in defintions {
            let entry = DefinitionEntry()
            entry.definition = definition.definition
            entry.partOfSpeech = definition.partOfSpeech
            
            word.addToDefinitions(entry)
        }
            
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            try managedContext.save()
            wordsList.append(word)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func loadWordsList() {
        
        //1
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        //Why write it like this? How could the appdelegate ever be nil? Could we just force un-wrap?
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ListWord")
        
        //3
        do{
            wordsList = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
        
    }
    
    func removeWord(index: Int){
        let removedWord = self.wordsList[index]
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        

        //do {
        self.wordsList.remove(at: index)
        managedContext.delete(removedWord)
            
          //  try managedContext.save()
        //} catch let error as NSError {
        //    print("Could not save. \(error), \(error.userInfo)")
        //}
    }
    
}
