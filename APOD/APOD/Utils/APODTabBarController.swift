//
//  APODTabBarController.swift
//  APOD
//
//  Created by Fabricio Pujol on 15/02/25.
//

import UIKit

class APODTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .apodLetters
        viewControllers = [createSearchNavigationController(), createFavoritesNavigationController()]
    }

    func createSearchNavigationController() -> UINavigationController {
        let APODVC = APODViewController()
        APODVC.title = "APOD"
        APODVC.tabBarItem = UITabBarItem(title: "APOD", image: UIImage(systemName: "camera.fill"), tag: 0)
        return UINavigationController(rootViewController: APODVC)
    }

    func createFavoritesNavigationController() -> UINavigationController {
        let favoriteListVC = APODViewController()
        favoriteListVC.title = "Favorites"
        favoriteListVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart.fill"), tag: 1)
        return UINavigationController(rootViewController: favoriteListVC)
    }
}
