//
//  TabBarController.swift
//  NYTimesBestSeller
//
//  Created by Tsering Lama on 2/5/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit
import DataPersistence

class TabBarController: UITabBarController {
    
    public var dataPersistence = DataPersistence<Book>(filename: "savedBooks.plist")
    
    private lazy var bestSellerVC: BestSellerViewController = {
        let vc = BestSellerViewController(dataPersistence: dataPersistence)
        vc.tabBarItem = UITabBarItem(title: "Best Seller", image: UIImage(systemName: "book.circle"), tag: 0)
        return vc
    }()
    
    private lazy var favoritesVC: FavoritesViewController = {
        let vc = FavoritesViewController(dataPersistence)
        vc.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        return vc
    }()
    
    private lazy var settingVC: SettingsViewController = {
        let vc = SettingsViewController()
        vc.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [UINavigationController(rootViewController: bestSellerVC), UINavigationController(rootViewController: favoritesVC), settingVC]
    }
}
