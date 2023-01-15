//
//  CategoriesFoodPresenter.swift
//  My_Cooking_Project
//
//  Created by Max Stovolos on 1/9/23.
//

import Foundation
import UIKit

// MARK: - Protocol

protocol CategoriesFoodPresenterProtocol {
    var recipeType: [RecipeType] { get }
    
    func showListFoodVC(view: UIViewController, indexPath: Int)
}

// MARK: - CategoriesFoodPresenter

class CategoriesFoodPresenter: CategoriesFoodPresenterProtocol {
    
    let recipeType = RecipeType.allCases
    
    private let navigator: NavigatorProtocol
   
    
    init(navigator: NavigatorProtocol) {
        self.navigator = navigator
    }
    
    func showListFoodVC(view: UIViewController, indexPath: Int) {
        let index = recipeType[indexPath]
        
        navigator.showListFoodVC(view: view, type: index)
    }
}
