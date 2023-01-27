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
    
    @IBOutlet weak var emptyLabel: UILabel!
    
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
        
        view.showActivityIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if presenter.screenType == .internetRecipe {
            presenter.getInternetRecipes()
        } else {
            presenter.getRecipesCD()
            setupTitle(title: "Favorits recipes")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - Extension

extension ListFoodVC {
    func setupUI() {
        setupTableView()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func setupTableView() {
        listFoodTableView.showsVerticalScrollIndicator = false
        listFoodTableView.layer.opacity = 0
        
        listFoodTableView.dataSource = self
        listFoodTableView.delegate = self
        listFoodTableView.register(.init(nibName: String(describing: cellIdentifier), bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
}

extension ListFoodVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showRecipeDetailsVC(view: self, recipe: presenter.foodRecipes[indexPath.row].recipe)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.foodRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ListFoodCell
        
        let foodRecipes = presenter.foodRecipes[indexPath.row]
        cell.config(recipe: foodRecipes.recipe)
        
        return cell 
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if self.presenter.screenType == .favoriteRecipe {
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, closure in
                self.presenter.deleteRecipeInDataBase(indexPath: indexPath) {
                    
                    DispatchQueue.main.async {
                        self.listFoodTableView.deleteRows(at: [indexPath], with: .automatic)
                        self.reload()
                    }
                }
                
                closure(true)
            }
            
            deleteAction.image = UIImage(systemName: "trash")!
            deleteAction.backgroundColor = .systemRed
            
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            configuration.performsFirstActionWithFullSwipe = true
            
            return configuration
        } else {
            return nil
        }
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
            
            if self.presenter.screenType == .favoriteRecipe {
                self.emptyLabel.isHidden = !self.presenter.foodRecipes.isEmpty
            }
        }
    }
}
