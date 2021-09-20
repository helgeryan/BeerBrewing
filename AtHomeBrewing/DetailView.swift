//
//  DetailView.swift
//  AtHomeBrewing
//
//  Created by Ryan Helgeson on 9/17/21.
//

import UIKit

class DetailView: UIView {

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
    private let contributedByLabel: UILabel =  makeBoldLabel()
    
    // UILabel to display the date first brewed
    private let firstBrewedDateLabel: UILabel =  makeBoldLabel()
    
    // UILabel to display the abv
    private let abvLabel: UILabel =  makeBoldLabel()
    
    // UILabel to display the ibu
    private let ibuLabel: UILabel =  makeBoldLabel()
    
    // UILabel to display the ebc
    private let ebcLabel: UILabel =  makeBoldLabel()
    
    // UILabel to display the srm
    private let srmLabel: UILabel =  makeBoldLabel()
    
    // UILabel to display the target_og
    private let targetOgLabel: UILabel =  makeBoldLabel()
    
    // UILabel to display the target_fg
    private let targetFgLabel: UILabel = makeBoldLabel()
    
    // UILabel to display the ph
    private let phLabel: UILabel = makeBoldLabel()
    
    // UILabel to display the ph
    private let attenuationLevelLabel: UILabel = makeBoldLabel()
    
    // UILabel to display the desciption
    private let descriptionLabel: UILabel = makeDetailLabel()
    
    // UILabel to display the ingredients
    private let ingredientsLabel: UILabel = makeDetailLabel()
    
    // UILabel to display the method
    private let methodLabel: UILabel = makeDetailLabel()
    
    // UIScrollView that contains UI elements
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    init(beerRecipe: BeerRecipe) {
        super.init(frame: .zero)
        
        // Add scrollView to the view
        addSubview(scrollView)
        
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
        contributedByLabel.text = beerRecipe.contributedBy
        firstBrewedDateLabel.text = "First Brewed: \(beerRecipe.firstBrewed ?? "")"
        abvLabel.text = "ABV: \(beerRecipe.abv)%"
        ibuLabel.text = "IBU: \(beerRecipe.ibu)"
        ebcLabel.text = "EBC: \(beerRecipe.ebc)"
        srmLabel.text = "SRM: \(beerRecipe.srm)"
        targetOgLabel.text = "Target OG: \(beerRecipe.target_og)"
        targetFgLabel.text = "Target FG: \(beerRecipe.target_fg)"
        phLabel.text = "pH: \(beerRecipe.ph)"
        attenuationLevelLabel.text = "Att. Level: \(beerRecipe.attenuationlevel)"
        descriptionLabel.text = "\(beerRecipe.tagline ?? "")\n\n\(beerRecipe.beerdescription ?? "")"
        
        guard let url = URL(string: beerRecipe.imageUrlString ?? "") else {
            return
        }
        beerImageView.sd_setImage(with: url, completed: nil)
        
        // Create ingredient label information
        createIngredientLabel(beerRecipe: beerRecipe)
        
        createMethodLabel(beerRecipe: beerRecipe)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        // Define scrollView frame
        scrollView.frame = bounds
        
        // Define padding for UI elements
        let padding: CGFloat = 8
        
        // Define nameLabel frame
        nameLabel.frame = CGRect(x: padding,
                                 y: safeAreaInsets.top + padding,
                                 width: width - (padding * 2),
                                 height: 30)
        
        // Define descriptionLabel frame
        descriptionLabel.frame = CGRect(x: padding,
                                        y: nameLabel.bottom + (padding * 2),
                                        width: width - (padding * 2),
                                        height: height - nameLabel.bottom -  (padding * 2))
        // Adjust height to fit label text
        descriptionLabel.sizeToFit()
        
        // Define contributedByLabel frame
        contributedByLabel.frame = CGRect(x: padding,
                                        y: descriptionLabel.bottom + (padding * 2),
                                        width: (width * 2 / 3) - (padding * 2),
                                        height: 20)
        
        // Define firstBrewedDateLabel frame
        firstBrewedDateLabel.frame = CGRect(x: padding,
                                          y: contributedByLabel.bottom + padding,
                                          width: (width * 2 / 3) - (padding * 2),
                                          height: 20)
        
        // Define abvLabel frame
        abvLabel.frame = CGRect(x: padding,
                                          y: firstBrewedDateLabel.bottom + padding,
                                          width: (width * 2 / 3) - (padding * 2),
                                          height: 20)
        
        // Define ibuLabel frame
        ibuLabel.frame = CGRect(x: padding,
                                          y: abvLabel.bottom + padding,
                                          width: (width * 2 / 3) - (padding * 2),
                                          height: 20)
        
        // Define ebcLabel frame
        ebcLabel.frame = CGRect(x: padding,
                                          y: ibuLabel.bottom + padding,
                                          width: (width * 2 / 3) - (padding * 2),
                                          height: 20)
        
        // Define srmLabel frame
        srmLabel.frame = CGRect(x: padding,
                                          y: ebcLabel.bottom + padding,
                                          width: (width * 2 / 3) - (padding * 2),
                                          height: 20)
        
        // Define targetOfLabel frame
        targetOgLabel.frame = CGRect(x: padding,
                                          y: srmLabel.bottom + padding,
                                          width: (width * 2 / 3) - (padding * 2),
                                          height: 20)
        
        // Define targetFgLabel frame
        targetFgLabel.frame = CGRect(x: padding,
                                          y: targetOgLabel.bottom + padding,
                                          width: (width * 2 / 3) - (padding * 2),
                                          height: 20)
        
        // Define phLabel frame
        phLabel.frame = CGRect(x: padding,
                                          y: targetFgLabel.bottom + padding,
                                          width: (width * 2 / 3) - (padding * 2),
                                          height: 20)
        
        // Define attenuationLevelLabel frame
        attenuationLevelLabel.frame = CGRect(x: padding,
                                          y: phLabel.bottom + padding,
                                          width: (width * 2 / 3) - (padding * 2),
                                          height: 20)
        
        // Define beerImageView frame
        beerImageView.frame = CGRect(x: (width * 2 / 3) + padding,
                                     y: descriptionLabel.bottom + (padding * 2),
                                     width: (width / 3.0) - (padding * 2),
                                     height: attenuationLevelLabel.bottom - contributedByLabel.top)
        
        // Define ingredients frame
        ingredientsLabel.frame = CGRect(x: padding,
                                        y: beerImageView.bottom + (padding * 3),
                                        width: width - (padding * 2),
                                        height: 0)
        // Adjust height to fit label text
        ingredientsLabel.sizeToFit()
        
        // Define methodLabel frame
        methodLabel.frame = CGRect(x: padding,
                                        y: ingredientsLabel.bottom + (padding * 2),
                                        width: width - (padding * 2),
                                        height: 0)
        // Adjust height to fit label text
        methodLabel.sizeToFit()
        
        scrollView.contentSize = CGSize(width: width, height: methodLabel.bottom + (padding * 2))
    }
    
