//
//  StartVC.swift
//  My_Cooking_Project
//
//  Created by Max Stovolos on 1/9/23.
//

import UIKit

// MARK: - StartVC

class StartVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var startImageView: UIImageView!
    
      // MARK: - Properties
    
    let presenter: StartPresenterProtocol
    
    // MARK: - Init
    
    init(presenter: StartPresenterProtocol) {
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
    
    func setupUI() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        startImageView.image = UIImage(named: "startScreenImage")
        startImageView.alpha = 0.4
    }
    
    @IBAction func showNextScreen(_ sender: Any) {
        presenter.showCategoriesFoodVC(view: self)
    }
}
