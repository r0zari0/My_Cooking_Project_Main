//
//  WebViewVC.swift
//  My_Cooking_Project
//
//  Created by Max Stovolos on 1/26/23.
//

import UIKit
import WebKit

// MARK: - Init

class WebViewVC: UIViewController, WKNavigationDelegate {
    
      // MARK: - Properties
    
    var webView: WKWebView!
    private let url: String
    
    // MARK: - Init
    
    init(url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let urlInfo = URL(string: url)  else { return }
        webView.load(URLRequest(url: urlInfo))
        webView.allowsBackForwardNavigationGestures = true
    }
}
