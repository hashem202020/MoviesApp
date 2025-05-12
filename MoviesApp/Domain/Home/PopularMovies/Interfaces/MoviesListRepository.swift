//
//  MoviesListRepository.swift
//  MoviesApp
//
//  Created by Khaled hashem on 12/05/2025.
//

public protocol MoviesListRepository {
    func fetchPopularMovies(page: Int) async throws -> [Movie]
}
