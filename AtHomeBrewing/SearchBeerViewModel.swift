//
//  SearchBeerViewModel.swift
//  AtHomeBrewing
//
//  Created by Ryan Helgeson on 9/22/21.
//

import Foundation
import CoreData
import RxCocoa
import RxSwift

class SearchBeerViewModel {
    
    var items = PublishSubject<[BeerRecipe]>()
    
    // Make a URL request with query and retrieve results from "https://api.punkapi.com/v2/".
    // Documentation on query results can be found at "https://punkapi.com/documentation/v2"
    // Update UI with the results
    func retrieveResults(query: String) {
    
        // Define the API URL to query off the beername
        let punkApiUrl = "https://api.punkapi.com/v2/beers?beer_name="
        
        let context = CoreDataManager.shared.context
        
        var results: [BeerRecipe] = []
        
        // Create a URL to with the query
        guard let url = URL(string: "\(punkApiUrl)\(query)") else {
            print("Bad URL")
            return
        }

        // Create the URLSession dataTask with the URL query
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            // Make sure no error
            guard error == nil else {
                return
            }
            
            // Check to make sure we get data
            guard let data = data else {
                print("Failed to get Data")
                return
            }
            
            // Attempt to parse the data as a dictionary
            do {
                // Parse as a dictionary
                let recipes = try JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
                
                // For each recipe get the data and parse data
                for recipe in recipes {
                    
                    // Check data is good
                    if let name = recipe["name"] as? String,
                          let imageUrlString = recipe["image_url"] as? String,
                          let tagline = recipe["tagline"] as? String,
                          let id = recipe["id"] as? Int,
                          let firstBrewed = recipe["first_brewed"] as? String,
                          let abv = recipe["abv"] as? Double,
                          let ibu = recipe["ibu"] as? Double,
                          let target_fg = recipe["target_fg"] as? Double,
                          let target_og = recipe["target_og"] as? Double,
                          let ebc = recipe["ebc"] as? Double,
                          let srm = recipe["srm"] as? Double,
                          let ph = recipe["ph"] as? Double,
                          let attenutation_level = recipe["attenuation_level"] as? Double,
                          let volumeDict = recipe["volume"] as? [String: Any],
                          let boilVolumeDict = recipe["boil_volume"] as? [String: Any],
                          let methodDict = recipe["method"] as? [String: Any],
                          let mashTempDict = methodDict["mash_temp"] as? [[String: Any]],
                          let fermDict = methodDict["fermentation"] as? [String: Any],
                          let ingredientsDict = recipe["ingredients"] as? [String: Any],
                          let maltsDict = ingredientsDict["malt"] as? [[String: Any]],
                          let hopsDict = ingredientsDict["hops"] as? [[String: Any]],
                          let food_pairing = recipe["food_pairing"] as? [String],
                          let brewers_tips = recipe["brewers_tips"] as? String,
                          let contributedBy = recipe["contributed_by"] as? String,
                          let imageUrl = URL(string: imageUrlString),
                          let description = recipe["description"] as? String {
                        
                        // Store data to a new beer recipe elemen
                        let newBeerRecipe = BeerRecipe(context: context)
                        newBeerRecipe.name = name
                        newBeerRecipe.id = Int64(id)
                        newBeerRecipe.firstBrewed = firstBrewed
                        newBeerRecipe.beerdescription = description
                        newBeerRecipe.imageUrlString = imageUrl.absoluteString
                        newBeerRecipe.contributedBy = contributedBy
                        newBeerRecipe.tagline = tagline
                        newBeerRecipe.abv = abv
                        newBeerRecipe.ibu = ibu
                        newBeerRecipe.target_fg = target_fg
                        newBeerRecipe.target_og = target_og
                        newBeerRecipe.ebc = ebc
                        newBeerRecipe.srm = srm
                        newBeerRecipe.ph = ph
                        newBeerRecipe.attenuationlevel = attenutation_level
                        newBeerRecipe.brewing_tips = brewers_tips
                        
                        let volume = Volume(context: context)
                        volume.value = volumeDict["value"] as? Double ?? 0
                        volume.units = volumeDict["units"] as? String ?? "liters"
                        newBeerRecipe.volume = volume
                        
                        let boilVolume = BoilVolume(context: context)
                        boilVolume.value = boilVolumeDict["value"] as? Double ?? 0
                        boilVolume.units = boilVolumeDict["units"] as? String ?? "liters"
                        newBeerRecipe.boilVolume = boilVolume
                        
                        let ingredients = Ingredients(context: context)
                        let method = BeerMethod(context: context)
                        
                        for maltInfo in maltsDict {
                            let malt = Malt(context: context)
                            malt.amount = 10
                            malt.units = "kilograms"
                            malt.name = maltInfo["name"] as? String ?? "Name"
                            ingredients.addToMalts(malt)
                        }
                        
                        for hop in hopsDict {
                            let hops = Hops(context: context)
                            hops.amount = 20
                            hops.units = "grams"
                            hops.name = hop["name"] as? String ?? "Name"
                            hops.add = hop["add"] as? String ?? "Add"
                            hops.attribute = hop["attribute"] as? String ?? "Attribute"
                            ingredients.addToHops(hops)
                        }
                        
                        for mash in mashTempDict {
                            let mash_temp = MashTemp(context: context)
                            mash_temp.duration = mash["duration"] as? Int64 ?? 0
                            mash_temp.units = "celsuis"
                            mash_temp.temperature = 60
                            method.addToMashTemp(mash_temp)
                        }
                        
                        let fermentation = Fermentation(context: context)
                        fermentation.amount = fermDict["value"] as? Double ?? 0
                        fermentation.units = fermDict["units"] as? String ?? "celsius"
                        method.fermentation = fermentation
                        
                        ingredients.yeast = ingredientsDict["yeast"] as? String ?? "yeast"
                        newBeerRecipe.method = method
                        newBeerRecipe.ingredients = ingredients
                        newBeerRecipe.foodPairings = food_pairing
                        
                        results.append(newBeerRecipe)
                    }
                    else {
                        print("Failed to parse Data")
                    }
                }
                
                self?.items.onNext(results)
            }
            // Catch if the json data is not a dictionary
            catch {
                print("Json data is not a dictionary")
            }
        }
        
        // Perform dataTask
        task.resume()
    }
}
