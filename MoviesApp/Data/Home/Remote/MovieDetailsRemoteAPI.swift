//
//  MovieDetailsRemoteAPI.swift
//  MoviesApp
//
//  Created by Khaled hashem on 13/05/2025.
//

import Foundation

public protocol MovieDetailsRemoteAPI: RemoteAPI {
    func fetchMovieDetails(id: Int) async throws -> MovieDTO
    func fetchSimilarMovies(to id: Int, page: Int) async throws -> PaginationResponse<MovieDTO>
    func getCast(for id: Int) async throws -> CreditsResponse
}

public final class DefaultMovieDetailsRemoteAPI: MovieDetailsRemoteAPI {
    public func fetchMovieDetails(id: Int) async throws -> MovieDTO {
        try await request(endPoint: "movie/\(id)", method: .get)
    }
    
    public func fetchSimilarMovies(to id: Int, page: Int) async throws -> PaginationResponse<MovieDTO> {
        try await request(endPoint: "movie/\(id)/similar",
                          method: .get,
                          parameters: ["page": page])

    }
    
    public func getCast(for id: Int) async throws -> CreditsResponse {
        try await request(endPoint: "movie/\(id)/credits",
                          method: .get)

    }
}
