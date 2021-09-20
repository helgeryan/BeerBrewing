//
//  Ingredients+CoreDataProperties.swift
//  AtHomeBrewing
//
//  Created by Ryan Helgeson on 9/17/21.
//
//

import Foundation
import CoreData


extension Ingredients {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredients> {
        return NSFetchRequest<Ingredients>(entityName: "Ingredients")
    }

    @NSManaged public var yeast: String?
    @NSManaged public var hops: NSSet?
    @NSManaged public var malts: NSSet?
    @NSManaged public var recipe: BeerRecipe?

}

// MARK: Generated accessors for hops
extension Ingredients {

    @objc(addHopsObject:)
    @NSManaged public func addToHops(_ value: Hops)

    @objc(removeHopsObject:)
    @NSManaged public func removeFromHops(_ value: Hops)

    @objc(addHops:)
    @NSManaged public func addToHops(_ values: NSSet)

    @objc(removeHops:)
    @NSManaged public func removeFromHops(_ values: NSSet)

}

// MARK: Generated accessors for malts
extension Ingredients {

    @objc(addMaltsObject:)
    @NSManaged public func addToMalts(_ value: Malt)

    @objc(removeMaltsObject:)
    @NSManaged public func removeFromMalts(_ value: Malt)

    @objc(addMalts:)
    @NSManaged public func addToMalts(_ values: NSSet)

    @objc(removeMalts:)
    @NSManaged public func removeFromMalts(_ values: NSSet)

}

extension Ingredients : Identifiable {

}
