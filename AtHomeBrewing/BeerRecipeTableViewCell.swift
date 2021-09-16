//
//  BeerRecipeTableViewCell.swift
//  AtHomeBrewing
//
//  BeerRecipeTableViewCell is used to display a single beer recipe snippet.
//  The cell contains an small set of information of the beer recipe that
//  allows users to get a preview of the beer recipe.
//
//  Created by Ryan Helgeson on 8/9/21.
//

import UIKit
import SDWebImage

class BeerRecipeTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    // Identifier used to register/call cell in a UITableView
    public static let identifier = "BeerRecipeTableViewCell"
    
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
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 1
        return label
    }()
    
    // UILabel to display the contributedBy name
    private let contributedByLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .secondaryLabel
        return label
    }()
    
    // UILabel to display the description
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 8
        label.textColor = .secondaryLabel
        return label
    }()
    
    // MARK: - LifeCycle
    
    // Override of the initializer function
    // Add UI Elements to the contentView
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add Subviews
        addSubview(nameLabel)
        addSubview(contributedByLabel)
        addSubview(descriptionLabel)
        addSubview(beerImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Override layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Define padding
        let padding: CGFloat = 7
        
        // Define nameLabel frame
        nameLabel.frame = CGRect(x: padding,
                                 y: padding,
                                 width: (contentView.width / 3.0 * 2) - (padding * 2),
                                 height: 26)
        
        // Define contributedByLabel frame
        contributedByLabel.frame = CGRect(x: padding,
                                        y: nameLabel.bottom + padding,
                                        width: (contentView.width / 3.0 * 2) - (padding * 2),
                                        height: 22)
        
        // Define descriptionLabel frame
        descriptionLabel.frame = CGRect(x: padding,
                                        y: contributedByLabel.bottom + padding,
                                        width: (contentView.width / 3.0 * 2) - padding,
                                        height: contentView.height - contributedByLabel.bottom -  (padding * 2))
        // Adjust height to fit description text
        descriptionLabel.sizeToFit()
        
        // Define beerImageView frame
        beerImageView.frame = CGRect(x: nameLabel.right + (padding * 2),
                                     y: padding,
                                     width: (contentView.width / 3.0) - (padding * 2),
                                     height: contentView.height - (padding * 2))
    }
    
    // Override prepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Reset all labels and images
        nameLabel.text = ""
        contributedByLabel.text = ""
        descriptionLabel.text = ""
        beerImageView.image = nil
    }
    
    // MARK: - Accessor Functions
    
    // Method to configure the BeerRecipeTableViewCell with beer recipe information
    public func configure(beerRecipe: BeerRecipe) {
        
        // Update text labels with specific beer recipe information
        nameLabel.text = beerRecipe.name
        contributedByLabel.text = beerRecipe.contributedName
        descriptionLabel.text = "\(beerRecipe.tagline)\n\n\(beerRecipe.description)"
        
        // Update the beerImageView image with the imageUrl
        beerImageView.sd_setImage(with: beerRecipe.imageUrl, completed: nil)
    }
    
    // Function to return the height of the BeerTableViewCell
    public static func getHeight() -> CGFloat {
        return 240
    }
}
