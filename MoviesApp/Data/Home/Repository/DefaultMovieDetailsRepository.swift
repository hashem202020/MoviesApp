//
//  DefaultMovieDetailsRepository.swift
//  MoviesApp
//
//  Created by Khaled hashem on 13/05/2025.
//

import Foundation

public final class DefaultMovieDetailsRepository: MovieDetailsRepository {
    // MARK: - Properties
    let moviesDetailsRemoteAPI: MovieDetailsRemoteAPI
    
    // MARK: - Methods
    init(moviesDetailsRemoteAPI: MovieDetailsRemoteAPI) {
        self.moviesDetailsRemoteAPI = moviesDetailsRemoteAPI
    }
    
    public func fetchMovieDetails(id: Int) async throws -> Movie {
        let response = try await moviesDetailsRemoteAPI.fetchMovieDetails(id: id)
        let movieDetails = response.toDomain()
        return movieDetails
    }
    
    public func fetchSimilarMovies(to id: Int, page: Int) async throws -> [Movie] {
        let response = try await moviesDetailsRemoteAPI.fetchSimilarMovies(to: id, page: page)
        let moviesList = response.results?.map { $0.toDomain() } ?? []
        return moviesList
    }
    
    public func getCast(for id: Int) async throws -> [CastMember] {
        let response = try await moviesDetailsRemoteAPI.getCast(for: id)
        let cast = response.cast.map { $0.toDomain() }
        return cast
    }
    
}
