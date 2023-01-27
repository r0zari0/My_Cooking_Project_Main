//
//  StartPresenter.swift
//  My_Cooking_Project
//
//  Created by Max Stovolos on 1/9/23.
//

import Foundation
import UIKit

// MARK: - StartPresenterProtocol

protocol StartPresenterProtocol {
    func showCategoriesFoodVC(view: UIViewController)
}

// MARK: - StartPresenter

class StartPresenter: StartPresenterProtocol {
    
    // MARK: - Properties
    
    private let navigator: NavigatorProtocol
    
    // MARK: - Init
    
    init(navigator: NavigatorProtocol) {
        self.navigator = navigator
    }
    
    func showCategoriesFoodVC(view: UIViewController) {
        navigator.showCategoriesFoodVC(view: view)
    }
}
