//
//  HomeViewController.swift
//  AtHomeBrewing
//
//  HomeViewController is designed to allow user's the ability to search beer
//  recipes from the "https://api.punkapi.com/v2/" site. The results will be
//  displayed in a table view so the user can scroll through the search results
//  and navigate to the beer recipe of their liking.
//
//  Created by Ryan Helgeson on 8/5/21.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    // MARK: - Properties
    
    // Results array of the beer recipe query
    private var beerRecipeResults: [BeerRecipe] = []
    
    let context = CoreDataManager.shared.context
    
    // MARK: - UI Elements
    
    // Search bar used to search for beers
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search a beer brewing recipe"
        searchBar.showsCancelButton = true
        return searchBar
    }()
    
    // Label to identify to the user that there are no results
    private let noResultsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .boldSystemFont(ofSize: 28)
        label.text = "No Results!"
        label.textAlignment = .center
        label.isHidden = false
        return label
    }()
    
    // TableView to present the results of the beer recipe search
    private let resultsTableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.backgroundColor = .systemBackground
        tableView.separatorColor = .secondarySystemBackground
        tableView.register(BeerRecipeTableViewCell.self, forCellReuseIdentifier: BeerRecipeTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    // Override viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define backgroundColor to be the system background
        view.backgroundColor = .systemBackground
        
        // Setup searchBar
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        // Setup TableView
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        view.addSubview(resultsTableView)
        
        // Add No Results Label to view
        view.addSubview(noResultsLabel)
        
        fetchBeer()
    }
    
    // Override viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Define the resultsTableView frame 
        
        resultsTableView.frame = CGRect(x: 0,
                                        y: view.safeAreaInsets.top,
                                        width: view.bounds.width,
                                        height: view.bounds.height - view.safeAreaInsets.top)
        
        // Define the noResultsLabel frame
        noResultsLabel.frame = CGRect(x: 0,
                                        y: view.safeAreaInsets.top,
                                        width: view.bounds.width,
                                        height: view.bounds.height - view.safeAreaInsets.top)
    }
    
    func fetchBeer() {
        
        // Fetch the data from Core Data to display in the tableView
        do {
            let request = BeerRecipe.fetchRequest() as NSFetchRequest<BeerRecipe>
            
            // Set Filtering and Sorting

            self.beerRecipeResults = try context.fetch(request)
            
            DispatchQueue.main.async {
                self.resultsTableView.reloadData()
            }
        }
        catch {
            
        }
        
        // Update the UI on the Main thread
        DispatchQueue.main.async {
            // If there are results, show resultsTableView
            if self.beerRecipeResults.count != 0 {
                self.resultsTableView.reloadData()
                self.resultsTableView.isHidden = false
                self.noResultsLabel.isHidden = true
            }
            // Else there are no results, show noResultsLabel
            else {
                self.resultsTableView.reloadData()
                self.resultsTableView.isHidden = true
                self.noResultsLabel.isHidden = false
            }
        }
    }
    
}


