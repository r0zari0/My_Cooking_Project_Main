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
    var generalRecipes: [Hit] { get }
    var screenType: ScreenType { get }
    
    func filterContentForSearchText(searchText: String, isFiltering: Bool)
    func deleteRecipeInDataBase(indexPath: IndexPath, closure: () -> Void)
    func getInternetRecipes()
    func getRecipesCD()
    func showRecipeDetailsVC(view: UIViewController, recipe: Recipe)
}

// MARK: - ListFoodPresenter

class ListFoodPresenter: ListFoodPresenterProtocol {
    
    // MARK: - Properties
    
    let screenType: ScreenType
    var generalRecipes: [Hit] = []
    var foodRecipes: [Hit] = []
    weak var view: ListFoodVCProtocol?
    
    private let type: RecipeType
    private var coreData: CoreDataStoreProtocol
    private let navigator: NavigatorProtocol
    private let networking: NetworkingProtocol
    
    private var filteredFoodRecipes: [Hit] = []
    private var isFiltering: Bool = false {
        didSet {
            generalRecipes = isFiltering ? filteredFoodRecipes : foodRecipes
        }
    }
    
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
        networking.getModel(type: type) { [weak self] hit in
            self?.foodRecipes = hit
            self?.generalRecipes = hit
            self?.view?.reload()
        }
    }
    
    func getRecipesCD() {
        coreData.fetchRecipes { [weak self] recipe in
            let likedRecipes = recipe.map(Recipe.init(recipe:))
            let hits = likedRecipes.map { Hit(recipe: $0) }
            self?.foodRecipes = hits
            self?.generalRecipes = hits
            self?.view?.reload()
        }
    }
    
    func showRecipeDetailsVC(view: UIViewController, recipe: Recipe) {
        navigator.showRecipeDetailsVC(view: view, recipe: recipe)
    }
    
    func deleteRecipeInDataBase(indexPath: IndexPath, closure: () -> Void) {
        
        coreData.deleteRecipe(label: generalRecipes[indexPath.row].recipe.label)
        generalRecipes.remove(at: indexPath.row)
        foodRecipes.remove(at: indexPath.row)
        
        closure()
    }
    
    // MARK: - Search
    
    func filterContentForSearchText(searchText: String, isFiltering: Bool) {
        filteredFoodRecipes = foodRecipes.filter { $0.recipe.label.lowercased().contains(searchText.lowercased())
        }
        
        self.isFiltering = isFiltering
        view?.reload()
    }
}
