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
}

// MARK: - ListFoodPresenter

class ListFoodPresenter: ListFoodPresenterProtocol {
    
      // MARK: - Properties
    
    var foodRecipes: [Hit] = []
    
    private let navigator: NavigatorProtocol
    private let networking: NetworkingProtocol
    
    // MARK: - Init
    
    init(navigator: NavigatorProtocol, networking: NetworkingProtocol) {
        self.navigator = navigator
        self.networking = networking
    }
    
}
