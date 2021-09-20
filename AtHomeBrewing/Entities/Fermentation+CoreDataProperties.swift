//
//  Fermentation+CoreDataProperties.swift
//  AtHomeBrewing
//
//  Created by Ryan Helgeson on 9/17/21.
//
//

import Foundation
import CoreData


extension Fermentation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Fermentation> {
        return NSFetchRequest<Fermentation>(entityName: "Fermentation")
    }

    @NSManaged public var amount: Double
    @NSManaged public var units: String?
    @NSManaged public var method: BeerMethod?

}

extension Fermentation : Identifiable {

}
