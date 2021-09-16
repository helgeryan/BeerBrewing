//
//  BeerRecipe.swift
//  AtHomeBrewing
//
//  BeerRecipe.swift defines a struct containing all data for a beer recipe. In addition
//  to defining the BeerRecipe, MeasurementValue, Method, MashTemp, Fermentation, Ingredients
//  Malt, Hops are defined.
//
//  Created by Ryan Helgeson on 8/9/21.
//

import Foundation

// Struct containing all information of a beer recipe
struct BeerRecipe {
    // Properties
    var id: Int
    var name: String
    var tagline: String
    var firstBrewed: String
    var abv: Double
    var imageUrl: URL
    var description: String
    var contributedBy: String
    var ibu: Double
    var target_fg: Double
    var target_og: Double
    var ebc: Double
    var srm: Double
    var ph: Double
    var attenuation_level: Double
    var volume: MeasurementValue
    var boilVolume: MeasurementValue
    var method: Method
    var ingredients: Ingredients
    var foodPairing: [String]
    var brewers_Tips: String
    
    // Generic initializer
    init() {
        id = -1
        name = ""
        tagline = ""
        firstBrewed = ""
        abv = 0
        imageUrl = URL(string: "google.com")!
        description = ""
        contributedBy = ""
        ibu = 0
        target_fg = 0
        target_og = 0
        ebc = 0
        srm = 0
        ph = 0
        attenuation_level = 0
        volume = MeasurementValue()
        volume.units = "litres"
        boilVolume = MeasurementValue()
        boilVolume.units = "litres"
        method = Method()
        ingredients = Ingredients()
        foodPairing = []
        brewers_Tips = ""
    }
    
    // Create contributer username from contributedBy string
    var contributedUsername: String {
        let splitString = contributedBy.split(separator: "<")
        var username = String(splitString[1])
        username = username.replacingOccurrences(of: ">", with: "")
        return String(username)
    }
    
    // Create contributer name from contributedBy string
    var contributedName: String {
        let splitString = contributedBy.split(separator: "<")
        return String(splitString[0])
    }
}

// Struct containing all information of a measurement value
struct MeasurementValue {
    // Properties
    var value: Double
    var units: String
    
    // Generic initializer
    init() {
        value = 0
        units = "N/A"
    }
    
    // Initialize struct with data
    init(dict: [String: Any]) {
        // Parse value data
        value = dict["value"] as? Double ?? 0
        
        // Parse units data
        units = dict["unit"] as? String ?? "N/A"
    }
}

// Struct containing all information of a method
struct Method {
    // Properties
    var mashTemp: [MashTemp]
    var fermentation: Fermentation
    
    // Generic initializer
    init() {
        mashTemp = []
        fermentation = Fermentation()
    }
    
    // Initialize struct with data
    init(dict: [String: Any]) {
        self.init()
        
        // Parse mash_temp data
        if let mash_temp = dict["mash_temp"] as? [[String: Any]] {
            for index in mash_temp {
                let newElement = MashTemp(dict: index)
                mashTemp.append(newElement)
            }
        }
        
        // Parse fermentation data
        if let fermentationDict = dict["fermentation"] as? [String: Any] {
            fermentation = Fermentation(dict: fermentationDict)
        }
    }
}

// Struct containing all information of mash temp
struct MashTemp {
    // Properties
    var temp: MeasurementValue
    var duration: Int
    
    // Generic initializer
    init() {
        temp = MeasurementValue()
        temp.units = "celsius"
        duration = 0
    }
    
    // Initialize struct with data
    init(dict: [String: Any]) {
        self.init()
        
        // Parse temp data
        if let tempDict = dict["temp"] as? [String: Any] {
            temp = MeasurementValue(dict: tempDict)
        }
        
        // Parse duration data
        duration = dict["duration"] as? Int ?? 0
    }
}

// Struct containing all information of a fermentation
struct Fermentation {
    // Properties
    var temp: MeasurementValue
    
    // Generic initializer
    init() {
        temp = MeasurementValue()
        temp.units = "celsius"
    }
    
    // Initialize struct with data
    init(dict: [String: Any]) {
        self.init()
        
        // Parse temp data
        if let tempDict = dict["temp"] as? [String: Any] {
            temp = MeasurementValue(dict: tempDict)
        }
    }
}

// Struct containing all information of an ingredients
struct Ingredients {
    // Properties
    var malts: [Malt]
    var hops: [Hops]
    var yeast: String
    
    // Generic initializer
    init() {
        malts = []
        hops = []
        yeast = "N/A"
    }
    
    // Initialize struct with data
    init(dict: [String: Any]) {
        self.init()
        
        // Parse malt data
        if let maltsDict = dict["malt"] as? [[String: Any]] {
            for index in maltsDict {
                let newElement = Malt(dict: index)
                malts.append(newElement)
            }
        }
        
        // Parse hops data
        if let hopsDict = dict["hops"] as? [[String: Any]] {
            for index in hopsDict {
                let newElement = Hops(dict: index)
                hops.append(newElement)
            }
        }
        
        // Parse yeast data
        yeast = dict["yeast"] as? String ?? "N/A"
    }
}

// Struct containing all information of a malt
struct Malt {
    // Properties
    var amount: MeasurementValue
    var name: String
    
    // Generic initializer
    init() {
        amount = MeasurementValue()
        amount.units = "kilograms"
        name = ""
    }
    
    // Initialize struct with data
    init(dict: [String: Any]) {
        self.init()
        
        // Parse amount data
        if let amountDict = dict["amount"] as? [String: Any] {
            amount = MeasurementValue(dict: amountDict)
        }
        
        // Parse name data
        name = dict["name"] as? String ?? ""
    }
}

// Struct containing all information of a Hops
struct Hops {
    // Properties
    var amount: MeasurementValue
    var name: String
    var attribute: String
    var add: String
    
    // Generic initializer
    init() {
        amount = MeasurementValue()
        amount.units = "grams"
        name = ""
        attribute = ""
        add = ""
    }
    
    // Initialize struct with data
    init(dict: [String: Any]) {
        self.init()
        
        // Parse amount data
        if let amountDict = dict["amount"] as? [String: Any] {
            amount = MeasurementValue(dict: amountDict)
        }
        
        // Parse name data
        name = dict["name"] as? String ?? ""
        
        // Parse attribute data
        attribute = dict["attribute"] as? String ?? ""
        
        // Parse add data
        add = dict["add"] as? String ?? ""
    }
}
