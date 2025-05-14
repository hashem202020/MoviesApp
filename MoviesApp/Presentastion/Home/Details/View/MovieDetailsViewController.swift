//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by Khaled hashem on 13/05/2025.
//

import UIKit
import Combine

public final class MovieDetailsViewController: NiblessViewController {
    
    // MARK: - Properties
    private let customView: MovieDetailsView
    private let viewModel: MovieDetailsViewModel
    
    private var cancellables = Set<AnyCancellable>()

    init(customView: MovieDetailsView,
         viewModel: MovieDetailsViewModel) {
        self.customView = customView
        self.viewModel = viewModel
        super.init()
    }

    public override func loadView() {
        view = customView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        customView.tableView.dataSource = self
        subscribe()
    }
    
    private func subscribe() {
        viewModel.$movieDetails
            .receive(on: DispatchQueue.main)
            .sink { [weak self] details in
                self?.customView.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}

extension MovieDetailsViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.movieDetails.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // Each section has one item (MovieDetail)
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.movieDetails[section].title
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = viewModel.movieDetails[indexPath.section]

        switch element {
        case .movie(let movie):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailsCell", for: indexPath) as? MovieDetailsCell else {
                return UITableViewCell()
            }

            cell.configure(with: movie)
            cell.watchlistButton.addTarget(self.viewModel, action: #selector(MovieDetailsViewModel.toggleWatchlist), for: .touchUpInside)
            return cell

        case .similar(let movies):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HorizontalMoviesListCell", for: indexPath) as? HorizontalMoviesListCell else {
                return UITableViewCell()
            }

            cell.configure(with: movies)
            return cell

        case .directors(let castMembers), .actors(let castMembers):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HorizontalCastMembersListCell", for: indexPath) as? HorizontalCastMembersListCell else {
                return UITableViewCell()
            }

            cell.configure(with: castMembers)
            return cell
        }
    }
}
