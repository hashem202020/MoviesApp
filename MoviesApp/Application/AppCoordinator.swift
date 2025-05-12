//
//  AppCoordinator.swift
//  MoviesApp
//
//  Created by Khaled hashem on 11/05/2025.
//

import UIKit
import SwiftUI

final class AppCoordinator: Coordinator {
    private var navigationController: UINavigationController?
    private let homeDependencyContainer: HomeDependencyContainer
    
    init(navigationController: UINavigationController? = nil,
         homeDependencyContainer: HomeDependencyContainer) {
        self.navigationController = navigationController
        self.homeDependencyContainer = homeDependencyContainer
    }
    
    private func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.shadowColor = .clear
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }

    func start() {
        let moviesListViewController = homeDependencyContainer.makeMoviesListView(navigationController: navigationController)
        navigationController?.setViewControllers([moviesListViewController], animated: false)

    }

}
