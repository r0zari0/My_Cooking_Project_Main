//
//  Assembler.swift
//  My_Cooking_Project
//
//  Created by Max Stovolos on 1/9/23.
//

import Foundation
import UIKit

// MARK: - Assembler

class Assembler {
    private let networking = Networking()
    private let coreData = CoreDataStore()
    
    
    func createStartVC(navigator: NavigatorProtocol) -> UIViewController {
        let presenter = StartPresenter(navigator: navigator)
        let vc = StartVC(presenter: presenter)
        
        return vc
    }
    
    func createTabBarScreen(navigator: NavigatorProtocol) -> UIViewController {
        let vc = FlowController(
            navigator: navigator,
            networking: networking,
            coreData: coreData
        )
        
        return vc
    }
    
    func createCategoriesFoodVC(navigator: NavigatorProtocol) -> UIViewController {
        let presenter = CategoriesFoodPresenter(navigator: navigator)
        let vc = CategoriesFoodVC(presenter: presenter)
        
        return vc
    }
    
    func createListFoodVC(navigator: NavigatorProtocol, type: RecipeType, screenType: ScreenType) -> UIViewController {
        let presenter = ListFoodPresenter(
            type: type,
            navigator: navigator,
            networking: networking,
            coreData: coreData,
            screenType: screenType
        )
        
        let vc = ListFoodVC(presenter: presenter, networking: networking)
        presenter.view = vc
        
        return vc
    }
    
    func createRecipeDetailsVC(recipe: Recipe, navigator: NavigatorProtocol) -> UIViewController {
        let presenter = RecipeDetailsPresenter(
            detailedRecipe: recipe,
            navigator: navigator,
            networking: networking,
            coreData: coreData
        )
        
        let vc = RecipeDetailsVC(presenter: presenter)
        
        return vc
    }
    
    func createWebViewVC(url: String) -> UIViewController {
        let vc = WebViewVC(url: url)
        
        return vc
    }
}
