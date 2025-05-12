//
//  MoviesListViewController.swift
//  MoviesApp
//
//  Created by Khaled hashem on 11/05/2025.
//

import SnapKit

public class MoviesListViewController: NiblessViewController {
    // MARK: - Properties
    private let customView: MoviesListView
    
    private let popularMoviesViewController: PopularMoviesViewController

    // MARK: - Methods
    init(customView: MoviesListView, popularMoviesViewController: PopularMoviesViewController) {
        self.customView = customView
        self.popularMoviesViewController = popularMoviesViewController
        super.init()
    }

    public override func loadView() {
        view = customView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies App"
        addChild(popularMoviesViewController)
        popularMoviesViewController.didMove(toParent: self)
        view.addSubview(popularMoviesViewController.view)
        view.bringSubviewToFront(popularMoviesViewController.view)

        popularMoviesViewController.view.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
