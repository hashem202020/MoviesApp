//
//  AppDelegate.swift
//  MoviesApp
//
//  Created by Khaled hashem on 10/05/2025.
//

import UIKit
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var appCoordinator: AppCoordinator?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationController = UINavigationController()
        let appDependencyContainer = AppDependencyContainer()
        let window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = AppCoordinator(navigationController: navigationController,
                                        homeDependencyContainer: appDependencyContainer.homeDependencyContainer)
        
        appCoordinator?.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}

