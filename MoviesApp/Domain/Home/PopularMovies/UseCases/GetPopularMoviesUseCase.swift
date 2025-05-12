//
//  GetPopularMoviesUseCase.swift
//  MoviesApp
//
//  Created by Khaled hashem on 12/05/2025.
//

import Foundation

public protocol GetPopularMoviesUseCase {
    func execute(with page: Int) async throws -> [Movie]
}

final public class DefaultGetPopularMoviesUseCase: GetPopularMoviesUseCase {
    // MARK: - Properties
    let movieListRepository: MoviesListRepository
    
    // MARK: - Methods
    init(movieListRepository: MoviesListRepository) {
        self.movieListRepository = movieListRepository
    }
    
    public func execute(with page: Int) async throws -> [Movie] {
        try await movieListRepository.fetchPopularMovies(page: page)
    }
}
