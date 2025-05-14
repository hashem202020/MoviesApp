//
//  HomeCoordinator.swift
//  MoviesApp
//
//  Created by Khaled hashem on 13/05/2025.
//

import UIKit

protocol HomeCoordinator {
    func openMovieDetails(id: Int)
}

final class DefaultHomeCoordinator: HomeCoordinator {
    private var navigationController: UINavigationController?
    private let homeDependencyContainer: HomeDependencyContainer
    
    init(navigationController: UINavigationController? = nil,
         homeDependencyContainer: HomeDependencyContainer) {
        self.navigationController = navigationController
        self.homeDependencyContainer = homeDependencyContainer
    }
        
    func openMovieDetails(id: Int) {
        let movieDetailsView = homeDependencyContainer.makeMovieDetailsView(id: id)
        navigationController?.pushViewController(movieDetailsView, animated: true)
    }
}
