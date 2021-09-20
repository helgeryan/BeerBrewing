//
//  BeerRecipe+CoreDataProperties.swift
//  
//
//  Created by Ryan Helgeson on 9/17/21.
//
//

import Foundation
import CoreData


extension BeerRecipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BeerRecipe> {
        return NSFetchRequest<BeerRecipe>(entityName: "BeerRecipe")
    }

    @NSManaged public var abv: Double
    @NSManaged public var attenuationlevel: Double
    @NSManaged public var beerdescription: String?
    @NSManaged public var brewing_tips: String?
    @NSManaged public var contributedBy: String?
    @NSManaged public var ebc: Double
    @NSManaged public var firstBrewed: String?
    @NSManaged public var ibu: Double
    @NSManaged public var id: Int64
    @NSManaged public var imageUrlString: String?
    @NSManaged public var name: String?
    @NSManaged public var ph: Double
    @NSManaged public var srm: Double
    @NSManaged public var tagline: String?
    @NSManaged public var target_fg: Double
    @NSManaged public var target_og: Double
    @NSManaged public var foodPairings: [String]?
    @NSManaged public var boilVolume: BoilVolume?
    @NSManaged public var ingredients: Ingredients?
    @NSManaged public var method: BeerMethod?
    @NSManaged public var volume: Volume?

}
