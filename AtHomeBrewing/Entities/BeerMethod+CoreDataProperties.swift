//
//  BeerMethod+CoreDataProperties.swift
//  AtHomeBrewing
//
//  Created by Ryan Helgeson on 9/17/21.
//
//

import Foundation
import CoreData


extension BeerMethod {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BeerMethod> {
        return NSFetchRequest<BeerMethod>(entityName: "BeerMethod")
    }

    @NSManaged public var fermentation: Fermentation?
    @NSManaged public var mashTemp: NSSet?
    @NSManaged public var recipe: BeerRecipe?

}

// MARK: Generated accessors for mashTemp
extension BeerMethod {

    @objc(addMashTempObject:)
    @NSManaged public func addToMashTemp(_ value: MashTemp)

    @objc(removeMashTempObject:)
    @NSManaged public func removeFromMashTemp(_ value: MashTemp)

    @objc(addMashTemp:)
    @NSManaged public func addToMashTemp(_ values: NSSet)

    @objc(removeMashTemp:)
    @NSManaged public func removeFromMashTemp(_ values: NSSet)

}

extension BeerMethod : Identifiable {

}
