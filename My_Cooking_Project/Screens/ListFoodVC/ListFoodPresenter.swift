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
    var screenType: ScreenType { get }
    var foodRecipes: [Hit] { get }
    
    func deleteRecipeInDataBase(indexPath: IndexPath, closure: () -> Void)
    func getInternetRecipes()
    func getRecipesCD()
    func showRecipeDetailsVC(view: UIViewController, recipe: Recipe)
}

// MARK: - ListFoodPresenter

class ListFoodPresenter: ListFoodPresenterProtocol {
    
    // MARK: - Properties
    
    let screenType: ScreenType
    var foodRecipes: [Hit] = []
    weak var view: ListFoodVCProtocol?
    
    private let type: RecipeType
    private var coreData: CoreDataStoreProtocol
    private let navigator: NavigatorProtocol
    private let networking: NetworkingProtocol
    
    // MARK: - Init
    
    init(type: RecipeType,
         navigator: NavigatorProtocol,
         networking: NetworkingProtocol,
         coreData: CoreDataStoreProtocol,
         screenType: ScreenType
    ) {
        self.type = type
        self.navigator = navigator
        self.networking = networking
        self.coreData = coreData
        self.screenType = screenType
    }
    
}

// MARK: - Extension

extension ListFoodPresenter {
    func getInternetRecipes() {
        view?.setupTitle(title: type.rawValue + " recipes")
        networking.getModel(type: type) { hit in
            self.foodRecipes = hit
            self.view?.reload()
        }
    }
    
    func getRecipesCD() {
        coreData.fetchRecipes { [weak self] recipe in
            let likedRecipes = recipe.map(Recipe.init(recipe:))
            let hits = likedRecipes.map { Hit(recipe: $0) }
            self?.foodRecipes = hits
            self?.view?.reload()
        }
    }
    
    func showRecipeDetailsVC(view: UIViewController, recipe: Recipe) {
        navigator.showRecipeDetailsVC(view: view, recipe: recipe)
    }
    
    func deleteRecipeInDataBase(indexPath: IndexPath, closure: () -> Void) {
        
        coreData.deleteRecipe(label: foodRecipes[indexPath.row].recipe.label)
        foodRecipes.remove(at: indexPath.row)
        
        coreData.saveContext()
        
        closure()
    }
}
