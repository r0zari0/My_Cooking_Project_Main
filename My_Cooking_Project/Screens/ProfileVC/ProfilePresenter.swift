//
//  ProfilePresenter.swift
//  My_Cooking_Project
//
//  Created by Max Stovolos on 1/9/23.
//

import Foundation
import UIKit

// MARK: - Protocol

protocol ProfilePresenterProtocol {
    func showLinkedin(view: UIViewController)
    func showGmail(view: UIViewController)
    func showGithub(view: UIViewController)
}

// MARK: - ProfilePresenter

class ProfilePresenter: ProfilePresenterProtocol {
    
    //MARK: - Properties
    
    private let urlLinkedin = "www.linkedin.com/in/maksym-stovolos-3a7071241"
    private let urlgithub = "https://github.com/r0zari0"
    private let urlgmail = "https://mail.google.com/mail/u/1/#inbox"
    
    private let navigator: NavigatorProtocol
    
    //MARK: - Init
    
    init(navigator: NavigatorProtocol) {
        self.navigator = navigator
    }
    
    func showLinkedin(view: UIViewController) {
        navigator.showWebViewVC(view: view, url: urlLinkedin)
    }
    
    func showGmail(view: UIViewController) {
        navigator.showWebViewVC(view: view, url: urlgmail)
    }
    
    func showGithub(view: UIViewController) {
        navigator.showWebViewVC(view: view, url: urlgithub)
    }
}
