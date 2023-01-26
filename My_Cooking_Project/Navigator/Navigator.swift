//
//  Navigator.swift
//  My_Cooking_Project
//
//  Created by Max Stovolos on 1/9/23.
//

import Foundation
import UIKit

// MARK: - Protocol

protocol NavigatorProtocol {
    func showCategoriesFoodVC(view: UIViewController)
    func showListFoodVC(view: UIViewController, type: RecipeType, screenType: ScreenType)
    func showRecipeDetailsVC(view: UIViewController, recipe: Recipe)
    func showWebViewVC(view: UIViewController, url: String)
}

// MARK: - Navigator

class Navigator: NavigatorProtocol {
    
    let assembler = Assembler()
    
    func showStartVC() -> UIViewController {
        let vc = assembler.createStartVC(navigator: self)
        
        return vc
    }
    
    func showCategoriesFoodVC(view: UIViewController) {
        let vc = assembler.createTabBarScreen(navigator: self)
        
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        view.navigationController?.present(vc, animated: true)
    }
    
    func showListFoodVC(view: UIViewController, type: RecipeType, screenType: ScreenType) {
        let vc = assembler.createListFoodVC(navigator: self, type: type, screenType: screenType)
        
        vc.hidesBottomBarWhenPushed = true
        view.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showRecipeDetailsVC(view: UIViewController, recipe: Recipe) {
        let vc = assembler.createRecipeDetailsVC(recipe: recipe, navigator: self)
        
        view.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showWebViewVC(view: UIViewController, url: String) {
        let vc = assembler.createWebViewVC(url: url)
        view.hidesBottomBarWhenPushed = true
        view.navigationController?.pushViewController(vc, animated: true)
    }
}
