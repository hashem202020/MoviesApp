//
//  PopularMoviesViewModel.swift
//  MoviesApp
//
//  Created by Khaled hashem on 12/05/2025.
//

import Foundation

final class PopularMoviesViewModel {
    // MARK: - Properties
    private let getPopularMoviesUseCase: GetPopularMoviesUseCase
    @Published var movies: [MoviePresentationModel] = []

    // MARK: - Methods
    init(getPopularMoviesUseCase: GetPopularMoviesUseCase) {
        self.getPopularMoviesUseCase = getPopularMoviesUseCase
    }
    
    func fetchMovies() {
        Task {
            do {
                let result = try await getPopularMoviesUseCase.execute(with: 1)
                await MainActor.run {
                    movies = result.map(MoviePresentationModel.init)
                }
            } catch {
                
            }
        }
    }
}

