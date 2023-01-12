//
//  ImageView.swift
//  My_Cooking_Project
//
//  Created by Max Stovolos on 1/12/23.
//

import Foundation
import UIKit

// MARK: - ImageView

class ImageView: UIImageView {
    
    func fetchImage(from url: String) {
        
        showActivityIndicator()
        
        guard let url = URL(string: url) else {
            image = UIImage(systemName: "star")
            hideActivityIndicatorView()
            
            return
        }
        
        if let cachedImage = getCachedImage(url: url) {
            image = cachedImage
            hideActivityIndicatorView()
            return
        }
        
        Networking.loadAsyncImage(url: url) { loadedImage, response in
            DispatchQueue.main.async {
                self.image = UIImage(data: loadedImage)
                self.hideActivityIndicatorView()
            }
            
            self.saveDataToCache(with: loadedImage, and: response)
        }
    }
    
    private func getCachedImage(url: URL) -> UIImage? {
        let request = URLRequest(url: url)
        if let response = URLCache.shared.cachedResponse(for: request) {
            return UIImage(data: response.data)
        }
        
        return nil
    }
    
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        guard let urlResponse = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        let urlRequest = URLRequest(url: urlResponse)
        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
    }
}
