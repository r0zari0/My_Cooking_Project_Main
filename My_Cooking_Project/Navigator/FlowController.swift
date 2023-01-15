//
//  FlowController.swift
//  My_Cooking_Project
//
//  Created by Max Stovolos on 1/9/23.
//

import UIKit

// MARK: - FlowController

class FlowController: UIViewController, UITabBarControllerDelegate {
    
    private var embedTabBarVC: UITabBarController = UITabBarController()
    
    private lazy var startVC: UIViewController = instantiateStartVC()
    private lazy var favoriteFoodVC: UIViewController = favoriteListFoodVC()
    private lazy var myProfileVC: UIViewController = profileVC()
    
    let navigator: NavigatorProtocol
    let networking: NetworkingProtocol
    let coreData: CoreDataStoreProtocol
    
    init(navigator: NavigatorProtocol, networking: NetworkingProtocol, coreData: CoreDataStoreProtocol) {
        self.navigator = navigator
        self.networking = networking
        self.coreData = coreData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        setupTabBar()
        //        setUIAppearanceCustomNavBar(type: .opaque)
    }
    
    func setupTabBar() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = .black
        UITabBar.appearance().tintColor = .white
    }
}

extension FlowController {
    func instantiateStartVC() -> UIViewController {
        let presenter = CategoriesFoodPresenter(navigator: navigator)
        let vc = CategoriesFoodVC(presenter: presenter)
        let navigationVC = UINavigationController(rootViewController: vc)
        vc.tabBarItem = UITabBarItem(
            title: "Recipies", image: UIImage(named: "book"), selectedImage: UIImage(named: "bookSelected")
        )
        return navigationVC
    }
    
    func favoriteListFoodVC() -> UIViewController {
        let presenter = ListFoodPresenter(
            type: .chicken,
            navigator: navigator,
            networking: networking
        )
        
        let vc = ListFoodVC(presenter: presenter, networking: networking)
        
        let navigationVC = UINavigationController(rootViewController: vc)
        vc.tabBarItem = UITabBarItem(
            title: "Favorites", image: UIImage(named: "heart"),
            selectedImage: UIImage(named: "heartSelected")
        )
        
        return navigationVC
    }
    
    func profileVC() -> UIViewController {
        let presenter = ProfilePresenter(navigator: navigator)
        let vc = ProfileVC(presenter: presenter)
        let navigationVC = UINavigationController(rootViewController: vc)
        vc.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), selectedImage: UIImage(named: "profileSelected"))
        
        return navigationVC
    }
    
}

private extension FlowController {
    func initialSetup() {
        view.backgroundColor = .black
        embedTabBarVC.delegate = self
        embedTabBarVC.viewControllers = [startVC, favoriteFoodVC, myProfileVC]
        embedTabBarVC.tabBar.isTranslucent = false
        embedTabBarVC.tabBar.tintColor = .black
        embedTabBarVC.tabBar.unselectedItemTintColor = .gray
        addChild(embedTabBarVC, toContainer: view)
    }
}

