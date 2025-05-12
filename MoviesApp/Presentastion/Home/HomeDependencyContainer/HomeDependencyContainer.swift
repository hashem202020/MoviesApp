//
//  HomeDependencyContainer.swift
//  MoviesApp
//
//  Created by Khaled hashem on 11/05/2025.
//

import UIKit

protocol HomeDependencyContainer {
    func makeMoviesListView(navigationController: UINavigationController?) -> MoviesListViewController
}

final class DefaultHomeDependencyContainer: HomeDependencyContainer {
    
    func makeMoviesListView(navigationController: UINavigationController?) -> MoviesListViewController {
        return MoviesListViewController(customView: MoviesListView(), popularMoviesViewController: makePopularMoviesViewController())
    }
    
    // MARK: popular
    private func makePopularMoviesViewController() -> PopularMoviesViewController {
        PopularMoviesViewController(customView: PopularMoviesView(), viewModel: makePopularMoviesViewModel())
    }
    
    private func makePopularMoviesViewModel() -> PopularMoviesViewModel {
        PopularMoviesViewModel(getPopularMoviesUseCase: makeGetPopularMoviesUseCase())
    }
    
    private func makeGetPopularMoviesUseCase() -> GetPopularMoviesUseCase {
        DefaultGetPopularMoviesUseCase(movieListRepository: makeMoviesListRepository())
    }
    
    private func makeMoviesListRepository() -> MoviesListRepository {
        DefaultMovieListRepository(moviesRemoteAPI: makeMoviesRemoteAPI())
    }
    
    private func makeMoviesRemoteAPI() -> MoviesRemoteAPI {
        DefaultMoviesRemoteAPI()
    }
    
}
