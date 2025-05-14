//
//  GetSimilarMoviesUseCase.swift
//  MoviesApp
//
//  Created by Khaled hashem on 13/05/2025.
//

import Foundation

public protocol GetSimilarMoviesUseCase {
    func execute(with id: Int, page: Int) async throws -> [Movie]
}

final public class DefaultGetSimilarMoviesUseCase: GetSimilarMoviesUseCase {
    // MARK: - Properties
    let movieDetailsRepository: MovieDetailsRepository
    
    // MARK: - Methods
    init(movieDetailsRepository: MovieDetailsRepository) {
        self.movieDetailsRepository = movieDetailsRepository
    }
    
    public func execute(with id: Int, page: Int) async throws -> [Movie] {
        try await movieDetailsRepository.fetchSimilarMovies(to: id, page: page)
    }
}
