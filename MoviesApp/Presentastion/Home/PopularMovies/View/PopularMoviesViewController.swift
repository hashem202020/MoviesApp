//
//  PopularMoviesViewController.swift
//  MoviesApp
//
//  Created by Khaled hashem on 12/05/2025.
//

import UIKit
import Combine

final class PopularMoviesViewController: NiblessViewController {
    
    // MARK: - Properties
    private let customView: PopularMoviesView
    private let viewModel: PopularMoviesViewModel
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Methods
    init(customView: PopularMoviesView,
         viewModel: PopularMoviesViewModel) {
        self.customView = customView
        self.viewModel = viewModel
        super.init()
    }
    
    override func loadView() {
        view = customView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchMovies()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.tableView.dataSource = self
        customView.tableView.delegate = self
        
        subscribeForMovies()
    }
    
    func subscribeForMovies() {
        viewModel.$movies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.customView.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}

extension PopularMoviesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { 1 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }

        let item = viewModel.movies[indexPath.row]
        cell.configure(with: item)
        return cell
    }
}

extension PopularMoviesViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectItemSubject.send(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
