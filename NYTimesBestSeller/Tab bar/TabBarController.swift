//
//  TabBarController.swift
//  NYTimesBestSeller
//
//  Created by Tsering Lama on 2/5/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    private var bestSellerVC: BestSellerViewController = {
       let vc = BestSellerViewController()
        vc.tabBarItem = UITabBarItem(title: "Best Seller", image: UIImage(systemName: "book.circle"), tag: 0)
        return vc
    }()
    
    private var favoritesVC: FavoritesViewController = {
       let vc = FavoritesViewController()
        vc.tabBarItem = UITabBarItem(title: "2", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        return vc
    }()

    private var settingVC: SettingsViewController = {
        let vc = SettingsViewController()
        vc.tabBarItem = UITabBarItem(title: "3", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [bestSellerVC, favoritesVC, settingVC]
    }
}
