//
//  BoilVolume+CoreDataProperties.swift
//  AtHomeBrewing
//
//  Created by Ryan Helgeson on 9/17/21.
//
//

import Foundation
import CoreData


extension BoilVolume {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BoilVolume> {
        return NSFetchRequest<BoilVolume>(entityName: "BoilVolume")
    }

    @NSManaged public var units: String?
    @NSManaged public var value: Double
    @NSManaged public var recipe: BeerRecipe?

}

extension BoilVolume : Identifiable {

}
