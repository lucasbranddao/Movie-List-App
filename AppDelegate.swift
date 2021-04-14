//
//  AppDelegate.swift
//  Movies
//
//  Created by Lucas Brandão on 23/01/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        let navigationController = UINavigationController(rootViewController: MainViewController())
        
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.topViewController?.title = "Search"
        navigationController.view.backgroundColor = .clear
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.largeTitleTextAttributes = textAttributes
        navigationController.navigationBar.titleTextAttributes = textAttributes
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.tintColor = .orangeCustomColor
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController
        
        return true
    }

}

