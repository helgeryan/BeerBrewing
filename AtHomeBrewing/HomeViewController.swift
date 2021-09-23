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
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    // MARK: - Properties
    
    // Results array of the beer recipe query
    private var viewModel = SearchBeerViewModel()
    private var disposeBag = DisposeBag()
    
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
        tableView.isHidden = false
        tableView.backgroundColor = .systemBackground
        tableView.separatorColor = .secondarySystemBackground
        tableView.register(BeerRecipeTableViewCell.self, forCellReuseIdentifier: BeerRecipeTableViewCell.identifier)
        tableView.rowHeight = 240
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
        view.addSubview(resultsTableView)
        
        // Add No Results Label to view
//        view.addSubview(noResultsLabel)
        
        bindTableData()
        
//        fetchBeer()
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
    
    func bindTableData() {
        viewModel.items.bind(to: resultsTableView.rx.items(cellIdentifier: BeerRecipeTableViewCell.identifier, cellType: BeerRecipeTableViewCell.self)) { row, model, cell in
            cell.configure(beerRecipe: model)
        }.disposed(by: disposeBag)
    
        resultsTableView.rx.modelSelected(BeerRecipe.self).bind { beerRecipe in
            // Create the DetailViewController
            let vc = DetailViewController(beerRecipe: beerRecipe)
            
            // Present the DetailViewController
            self.present(vc, animated: true, completion: nil)
        }.disposed(by: disposeBag)
    }
}

// MARK: - UISearchBarDelegate Functions

extension HomeViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Resign the search bar as first responder
        searchBar.resignFirstResponder()

        
        // Remove all previous results
//        for recipe in beerRecipeResults {
//            self.context.delete(recipe)
//        }
        
        // Check to make sure there is text available
        guard let searchText = searchBar.text else {
            print("No search text")
            return
        }

        // Retrieve search results and update UI
        viewModel.retrieveResults(query: searchText)
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
}
