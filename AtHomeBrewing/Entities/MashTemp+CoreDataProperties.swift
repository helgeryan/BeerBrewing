//
//  MashTemp+CoreDataProperties.swift
//  AtHomeBrewing
//
//  Created by Ryan Helgeson on 9/17/21.
//
//

import Foundation
import CoreData


extension MashTemp {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MashTemp> {
        return NSFetchRequest<MashTemp>(entityName: "MashTemp")
    }

    @NSManaged public var duration: Int64
    @NSManaged public var temperature: Double
    @NSManaged public var units: String?
    @NSManaged public var method: BeerMethod?

}

extension MashTemp : Identifiable {

}
