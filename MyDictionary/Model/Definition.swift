//
//  Definition.swift
//  MyDictionary
//
//  Created by Sujit Molleti on 6/20/20.
//  Copyright © 2020 Sujit Molleti. All rights reserved.
//

import Foundation

class Definition {
    var partOfSpeech: String
    var definition: String
    
    init(partOfSpeech: String, definition: String){
        self.partOfSpeech = partOfSpeech
        self.definition = definition
    }
}
