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
    func showListFoodVC(view: UIViewController, type: RecipeType)
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
    
    func showListFoodVC(view: UIViewController, type: RecipeType) {
        let vc = assembler.createListFoodVC(navigator: self, type: type)
        
        view.navigationController?.pushViewController(vc, animated: true)
    }
}
