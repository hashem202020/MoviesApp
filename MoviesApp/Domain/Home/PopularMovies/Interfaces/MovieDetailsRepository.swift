//
//  MovieDetailsRepository.swift
//  MoviesApp
//
//  Created by Khaled hashem on 13/05/2025.
//

import Foundation

public protocol MovieDetailsRepository {
    func fetchMovieDetails(id: Int) async throws -> Movie
    func fetchSimilarMovies(to id: Int, page: Int) async throws -> [Movie]
    func getCast(for id: Int) async throws -> [CastMember]
}
