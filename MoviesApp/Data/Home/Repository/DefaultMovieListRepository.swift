//
//  DefaultMovieListRepository.swift
//  MoviesApp
//
//  Created by Khaled hashem on 12/05/2025.
//

public final class DefaultMovieListRepository: MoviesListRepository {
    // MARK: - Properties
    let moviesRemoteAPI: MoviesRemoteAPI
    
    // MARK: - Methods
    init(moviesRemoteAPI: MoviesRemoteAPI) {
        self.moviesRemoteAPI = moviesRemoteAPI
    }
    
    public func fetchPopularMovies(page: Int) async throws -> [Movie] {
        let response = try await moviesRemoteAPI.fetchPopularMovies(page: page)
        let moviesList = response.results?.map { $0.toDomain() } ?? []
        return moviesList
    }
}
