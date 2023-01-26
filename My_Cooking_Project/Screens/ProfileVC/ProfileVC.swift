//
//  ProfileVC.swift
//  My_Cooking_Project
//
//  Created by Max Stovolos on 1/9/23.
//

import UIKit

// MARK: - ProfileVC

class ProfileVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var githubButton: UIButton!
    @IBOutlet weak var linkedinButton: UIButton!
    @IBOutlet weak var gmailButton: UIButton!
    
    // MARK: - Properties
    
    let presenter: ProfilePresenterProtocol
    
    // MARK: - Init
    
    init(presenter: ProfilePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
    }
    
    func setupButtons() {
        githubButton.setImage(UIImage(named: "github"), for: .normal)
        linkedinButton.setImage(UIImage(named: "linkedin"), for: .normal)
        gmailButton.setImage(UIImage(named: "gmail"), for: .normal)
    }
}
