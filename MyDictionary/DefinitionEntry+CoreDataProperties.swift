//
//  DefinitionEntry+CoreDataProperties.swift
//  MyDictionary
//
//  Created by Sujit Molleti on 6/20/20.
//  Copyright © 2020 Sujit Molleti. All rights reserved.
//
//

import Foundation
import CoreData


extension DefinitionEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DefinitionEntry> {
        return NSFetchRequest<DefinitionEntry>(entityName: "DefinitionEntry")
    }

    @NSManaged public var definition: String
    @NSManaged public var partOfSpeech: String
    @NSManaged public var definedWord: ListWord?

}