// MARK: - UISearchBarDelegate Functions

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Resign the search bar as first responder
        searchBar.resignFirstResponder()
        
        // Remove all previous results
        for recipe in beerRecipeResults {
            self.context.delete(recipe)
        }
        
        // Check to make sure there is text available
        guard let searchText = searchBar.text else {
            print("No search text")
            return
        }
        
        // Retrieve search results and update UI
        retrieveResults(query: searchText)
    }
    
    // Delegate function called when cancel button is tapped
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Resign the search bar as first responder
        searchBar.resignFirstResponder()
    }
    
    // Determine whether or not to change text in the SearchBar
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        // If the text is a space, do not append text
        if text == " " {
            return false
        }
        
        return true
    }
    
    // Make a URL request with query and retrieve results from "https://api.punkapi.com/v2/".
    // Documentation on query results can be found at "https://punkapi.com/documentation/v2"
    // Update UI with the results
    private func retrieveResults(query: String) {
        
        // Define the API URL to query off the beername
        let punkApiUrl = "https://api.punkapi.com/v2/beers?beer_name="
        
        // Create a URL to with the query
        guard let url = URL(string: "\(punkApiUrl)\(query)") else {
            resultsTableView.isHidden = true
            noResultsLabel.isHidden = false
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
                self?.resultsTableView.isHidden = true
                self?.noResultsLabel.isHidden = false
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
                        
                        // Store data to a new beer recipe element
                        DispatchQueue.main.async {
                            let newBeerRecipe = BeerRecipe(context: self!.context)
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
                            
                            let volume = Volume(context: self!.context)
                            volume.value = volumeDict["value"] as? Double ?? 0
                            volume.units = volumeDict["units"] as? String ?? "liters"
                            newBeerRecipe.volume = volume
                            
                            let boilVolume = BoilVolume(context: self!.context)
                            boilVolume.value = boilVolumeDict["value"] as? Double ?? 0
                            boilVolume.units = boilVolumeDict["units"] as? String ?? "liters"
                            newBeerRecipe.boilVolume = boilVolume
                            
                            let ingredients = Ingredients(context: self!.context)
                            let method = BeerMethod(context: self!.context)
                            
                            for maltInfo in maltsDict {
                                let malt = Malt(context: self!.context)
                                malt.amount = 10
                                malt.units = "kilograms"
                                malt.name = maltInfo["name"] as? String ?? "Name"
                                ingredients.addToMalts(malt)
                            }
                            
                            for hop in hopsDict {
                                let hops = Hops(context: self!.context)
                                hops.amount = 20
                                hops.units = "grams"
                                hops.name = hop["name"] as? String ?? "Name"
                                hops.add = hop["add"] as? String ?? "Add"
                                hops.attribute = hop["attribute"] as? String ?? "Attribute"
                                ingredients.addToHops(hops)
                            }
                            
                            for mash in mashTempDict {
                                let mash_temp = MashTemp(context: self!.context)
                                mash_temp.duration = mash["duration"] as? Int64 ?? 0
                                mash_temp.units = "celsuis"
                                mash_temp.temperature = 60
                                method.addToMashTemp(mash_temp)
                            }
                            
                            let fermentation = Fermentation(context: self!.context)
                            fermentation.amount = fermDict["value"] as? Double ?? 0
                            fermentation.units = fermDict["units"] as? String ?? "celsius"
                            method.fermentation = fermentation
                            
                            ingredients.yeast = ingredientsDict["yeast"] as? String ?? "yeast"
                            newBeerRecipe.method = method
                            newBeerRecipe.ingredients = ingredients
                            newBeerRecipe.foodPairings = food_pairing
                            
                            do {
                                try self!.context.save()
                            }
                            catch {
                                
                            }
                            self?.fetchBeer()
                        }
                    }
                    else {
                        print("Failed")
                    }
                }
            }
            // Catch if the json data is not a dictionary
            catch {
                self?.resultsTableView.isHidden = true
                self?.noResultsLabel.isHidden = false
                print("Json data is not a dictionary")
            }
            
            self?.fetchBeer()
        }
        
        // Perform dataTask
        task.resume()
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource Functions

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    // Delegate function to determine the number of rows in a section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return number of Beer Recipes
        return beerRecipeResults.count
    }
    
    // Delegate function to define cell for row at index path
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue cell of type BeerRecipeTableViewCell
        let cell = resultsTableView.dequeueReusableCell(withIdentifier: BeerRecipeTableViewCell.identifier, for: indexPath) as! BeerRecipeTableViewCell
        
        // Configure the cell
        cell.configure(beerRecipe: beerRecipeResults[indexPath.row])
        
        // Return the cell
        return cell
    }
    
    // Delegate function to determine the height for a cell at index path
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Get the height of BeerRecipeTableViewCell and return
        return BeerRecipeTableViewCell.getHeight()
    }
    
    // Delegate function called when a row is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect the row to unhilight
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Get the data for the beer recipe at the tapped row
        let model = beerRecipeResults[indexPath.row]
        
        // Create the DetailViewController
        let vc = DetailViewController(beerRecipe: model)
        
        // Present the DetailViewController
        present(vc, animated: true, completion: nil)
    }
}
