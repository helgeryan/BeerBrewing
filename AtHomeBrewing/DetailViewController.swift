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
    
    // UIImageView to display the beer image
    private let beerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white // Must be white to make all beer images visible
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    // UILabel to display the beer name
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    // UILabel to display the contributedBy name
    private let contributedByLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .bold)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    // UILabel to display the date first brewed
    private let firstBrewedDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .bold)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    // UILabel to display the abv
    private let abvLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .bold)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    // UILabel to display the ibu
    private let ibuLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .bold)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    // UILabel to display the ebc
    private let ebcLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .bold)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    // UILabel to display the srm
    private let srmLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .bold)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    // UILabel to display the target_og
    private let targetOgLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .bold)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    // UILabel to display the target_fg
    private let targetFgLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .bold)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    // UILabel to display the ph
    private let phLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .bold)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    // UILabel to display the ph
    private let attenuationLevelLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .bold)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    // UILabel to display the desciption
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        return label
    }()
    
    // UILabel to display the ingredients
    private let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.font = .italicSystemFont(ofSize: 14)
        return label
    }()
    
    // UILabel to display the method
    private let methodLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    // UIScrollView that contains UI elements
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    // MARK: - LifeCycle
    
    // Override viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the background as the system's background
        view.backgroundColor = .systemBackground
        
        // Add scrollView to the view
        view.addSubview(scrollView)
        
        // Add UI elements to scrollView
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(contributedByLabel)
        scrollView.addSubview(firstBrewedDateLabel)
        scrollView.addSubview(abvLabel)
        scrollView.addSubview(ibuLabel)
        scrollView.addSubview(ebcLabel)
        scrollView.addSubview(srmLabel)
        scrollView.addSubview(targetOgLabel)
        scrollView.addSubview(targetFgLabel)
        scrollView.addSubview(phLabel)
        scrollView.addSubview(attenuationLevelLabel)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(ingredientsLabel)
        scrollView.addSubview(methodLabel)
        scrollView.addSubview(beerImageView)
        
        // Update beer information labels
        nameLabel.text = beerRecipe.name
        contributedByLabel.text = beerRecipe.contributedName
        firstBrewedDateLabel.text = "First Brewed: \(beerRecipe.firstBrewed)"
        abvLabel.text = "ABV: \(beerRecipe.abv)%"
        ibuLabel.text = "IBU: \(beerRecipe.ibu)"
        ebcLabel.text = "EBC: \(beerRecipe.ebc)"
        srmLabel.text = "SRM: \(beerRecipe.srm)"
        targetOgLabel.text = "Target OG: \(beerRecipe.target_og)"
        targetFgLabel.text = "Target FG: \(beerRecipe.target_fg)"
        phLabel.text = "pH: \(beerRecipe.ph)"
        attenuationLevelLabel.text = "Att. Level: \(beerRecipe.attenuation_level)"
        descriptionLabel.text = "\(beerRecipe.tagline)\n\n\(beerRecipe.description)"
        beerImageView.sd_setImage(with: beerRecipe.imageUrl, completed: nil)
        
        // Create ingredient label information
        createIngredientLabel()
        
        createMethodLabel()
    }
    
    // Initializer to set beer recipe for the ViewController
    init(beerRecipe: BeerRecipe) {
        self.beerRecipe = beerRecipe
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Override viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Define scrollView frame
        scrollView.frame = view.bounds
        
        // Define padding for UI elements
        let padding: CGFloat = 8
        
        // Define nameLabel frame
        nameLabel.frame = CGRect(x: padding,
                                 y: view.safeAreaInsets.top + padding,
                                 width: view.width - (padding * 2),
                                 height: 30)
        
        // Define descriptionLabel frame
        descriptionLabel.frame = CGRect(x: padding,
                                        y: nameLabel.bottom + (padding * 2),
                                        width: view.width - (padding * 2),
                                        height: view.height - nameLabel.bottom -  (padding * 2))
        // Adjust height to fit label text
        descriptionLabel.sizeToFit()
        
        // Define contributedByLabel frame
        contributedByLabel.frame = CGRect(x: padding,
                                        y: descriptionLabel.bottom + (padding * 2),
                                        width: (view.width * 2 / 3) - (padding * 2),
                                        height: 20)
        
        // Define firstBrewedDateLabel frame
        firstBrewedDateLabel.frame = CGRect(x: padding,
                                          y: contributedByLabel.bottom + padding,
                                          width: (view.width * 2 / 3) - (padding * 2),
                                          height: 20)
        
        // Define abvLabel frame
        abvLabel.frame = CGRect(x: padding,
                                          y: firstBrewedDateLabel.bottom + padding,
                                          width: (view.width * 2 / 3) - (padding * 2),
                                          height: 20)
        
        // Define ibuLabel frame
        ibuLabel.frame = CGRect(x: padding,
                                          y: abvLabel.bottom + padding,
                                          width: (view.width * 2 / 3) - (padding * 2),
                                          height: 20)
        
        // Define ebcLabel frame
        ebcLabel.frame = CGRect(x: padding,
                                          y: ibuLabel.bottom + padding,
                                          width: (view.width * 2 / 3) - (padding * 2),
                                          height: 20)
        
        // Define srmLabel frame
        srmLabel.frame = CGRect(x: padding,
                                          y: ebcLabel.bottom + padding,
                                          width: (view.width * 2 / 3) - (padding * 2),
                                          height: 20)
        
        // Define targetOfLabel frame
        targetOgLabel.frame = CGRect(x: padding,
                                          y: srmLabel.bottom + padding,
                                          width: (view.width * 2 / 3) - (padding * 2),
                                          height: 20)
        
        // Define targetFgLabel frame
        targetFgLabel.frame = CGRect(x: padding,
                                          y: targetOgLabel.bottom + padding,
                                          width: (view.width * 2 / 3) - (padding * 2),
                                          height: 20)
        
        // Define phLabel frame
        phLabel.frame = CGRect(x: padding,
                                          y: targetFgLabel.bottom + padding,
                                          width: (view.width * 2 / 3) - (padding * 2),
                                          height: 20)
        
        // Define attenuationLevelLabel frame
        attenuationLevelLabel.frame = CGRect(x: padding,
                                          y: phLabel.bottom + padding,
                                          width: (view.width * 2 / 3) - (padding * 2),
                                          height: 20)
        
        // Define beerImageView frame
        beerImageView.frame = CGRect(x: (view.width * 2 / 3) + padding,
                                     y: descriptionLabel.bottom + (padding * 2),
                                     width: (view.width / 3.0) - (padding * 2),
                                     height: attenuationLevelLabel.bottom - contributedByLabel.top)
        
        // Define ingredients frame
        ingredientsLabel.frame = CGRect(x: padding,
                                        y: beerImageView.bottom + (padding * 3),
                                        width: view.width - (padding * 2),
                                        height: 0)
        // Adjust height to fit label text
        ingredientsLabel.sizeToFit()
        
        // Define methodLabel frame
        methodLabel.frame = CGRect(x: padding,
                                        y: ingredientsLabel.bottom + (padding * 2),
                                        width: view.width - (padding * 2),
                                        height: 0)
        // Adjust height to fit label text
        methodLabel.sizeToFit()
        
        scrollView.contentSize = CGSize(width: view.width, height: methodLabel.bottom + (padding * 2))
    }
    
    // MARK: - Label Functions
    
    // Method to create all information of the ingredientLabel text
    private func createIngredientLabel() {
        // Create ingredients header
        var ingredientsString = "--Ingredients--\n"
        
        // Append malt ingredients
        ingredientsString.append("Malt:\n")
        for malt in beerRecipe.ingredients.malts {
            ingredientsString.append("-\(malt.name), \(malt.amount.value) \(malt.amount.units)\n")
        }
        
        // Append hops ingredients
        ingredientsString.append("\nHops:\n")
        for hop in beerRecipe.ingredients.hops {
            ingredientsString.append("-\(hop.name), \(hop.attribute), \(hop.add), \(hop.amount.value) \(hop.amount.units)\n")
        }
        
        // Append yeast used
        ingredientsString.append("\nYeast: \(beerRecipe.ingredients.yeast)\n")
        
        // Append food pairings
        ingredientsString.append("\nFood Pairings:\n")
        for (index, pairing) in beerRecipe.foodPairing.enumerated() {
            ingredientsString.append("\(index + 1). \(pairing)\n")
        }
        
        // Assign ingredientsString to ingredientsLabel text
        ingredientsLabel.text = ingredientsString
    }
    
    // Method to create all information of the methodLabel text
    private func createMethodLabel() {
        // Create Method header
        var methodString = "--Method--\n"
        
        // Append volume
        methodString.append("Volume:\n")
        methodString.append("\(beerRecipe.volume.value) \(beerRecipe.volume.units)\n")
        
        // Append boiling volume
        methodString.append("\nBoiling Volume:\n")
        methodString.append("\(beerRecipe.boilVolume.value) \(beerRecipe.boilVolume.units)\n")
        
        // Append mashing instructions
        methodString.append("\nMashing:\n")
        for (index, mashTemp) in beerRecipe.method.mashTemp.enumerated() {
            if mashTemp.duration != 0 {
                methodString.append("\(index + 1). \(mashTemp.temp.value) degrees \(mashTemp.temp.units) for \(mashTemp.duration)min\n")
            }
            else {
                methodString.append("\(index + 1). \(mashTemp.temp.value) degrees \(mashTemp.temp.units)\n")
            }
        }
        
        // Append fermentation instructions
        methodString.append("\nFermentation:\n")
        methodString.append("\(beerRecipe.method.fermentation.temp.value) degrees \(beerRecipe.method.fermentation.temp.units)")
        
        // Append brewing tips
        methodString.append("\n\nBrewing Tips: \(beerRecipe.brewers_Tips)")
        
        // Assign methodString to methodLabel text
        methodLabel.text = methodString
    }
}
