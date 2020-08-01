//
//  DCGTabBarController.swift
//  DCGitHubFollowers
//
//  Created by Daniel on 30/07/20.
//  Copyright © 2020 Daniel. All rights reserved.
//

import UIKit

class DCGFTabBarController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        self.viewControllers          = [createSearchNC(), createFavoritesNC()]
        
    }
    
    
    func createSearchNC() -> UINavigationController {
        let searchVC                    = SearchVC()
        searchVC.title                  = "Search"
        searchVC.tabBarItem             = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }

    
    func createFavoritesNC() -> UINavigationController {
        let favoritesListVC             = FavoritesListVC()
        favoritesListVC.title           = "Favorites List"
        favoritesListVC.tabBarItem      = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesListVC)
    }
    

}
