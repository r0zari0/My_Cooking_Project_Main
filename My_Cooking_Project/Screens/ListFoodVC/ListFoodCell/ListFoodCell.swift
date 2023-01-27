//
//  ListFoodCell.swift
//  My_Cooking_Project
//
//  Created by Max Stovolos on 1/12/23.
//

import UIKit
// MARK: - ListFoodCell

class ListFoodCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var recipeImage: ImageView!
    
    @IBOutlet weak var recipeAuthorLabel: UILabel!
    @IBOutlet weak var recipeDescriptionLabel: UILabel!
    @IBOutlet weak var recipeNameLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableViewCell()
    }
    
    func setupTableViewCell() {
        selectionStyle = .none
        recipeImage.layer.cornerRadius = recipeImage.bounds.width / 2
        recipeAuthorLabel.textColor = .white
        recipeNameLabel.textColor = .white
        recipeDescriptionLabel.textColor = .white
    }
    
    func config(recipe: Recipe) {
        recipeImage.fetchImage(from: recipe.image)
        
        recipeNameLabel.text = recipe.label
        recipeDescriptionLabel.text = recipe.source
        recipeAuthorLabel.text = "Author: \(recipe.source)"
    }
}
