//
//  ListWord+CoreDataProperties.swift
//  MyDictionary
//
//  Created by Sujit Molleti on 6/20/20.
//  Copyright © 2020 Sujit Molleti. All rights reserved.
//
//

import Foundation
import CoreData


extension ListWord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListWord> {
        return NSFetchRequest<ListWord>(entityName: "ListWord")
    }

    @NSManaged public var text: String
    @NSManaged public var definitionEntries: NSObject
    @NSManaged public var definitions: NSSet

}

// MARK: Generated accessors for definitions
extension ListWord {

    @objc(addDefinitionsObject:)
    @NSManaged public func addToDefinitions(_ value: DefinitionEntry)

    @objc(removeDefinitionsObject:)
    @NSManaged public func removeFromDefinitions(_ value: DefinitionEntry)

    @objc(addDefinitions:)
    @NSManaged public func addToDefinitions(_ values: NSSet)

    @objc(removeDefinitions:)
    @NSManaged public func removeFromDefinitions(_ values: NSSet)

}
