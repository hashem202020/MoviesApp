//
//  MovieDetailsViewModel.swift
//  MoviesApp
//
//  Created by Khaled hashem on 13/05/2025.
//

import Foundation

public final class MovieDetailsViewModel: ObservableObject {

    // MARK: - Properties

    private let getMovieDetailsUseCase: GetMovieDetailsUseCase
    private let getSimilarMoviesUseCase: GetSimilarMoviesUseCase
    private let getMovieCastUseCase: GetMovieCastUseCase
    private let watchlistManager = WatchlistManager.shared
    private let id: Int

    @Published public var movieDetails: [MovieDetail] = []

    // MARK: - Methods

    public init(withId id: Int,
                getMovieDetailsUseCase: GetMovieDetailsUseCase,
                getSimilarMoviesUseCase: GetSimilarMoviesUseCase,
                getMovieCastUseCase: GetMovieCastUseCase
    ) {
        self.id = id
        self.getMovieDetailsUseCase = getMovieDetailsUseCase
        self.getSimilarMoviesUseCase = getSimilarMoviesUseCase
        self.getMovieCastUseCase = getMovieCastUseCase
        
        getMovieDetails()
        getSimilarMovies()
    }

    private func getMovieDetails() {
        Task {
            do {
                let result = try await getMovieDetailsUseCase.execute(with: id)
                
                let presentable = MovieDetailsPresentationModel(movie: result)
                await MainActor.run {
                    self.movieDetails.append(.movie(presentable))
                    movieDetails = movieDetails.sorted(by: { $0.index < $1.index })
                }
            } catch {}
        }
    }
    private func getSimilarMovies() {
        Task {
            do {
                // Fetch and map similar movies
                let similarMovies = try await getSimilarMoviesUseCase.execute(with: id, page: 1)
                let topFiveMovies = Array(similarMovies.prefix(5))
                let presentables = topFiveMovies.compactMap(MoviePresentationModel.init)

                await MainActor.run {
                    self.movieDetails.append(.similar(presentables))
                }

                // Fetch casts for each similar movie
                let castLists = try await withThrowingTaskGroup(of: [CastMember].self) { group in
                    for movie in presentables {
                        group.addTask {
                            try await self.getMovieCastUseCase.execute(with: movie.id)
                        }
                    }

                    var allCasts: [[CastMember]] = []
                    for try await cast in group {
                        allCasts.append(cast)
                    }

                    return allCasts
                }

                let combinedCast = castLists.flatMap { $0 }

                let grouped = Dictionary(grouping: combinedCast) {
                    $0.knownForDepartment ?? ""
                }

                await MainActor.run {
                    if let actors = grouped["Acting"]?
                        .sorted(by: { ($0.popularity ?? 0) > ($1.popularity ?? 0) })
                        .prefix(5) {
                        self.movieDetails.append(.actors(actors.compactMap(CastMemberPresentationModel.init)))
                    }

                    if let directors = grouped["Directing"]?
                        .sorted(by: { ($0.popularity ?? 0) > ($1.popularity ?? 0) })
                        .prefix(5) {
                        self.movieDetails.append(.directors(directors.compactMap(CastMemberPresentationModel.init)))
                    }
                    movieDetails = movieDetails.sorted(by: { $0.index < $1.index })
                }

            } catch { }
        }
    }

    // MARK: - Actions

    @objc
    public func toggleWatchlist() {
        
        if let index = self.movieDetails.firstIndex(where: {
            if case .movie = $0 { return true }
            return false
        }) {
            if case .movie(var movie) = self.movieDetails.remove(at: index) {
                movie.isInWatchlist = watchlistManager.toggle(id: id)
                self.movieDetails.insert(.movie(movie), at: index)
            }
        }
    }
}
