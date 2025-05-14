//
//  MoviesRemoteAPI.swift
//  MoviesApp
//
//  Created by Khaled hashem on 12/05/2025.
//

import Foundation

public protocol MoviesRemoteAPI: RemoteAPI {
    func fetchPopularMovies(page: Int) async throws -> PaginationResponse<MovieDTO>
    func searchMovies(with query: String, page: Int) async throws -> PaginationResponse<MovieDTO>
}

public final class DefaultMoviesRemoteAPI: MoviesRemoteAPI {
    public func fetchPopularMovies(page: Int) async throws -> PaginationResponse<MovieDTO> {
        try await request(endPoint: "movie/popular",
                          method: .get,
                          parameters: ["page": page])
    }
    
    public func searchMovies(with query: String, page: Int) async throws -> PaginationResponse<MovieDTO> {
        try await request(endPoint: "search/movie",
                          method: .get,
                          parameters: ["page": page,
                                       "query": query])

    }
}
