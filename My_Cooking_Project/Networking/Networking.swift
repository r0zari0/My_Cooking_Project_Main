//
//  Networking.swift
//  My_Cooking_Project
//
//  Created by Max Stovolos on 1/10/23.
//

import Foundation

// MARK: - NetworkingProtocol

protocol NetworkingProtocol {
    func getModel(type: RecipeType, closure: @escaping ([Hit]) -> ())
}

// MARK: - Networking

class Networking: NetworkingProtocol {
    func getModel(type: RecipeType, closure: @escaping ([Hit]) -> ()) {
        
        let headers = [
            "X-RapidAPI-Key": "d48b37f797msh914f92f5efbf2b8p18795ejsn2d67a777e5d2",
            "X-RapidAPI-Host": "edamam-recipe-search.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://edamam-recipe-search.p.rapidapi.com/search?q=\(type.partURL)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            if let response = response {
                print(response)
            }
            
            if let data = data {
                print(data)
            }
            
            let decoder = JSONDecoder()
            do {
                if let data {
                    let food = try decoder.decode(FoodType.self, from: data)
                    DispatchQueue.main.async {
                        closure(food.hits)
                    }
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    static func loadAsyncImage(url: URL, closure: @escaping (Data, URLResponse) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data, let response = response else {
                return
            }
            
            guard let responseURL = response.url else {
                return
            }
            
            guard url == responseURL else { return }
            
            closure(data, response)
        }.resume()
    }
}
