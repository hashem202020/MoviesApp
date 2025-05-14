//
//  SearchViewController.swift
//  MoviesApp
//
//  Created by Khaled hashem on 12/05/2025.
//

import UIKit
import Combine

public class SearchViewController: NiblessViewController {
    private let viewModel: SearchViewModel
    private let customView: SearchView
    private var cancellables = Set<AnyCancellable>()

    init(view: SearchView, viewModel: SearchViewModel) {
        self.viewModel = viewModel
        self.customView = view
        super.init()
    }

    public override func loadView() {
        view = customView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        customView.tableView.dataSource = self
        customView.tableView.delegate = self

        bindViewModel()
    }

    private func bindViewModel() {
        viewModel.$searchResults
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.customView.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}

extension SearchViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResults.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }

        let item = viewModel.searchResults[indexPath.row]
        cell.configure(with: item)
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.currentDisplayedItemSubject.send(indexPath.row)
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectItemSubject.send(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchTextSubject.send(searchController.searchBar.text)
    }
}
