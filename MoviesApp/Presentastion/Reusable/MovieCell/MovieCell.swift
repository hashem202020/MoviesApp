//
//  MovieCell.swift
//  MoviesApp
//
//  Created by Khaled hashem on 12/05/2025.
//

import UIKit
import Kingfisher

final public class MovieCell: UITableViewCell {
    // MARK: - Properties
    @IBOutlet private(set) public weak var thumbnailImage: UIImageView!
    @IBOutlet private(set) public weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 0
        }
    }
    @IBOutlet private(set) public weak var overviewLabel: UILabel! {
        didSet {
            overviewLabel.numberOfLines = 3
        }
    }
    @IBOutlet private(set) public weak var watchlistIcon: UIImageView! {
        didSet {
            watchlistIcon.image = nil
        }
    }
    
    private(set) public var movieId: Int?
    
    // MARK: - Methods
    public func configure(with item: MoviePresentationModel) {
        self.movieId = item.id
        thumbnailImage.kf.setImage(with: item.thumbnail.isEmpty ? nil : URL(string: item.thumbnail), placeholder: .none)
        titleLabel.text = item.title
        overviewLabel.text = item.overview
    }
}
