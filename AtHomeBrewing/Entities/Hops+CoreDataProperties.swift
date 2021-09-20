//
//  Hops+CoreDataProperties.swift
//  AtHomeBrewing
//
//  Created by Ryan Helgeson on 9/17/21.
//
//

import Foundation
import CoreData


extension Hops {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hops> {
        return NSFetchRequest<Hops>(entityName: "Hops")
    }

    @NSManaged public var add: String?
    @NSManaged public var amount: Double
    @NSManaged public var attribute: String?
    @NSManaged public var name: String?
    @NSManaged public var units: String?
    @NSManaged public var ingredients: Ingredients?

}

extension Hops : Identifiable {

}
