//
//  ListFoodVC.swift
//  My_Cooking_Project
//
//  Created by Max Stovolos on 1/9/23.
//

import UIKit

  // MARK: - Protocol

protocol ListFoodVCProtocol: AnyObject {
    func reload()
    func setupTitle(title: String)
}

// MARK: - Life Cycle

class ListFoodVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var listFoodTableView: UITableView!
    
    // MARK: - Properties
    
    private let presenter: ListFoodPresenterProtocol
    
    private let cellIdentifier: String = String(describing: "ListFoodCell")
    
    //MARK: - Init
    
    init(presenter: ListFoodPresenterProtocol, networking: NetworkingProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.getInternetRecipe()
        view.showActivityIndicator()
    }
}

// MARK: - Extension

extension ListFoodVC {
    func setupUI() {
        setupTableView()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func setupTableView() {
        listFoodTableView.layer.opacity = 0
        
        listFoodTableView.dataSource = self
        listFoodTableView.delegate = self
        listFoodTableView.register(.init(nibName: String(describing: cellIdentifier), bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
}

extension ListFoodVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.foodRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ListFoodCell
        
        let foodRecipes = presenter.foodRecipes[indexPath.row]
        cell.config(recipe: foodRecipes.recipe)
        
        return cell 
    }
}

extension ListFoodVC: ListFoodVCProtocol {
    func setupTitle(title: String) {
        navigationItem.title = title
    }
    
    func reload() {
        listFoodTableView.reloadData()
        view.hideActivityIndicatorView()
        
        UIView.animate(withDuration: 2) {
            self.listFoodTableView.layer.opacity = 1

//            if self.presenter.screenType == .favoriteRecipe {
//                self.emptyLabel.isHidden = !self.presenter.foodRecipes.isEmpty
//            }
        }
    }
}
