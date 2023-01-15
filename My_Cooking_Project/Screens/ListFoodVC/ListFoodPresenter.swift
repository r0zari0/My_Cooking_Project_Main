//
//  ListFoodPresenter.swift
//  My_Cooking_Project
//
//  Created by Max Stovolos on 1/9/23.
//

import Foundation
import UIKit

  // MARK: - Properties

protocol ListFoodPresenterProtocol {
    var foodRecipes: [Hit] { get }
    func getInternetRecipe()
}

// MARK: - ListFoodPresenter

class ListFoodPresenter: ListFoodPresenterProtocol {
    
      // MARK: - Properties
    
    var foodRecipes: [Hit] = []
    let type: RecipeType
    weak var view: ListFoodVCProtocol?
    
    private let navigator: NavigatorProtocol
    private let networking: NetworkingProtocol
    
    // MARK: - Init
    
    init(type: RecipeType, navigator: NavigatorProtocol, networking: NetworkingProtocol) {
        self.type = type
        self.navigator = navigator
        self.networking = networking
    }
    
}

extension ListFoodPresenter {
    func getInternetRecipe() {
        view?.setupTitle(title: type.rawValue + "recipes")
        networking.getModel(type: type) { hit in
            self.foodRecipes = hit
            self.view?.reload()
        }
    }
}
