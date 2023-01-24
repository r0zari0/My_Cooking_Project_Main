//
//  RecipeDetailsVC.swift
//  My_Cooking_Project
//
//  Created by Max Stovolos on 1/17/23.
//

import UIKit

// MARK: - RecipeDetailsVC

class RecipeDetailsVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var weightLabel: UILabel!
    @IBOutlet private weak var caloriesLabel: UILabel!
    
    @IBOutlet private weak var ingredientsTableView: UITableView!
    
    @IBOutlet private weak var recipeImage: ImageView!
    
    // MARK: - Properties
    
    private var presenter: RecipeDetailsPresenterProtocol
    
    private let cellIdentifier: String = String(describing: "IngredientsTableViewCell")
    
    // MARK: - Init
    
    init(presenter: RecipeDetailsPresenterProtocol) {
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
        setupTabelView()
    }
}

// MARK: - Extension

extension RecipeDetailsVC {
    func setupUI() {
        createRightBurButton()
        
        navigationItem.largeTitleDisplayMode = .never
        
        recipeImage.fetchImage(from: presenter.detailedRecipe.image)
        
        recipeImage.layer.cornerRadius = recipeImage.bounds.width / 8
        
        timeLabel.text = "Time: \(Int(presenter.detailedRecipe.totalTime)) min"
        caloriesLabel.text = "Calories: \(Int(presenter.detailedRecipe.calories)) cal"
        weightLabel.text = "Weight: \(Int(presenter.detailedRecipe.totalWeight)) grams"
    }
    func setupTabelView() {
        ingredientsTableView.showsVerticalScrollIndicator = false
        
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        ingredientsTableView.register(.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "buttonColor")
        button.tintColor = .red
        button.setTitle("Full Recipe", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(goToTheInternet), for: .touchUpInside)
        
        return button
    }
    
    @objc
    private func goToTheInternet() {
    }
    
    func createRightBurButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: presenter.isFavorite ? "heartSelected" :"heart"), style: .done, target: self, action: #selector(addTapped))
    }
    
    @objc
    func addTapped(){
        presenter.isFavorite.toggle()
        createRightBurButton()
        presenter.saveRecipeInDataBase()
    }
}

extension RecipeDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.detailedRecipe.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! IngredientsTableViewCell
        
        let ingredient = presenter.detailedRecipe.ingredients[indexPath.row]
        
        cell.config(ingredient: ingredient)
        
        return cell
    }
}
