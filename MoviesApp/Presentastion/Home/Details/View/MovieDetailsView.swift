//
//  MovieDetailsView.swift
//  MoviesApp
//
//  Created by Khaled hashem on 13/05/2025.
//

import UIKit

class MovieDetailsView: NiblessView {
 
    // MARK: - Properties
    let tableView = UITableView().with {
        $0.register(UINib(nibName: "MovieDetailsCell", bundle: nil), forCellReuseIdentifier: "MovieDetailsCell")
        $0.register(UINib(nibName: "HorizontalMoviesListCell", bundle: nil), forCellReuseIdentifier: "HorizontalMoviesListCell")
        $0.register(UINib(nibName: "HorizontalCastMembersListCell", bundle: nil), forCellReuseIdentifier: "HorizontalCastMembersListCell")
        $0.backgroundColor = .clear
        $0.backgroundView = nil
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 600
        $0.separatorStyle = .none
        $0.contentInsetAdjustmentBehavior = .never
        $0.automaticallyAdjustsScrollIndicatorInsets = false
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 10) + 10, right: 0)
        $0.tableFooterView = UIView()
    }

    // MARK: - Methods
    init() {
        super.init(frame: .zero)
        constructHierarchy()
        activateConstraints()
        styleView()
    }
    
    private func constructHierarchy() {
        addSubview(tableView)
    }

    private func activateConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }

    private func styleView() {
        backgroundColor = .white
    }
}

