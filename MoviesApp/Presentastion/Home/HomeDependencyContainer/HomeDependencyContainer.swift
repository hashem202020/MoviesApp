//
//  HomeDependencyContainer.swift
//  MoviesApp
//
//  Created by Khaled hashem on 11/05/2025.
//

import UIKit

protocol HomeDependencyContainer {
    func makeMoviesListView(navigationController: UINavigationController?) -> MoviesListViewController
    func makeMovieDetailsView(id: Int) -> MovieDetailsViewController
}

final class DefaultHomeDependencyContainer: HomeDependencyContainer {
    
    func makeMoviesListView(navigationController: UINavigationController?) -> MoviesListViewController {
        return MoviesListViewController(customView: MoviesListView(searchResultsController: makeSearchViewController(navigationController: navigationController)), popularMoviesViewController: makePopularMoviesViewController(navigationController: navigationController))
    }
    
    // MARK: popular
    
    private func makePopularMoviesViewController(navigationController: UINavigationController?) -> PopularMoviesViewController {
        PopularMoviesViewController(customView: PopularMoviesView(), viewModel: makePopularMoviesViewModel(navigationController: navigationController))
    }
    
    private func makePopularMoviesViewModel(navigationController: UINavigationController?) -> PopularMoviesViewModel {
        PopularMoviesViewModel(getPopularMoviesUseCase: makeGetPopularMoviesUseCase(), homeCoordinator: makeHomeCoordinator(navigationController: navigationController))
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
    
    //MARK: Search
    
    private func makeSearchViewController(navigationController: UINavigationController?) -> SearchViewController {
        SearchViewController(view: SearchView(), viewModel: makeSearchViewModel(navigationController: navigationController))
    }
    
    private func makeSearchViewModel(navigationController: UINavigationController?) -> SearchViewModel {
        SearchViewModel(getSearchMoviesUseCase: makeGetSearchMoviesUseCase(), homeCoordinator: makeHomeCoordinator(navigationController: navigationController))
    }
    
    private func makeGetSearchMoviesUseCase() -> GetSearchMoviesUseCase {
        DefaultGetSearchMoviesUseCase(movieListRepository: makeMoviesListRepository())
    }
        
    //MARK: Details
    
    func makeMovieDetailsView(id: Int) -> MovieDetailsViewController {
        MovieDetailsViewController(customView: MovieDetailsView(), viewModel: makeMovieDetailsViewModel(id: id))
    }
    
    private func makeMovieDetailsViewModel(id: Int) -> MovieDetailsViewModel {
        MovieDetailsViewModel(withId: id,
                              getMovieDetailsUseCase: makeGetMovieDetailsUseCase(), getSimilarMoviesUseCase: makeGetSimilarMoviesUseCase(), getMovieCastUseCase: makeGetMovieCastUseCase())
    }
    
    private func makeGetMovieDetailsUseCase() -> GetMovieDetailsUseCase {
        DefaultGetMovieDetailsUseCase(movieDetailsRepository: makeMovieDetailsRepository())
    }
    
    private func makeGetSimilarMoviesUseCase() -> GetSimilarMoviesUseCase {
        DefaultGetSimilarMoviesUseCase(movieDetailsRepository: makeMovieDetailsRepository())
    }
    
    private func makeGetMovieCastUseCase() -> GetMovieCastUseCase {
        DefaultGetMovieCastUseCase(movieDetailsRepository: makeMovieDetailsRepository())
    }
    
    private func makeMovieDetailsRepository() -> MovieDetailsRepository {
        DefaultMovieDetailsRepository(moviesDetailsRemoteAPI: makeMovieDetailsRemoteAPI())
    }
    
    private func makeMovieDetailsRemoteAPI() -> MovieDetailsRemoteAPI {
        DefaultMovieDetailsRemoteAPI()
    }
    
    //MARK: Coordinator
    private func makeHomeCoordinator(navigationController: UINavigationController?) -> HomeCoordinator {
        DefaultHomeCoordinator(navigationController: navigationController, homeDependencyContainer: self)
    }
    
}