    // MARK: - Label Functions
    
    // Method to create all information of the ingredientLabel text
    private func createIngredientLabel(beerRecipe: BeerRecipe) {
        // Create ingredients header
        var ingredientsString = "--Ingredients--\n"
        
        // Append malt ingredients
        ingredientsString.append("Malt:\n")
        
        guard let malts = beerRecipe.ingredients?.malts?.allObjects as? [Malt] else {
            print("Failed to get Malts")
            return
        }
        
        
        for malt in malts {
            ingredientsString.append("-\(malt.name ?? ""), \(malt.amount) \(malt.units ?? "")\n")
        }

        guard let hops = beerRecipe.ingredients?.hops?.allObjects as? [Hops] else {
            print("Failed to get Malts")
            return
        }
        
        // Append hops ingredients
        ingredientsString.append("\nHops:\n")
        for hop in hops {
            ingredientsString.append("-\(hop.name ?? ""), \(hop.attribute ?? ""), \(hop.add ?? ""), \(hop.amount) \(hop.units ?? "")\n")
        }

        // Append yeast used
        ingredientsString.append("\nYeast: \(beerRecipe.ingredients?.yeast ?? "yeast")\n")

        // Append food pairings
        ingredientsString.append("\nFood Pairings:\n")
        guard let pairings = beerRecipe.foodPairings else {
            return
        }
        
        for (index, pairing) in pairings.enumerated() {
            ingredientsString.append("\(index + 1). \(pairing)\n")
        }

        // Assign ingredientsString to ingredientsLabel text
        ingredientsLabel.text = ingredientsString
    }
    
    // Method to create all information of the methodLabel text
    private func createMethodLabel(beerRecipe: BeerRecipe) {
        // Create Method header
        var methodString = "--Method--\n"
        
        // Append volume
        methodString.append("Volume:\n")
        methodString.append("\(beerRecipe.volume?.value ?? 0) \(beerRecipe.volume?.units ?? "liters")\n")

        // Append boiling volume
        methodString.append("\nBoiling Volume:\n")
        methodString.append("\(beerRecipe.boilVolume?.value ?? 0) \(beerRecipe.boilVolume?.units ?? "")\n")

        guard let mash_temp = beerRecipe.method?.mashTemp?.allObjects as? [MashTemp] else {
            print("Failed to get Malts")
            return
        }
        
        // Append mashing instructions
        methodString.append("\nMashing:\n")
        for (index, mash) in mash_temp.enumerated() {
            if mash.duration != 0 {
                methodString.append("\(index + 1). \(mash.temperature) degrees \(mash.units ?? "minutes") for \(mash.duration)min\n")
            }
            else {
                methodString.append("\(index + 1). \(mash.temperature) degrees \(mash.units ?? "minutes")\n")
            }
        }

        // Append fermentation instructions
        methodString.append("\nFermentation:\n")
        methodString.append("\(beerRecipe.method?.fermentation?.amount ?? 0.0) degrees \(beerRecipe.method?.fermentation?.units ?? "celsius")")

        // Append brewing tips
        methodString.append("\n\nBrewing Tips: \(beerRecipe.brewing_tips ?? "No tips")")

        // Assign methodString to methodLabel text
        methodLabel.text = methodString
    }
    
    static func makeBoldLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .bold)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }
    
    static func makeDetailLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.font = .italicSystemFont(ofSize: 16)
        return label
    }
}


