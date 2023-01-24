//
//  IngredientsTableViewCell.swift
//  My_Cooking_Project
//
//  Created by Max Stovolos on 1/21/23.
//

import UIKit

// MARK: - IngredientsTableViewCell

class IngredientsTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var ingredientImage: ImageView!
    
    @IBOutlet weak var ingredientLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    // MARK: - Func
    
    func config(ingredient: Ingredient) {
        ingredientLabel.text = ingredient.text
        
        ingredientImage.fetchImage(from: ingredient.image!)
        
    }
    
    private func setupCell() {
        selectionStyle = .none
        ingredientImage.layer.cornerRadius = ingredientImage.bounds.width / 2
    }
}
