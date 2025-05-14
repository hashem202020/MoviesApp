//
//  GetSearchMoviesUseCase.swift
//  MoviesApp
//
//  Created by Khaled hashem on 13/05/2025.
//

import Foundation
public protocol GetSearchMoviesUseCase {
    func execute(with query: String, page: Int) async throws -> [Movie]
}

final public class DefaultGetSearchMoviesUseCase: GetSearchMoviesUseCase {
    // MARK: - Properties
    let movieListRepository: MoviesListRepository
    
    // MARK: - Methods
    init(movieListRepository: MoviesListRepository) {
        self.movieListRepository = movieListRepository
    }
    
    public func execute(with query: String, page: Int) async throws -> [Movie] {
        try await movieListRepository.searchMovies(with: query, page: page)
    }
}
