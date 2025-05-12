//
//  MoviesListView.swift
//  MoviesApp
//
//  Created by Khaled hashem on 11/05/2025.
//

import UIKit

class MoviesListView: NiblessView {
    
    // MARK: - Methods
    init() {
        super.init(frame: .zero)
        styleView()
    }
    
    private func styleView() {
        backgroundColor = .white
    }
}
