//
//  GetMovieDetailsUseCase.swift
//  MoviesApp
//
//  Created by Khaled hashem on 13/05/2025.
//

import Foundation

public protocol GetMovieDetailsUseCase {
    func execute(with id: Int) async throws -> Movie
}

final public class DefaultGetMovieDetailsUseCase: GetMovieDetailsUseCase {
    // MARK: - Properties
    let movieDetailsRepository: MovieDetailsRepository
    
    // MARK: - Methods
    init(movieDetailsRepository: MovieDetailsRepository) {
        self.movieDetailsRepository = movieDetailsRepository
    }
    
    public func execute(with id: Int) async throws -> Movie {
        try await movieDetailsRepository.fetchMovieDetails(id: id)
    }
}
