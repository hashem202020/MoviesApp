//
//  SearchViewModel.swift
//  MoviesApp
//
//  Created by Khaled hashem on 12/05/2025.
//

import Foundation
import Combine

final class SearchViewModel {
    // MARK: - Properties
    private let getSearchMoviesUseCase: GetSearchMoviesUseCase
    private let homeCoordinator: HomeCoordinator
    private var nextPage = 1
    private var canLoadMore = true

    @Published public private(set) var searchResults: [MoviePresentationModel] = []

    public let searchTextSubject = CurrentValueSubject<String?, Never>(nil)
    public let currentDisplayedItemSubject = PassthroughSubject<Int, Never>()
    public let selectItemSubject = PassthroughSubject<Int, Never>()

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Methods
    init(getSearchMoviesUseCase: GetSearchMoviesUseCase,
         homeCoordinator: HomeCoordinator) {
        self.getSearchMoviesUseCase = getSearchMoviesUseCase
        self.homeCoordinator = homeCoordinator
        bind()
    }
    
    private func bind() {
        searchTextSubject
            .compactMap { $0 }
            .removeDuplicates()
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink { [weak self] keyword in
                guard let self = self else { return }
                self.searchResults = []
                self.nextPage = 1
                self.canLoadMore = true
                if !keyword.isEmpty {
                    self.loadMovies(with: keyword)
                }
            }
            .store(in: &cancellables)

        currentDisplayedItemSubject
            .filter { [weak self] index in
                guard let self else { return false }
                return (self.searchResults.count - 2) == index && self.canLoadMore
            }
            .sink { [weak self] _ in
                guard let self, let keyword = self.searchTextSubject.value else { return }
                self.loadMovies(with: keyword)
            }
            .store(in: &cancellables)

        selectItemSubject
            .sink { [weak self] index in
                guard let self else { return }
                self.homeCoordinator.openMovieDetails(id: self.searchResults[index].id)
            }
            .store(in: &cancellables)
    }

    private func loadMovies(with keyword: String) {
        Task {
            do {
                let result = try await getSearchMoviesUseCase.execute(with: keyword, page: nextPage)
                let mapped = result.map(MoviePresentationModel.init)
                await MainActor.run {
                    self.searchResults += mapped
                    self.canLoadMore = !mapped.isEmpty
                    self.nextPage += 1
                }
            } catch {}
        }
    }
}
