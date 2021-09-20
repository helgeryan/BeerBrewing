//
//  Malt+CoreDataProperties.swift
//  AtHomeBrewing
//
//  Created by Ryan Helgeson on 9/17/21.
//
//

import Foundation
import CoreData


extension Malt {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Malt> {
        return NSFetchRequest<Malt>(entityName: "Malt")
    }

    @NSManaged public var amount: Double
    @NSManaged public var name: String?
    @NSManaged public var units: String?
    @NSManaged public var ingredients: Ingredients?

}

extension Malt : Identifiable {

}
