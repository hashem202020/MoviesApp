//
//  MoviesListView.swift
//  MoviesApp
//
//  Created by Khaled hashem on 11/05/2025.
//

import UIKit

class MoviesListView: NiblessView {
    // MARK: - Properties
    lazy private(set) var searchController = UISearchController(searchResultsController: searchResultsController).with {
        $0.searchBar.placeholder = "Type name of the movie"
        $0.searchResultsUpdater = searchResultsController as? UISearchResultsUpdating
    }

    private let searchResultsController: UIViewController?

    // MARK: - Methods
    init(searchResultsController: UIViewController?) {
        self.searchResultsController = searchResultsController
        super.init(frame: .zero)
        styleView()
    }
    
    private func styleView() {
        backgroundColor = .white
    }
}
