//
//  RecipeDetailsPresenter.swift
//  My_Cooking_Project
//
//  Created by Max Stovolos on 1/17/23.
//

import Foundation

// MARK: - Protocol

protocol RecipeDetailsPresenterProtocol {
    var detailedRecipe: Recipe { get }
    var isFavorite: Bool { get set }
    
    func saveRecipeInDataBase()
}

// MARK: - RecipeDetailsPresenter

class RecipeDetailsPresenter: RecipeDetailsPresenterProtocol {
    
    // MARK: - Properties
    
    var detailedRecipe: Recipe
    var isFavorite: Bool = false
    
    private let navigator: NavigatorProtocol
    private let networking: NetworkingProtocol
    private let coreData: CoreDataStoreProtocol
    
    // MARK: - Init
    
    init(
        detailedRecipe: Recipe,
        navigator: NavigatorProtocol,
        networking: NetworkingProtocol,
        coreData: CoreDataStoreProtocol
    ) {
        self.detailedRecipe = detailedRecipe
        self.navigator = navigator
        self.networking = networking
        self.coreData = coreData
    }
}

// MARK: - Extension

extension RecipeDetailsPresenter: ProfilePresenterProtocol {
    
    func saveRecipeInDataBase() {
        guard !coreData.fetchRequestIfConsistElement(with: detailedRecipe.label) else {
            coreData.deleteRecipe(label: detailedRecipe.label)
            return
        }
                
        let recipeDataBase = LikedFoodCD(context: coreData.context)
        recipeDataBase.recipeName = detailedRecipe.label
        recipeDataBase.recipeImage = detailedRecipe.image
        recipeDataBase.recipeAuthor = detailedRecipe.source
        recipeDataBase.totalTime = detailedRecipe.totalTime
        recipeDataBase.totalWeight = detailedRecipe.totalWeight
        recipeDataBase.calories = detailedRecipe.calories
        recipeDataBase.url = detailedRecipe.url
        
        detailedRecipe.ingredients.forEach { ingredient in
            let dataBaseIngredient = IngredientCD(context: self.coreData.context)
            dataBaseIngredient.text = ingredient.text
            dataBaseIngredient.image = ingredient.image
            
            recipeDataBase.addToLikedIngredient(dataBaseIngredient)
        }
        coreData.saveContext()
    }
}
