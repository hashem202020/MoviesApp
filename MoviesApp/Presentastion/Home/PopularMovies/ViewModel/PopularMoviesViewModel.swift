//
//  PopularMoviesViewModel.swift
//  MoviesApp
//
//  Created by Khaled hashem on 12/05/2025.
//

import Foundation
import Combine

final class PopularMoviesViewModel {
    // MARK: - Properties
    private let getPopularMoviesUseCase: GetPopularMoviesUseCase
    private let homeCoordinator: HomeCoordinator

    @Published var movies: [MoviePresentationModel] = []

    public let selectItemSubject = PassthroughSubject<Int, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Methods
    init(getPopularMoviesUseCase: GetPopularMoviesUseCase,
         homeCoordinator: HomeCoordinator) {
        self.getPopularMoviesUseCase = getPopularMoviesUseCase
        self.homeCoordinator = homeCoordinator
        bind()
    }
    
    func fetchMovies() {
        Task {
            do {
                let result = try await getPopularMoviesUseCase.execute(with: 1)
                await MainActor.run {
                    movies = result.map(MoviePresentationModel.init)
                }
            } catch {}
        }
    }
    
    private func bind() {
        selectItemSubject
            .sink { [weak self] index in
                guard let self else { return }
                self.homeCoordinator.openMovieDetails(id: self.movies[index].id)
            }
            .store(in: &cancellables)
    }
}
