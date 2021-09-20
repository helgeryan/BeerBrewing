//
//  Volume+CoreDataProperties.swift
//  AtHomeBrewing
//
//  Created by Ryan Helgeson on 9/17/21.
//
//

import Foundation
import CoreData


extension Volume {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Volume> {
        return NSFetchRequest<Volume>(entityName: "Volume")
    }

    @NSManaged public var units: String?
    @NSManaged public var value: Double
    @NSManaged public var recipe: BeerRecipe?

}

extension Volume : Identifiable {

}
