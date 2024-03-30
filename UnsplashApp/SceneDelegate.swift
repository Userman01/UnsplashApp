//
//  SceneDelegate.swift
//  UnsplashApp
//
//  Created by Петр Постников on 29.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = makeTabBarController()
        self.window = window
        window.makeKeyAndVisible()
    }
}

extension SceneDelegate {
    
    private func makeTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .gray
        tabBarController.tabBar.isTranslucent = false
        tabBarController.view.backgroundColor = .white
        let firstViewController = UINavigationController(rootViewController: MainViewController())
        let secondViewController = UINavigationController(rootViewController: SecondViewController())
        firstViewController.tabBarItem = UITabBarItem(title: "First", image: nil, tag: 0)
        secondViewController.tabBarItem = UITabBarItem(title: "Second", image: nil, tag: 1)
        tabBarController.viewControllers = [firstViewController, secondViewController]
        return tabBarController
    }
    
}
