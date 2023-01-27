//
//  CategoriesFoodCell.swift
//  My_Cooking_Project
//
//  Created by Max Stovolos on 1/11/23.
//

import UIKit

// MARK: - CategoriesFoodCell

class CategoriesFoodCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var typeFoodImage: UIImageView!
    
    @IBOutlet weak var typeFoodLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func config(with title: String, type: RecipeType) {
        typeFoodLabel.text = title
        typeFoodImage.image = type.image
    }
}

// MARK: - Extension

extension CategoriesFoodCell {
    func setupUI() {
        typeFoodLabel.textColor = .white
        backgroundColor = .black
        layer.cornerRadius = 8
    }
}
