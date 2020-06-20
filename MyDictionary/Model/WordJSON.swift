//
//  Word.swift
//  MyDictionary
//
//  Created by Sujit Molleti on 6/17/20.
//  Copyright © 2020 Sujit Molleti. All rights reserved.
//

import Foundation

struct Word: Codable{
    var word: String?
    var results: [Result]?
}

struct Result: Codable {
    var lexicalEntries: [LexicalEntry]?
}

struct LexicalEntry: Codable{
    var entries: [Entry]?
    var lexicalCategory: LexicalCategory
    
}

struct Entry: Codable{
    var senses: [Sense]?
}

struct LexicalCategory: Codable{
    var text: String
}

struct Sense: Codable{
    var definitions: [String]?
}



