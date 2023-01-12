//
//  RecipeType.swift
//  My_Cooking_Project
//
//  Created by Max Stovolos on 1/10/23.
//

import Foundation
import UIKit

enum RecipeType: String, CaseIterable {
    case meat = "Meat"
    case fish = "Fish"
    case chicken = "Chicken"
    case milk = "Milk"
    
    var partURL: String {
        switch self {
        case .meat:
            return "meat"
        case .fish:
            return "fish"
        case .chicken:
            return "chicken"
        case .milk:
            return "milk"
        }
    }
    
    var image: UIImage? {
        UIImage(named: self.rawValue)
    }
}
