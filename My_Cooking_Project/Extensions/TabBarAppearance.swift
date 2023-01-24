//
//  TabBarAppearance.swift
//  My_Cooking_Project
//
//  Created by Max Stovolos on 1/16/23.
//

import Foundation
import UIKit

struct TabBarAppearance {
    
    static var shared = TabBarAppearance()
    
    func setAppearance() {
        UITabBar.appearance().barTintColor = .black
        UITabBar.appearance().unselectedItemTintColor = .white
        UITabBar.appearance().tintColor = .buttonColor
    }
}
