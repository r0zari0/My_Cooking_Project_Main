//
//  ProfilePresenter.swift
//  My_Cooking_Project
//
//  Created by Max Stovolos on 1/9/23.
//

import Foundation

  // MARK: - Protocol

protocol ProfilePresenterProtocol {
    
}

// MARK: - ProfilePresenter

class ProfilePresenter: ProfilePresenterProtocol {
    
    private let navigator: NavigatorProtocol
    
    init(navigator: NavigatorProtocol) {
        self.navigator = navigator
    }
}
