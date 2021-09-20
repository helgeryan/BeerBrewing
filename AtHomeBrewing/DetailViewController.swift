//
//  DetailViewController.swift
//  AtHomeBrewing
//
//  DetailViewController is used to provide users with a page describing all relevant
//  beer recipe information. The DetailViewController will be initialized with a beer
//  recipe and then be presented throughout the app. 
//
//  Created by Ryan Helgeson on 8/9/21.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    // Beer recipe presented
    private let beerRecipe: BeerRecipe
    
    // MARK: - UI Elements
    
    let detailView: DetailView?
    
    // MARK: - LifeCycle
    
    // Override viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the background as the system's background
        view.backgroundColor = .systemBackground
        
        view.addSubview(detailView!)
    }
    
    // Initializer to set beer recipe for the ViewController
    init(beerRecipe: BeerRecipe) {
        self.beerRecipe = beerRecipe
        self.detailView = DetailView(beerRecipe: beerRecipe)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Override viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        detailView?.frame = view.bounds
    }
}
