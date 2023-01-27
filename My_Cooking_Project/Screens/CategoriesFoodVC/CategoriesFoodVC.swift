//
//  CategoriesFoodVC.swift
//  My_Cooking_Project
//
//  Created by Max Stovolos on 1/9/23.
//

import Foundation
import UIKit

// MARK: - CategoriesFoodVC

class CategoriesFoodVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var typeCollectionView: UICollectionView!
    
    // MARK: - Properties
    
    private let presenter: CategoriesFoodPresenterProtocol
    
    // MARK: - Init
    
    init(presenter: CategoriesFoodPresenterProtocol) {
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
    }
}

// MARK: - Extensions

extension CategoriesFoodVC {
    func setupUI() {
        setupNavigationController()
        setupCollectionView()
    }
    
    func setupNavigationController() {
        title = "Recipes"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupCollectionView() {
        typeCollectionView.showsVerticalScrollIndicator = false
        
        typeCollectionView.delegate = self
        typeCollectionView.dataSource = self
        typeCollectionView.register(.init(nibName: String(describing: CategoriesFoodCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: CategoriesFoodCell.self))
    }
    
}

extension CategoriesFoodVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.showListFoodVC(view: self, indexPath: indexPath.item, screenType: .internetRecipe)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.recipeType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoriesFoodCell.self), for: indexPath) as! CategoriesFoodCell
        
        let typeFood = presenter.recipeType[indexPath.item]
        
        cell.config(with: typeFood.rawValue, type: typeFood)
        
        return cell
    }
}

extension CategoriesFoodVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 32, height: 150
        )
    }
}
