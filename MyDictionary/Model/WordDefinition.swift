//
//  WordDefinition.swift
//  MyDictionary
//
//  Created by Sujit Molleti on 6/17/20.
//  Copyright © 2020 Sujit Molleti. All rights reserved.
//

import Foundation

class WordDefinition{
    
    var word: Word
    var id: String
    var definitions: [Definition]?
    
    
   init(word: Word){
       self.word = word
       self.id = word.word!
   }
   
   func getDefinitions(lexicalEntries: [LexicalEntry]) -> [Definition]{
       
       var definitions: [Definition] = []

       for lexicalEntry in lexicalEntries{
        
            let partOfSpeech = lexicalEntry.lexicalCategory.text
            let definition = lexicalEntry.entries![0].senses![0].definitions?[0] ?? ""
            let temp = Definition(partOfSpeech: partOfSpeech, definition: definition)
        
            definitions.append(temp)
       }
       
       return definitions
   }
   
    
}
