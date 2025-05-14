//
//  MovieDetailsCell.swift
//  MoviesApp
//
//  Created by Khaled hashem on 14/05/2025.
//

import UIKit
import Kingfisher

final public class MovieDetailsCell: UITableViewCell {

    @IBOutlet private(set) public weak var thumbnailImage: UIImageView!
    @IBOutlet private(set) public weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 0
        }
    }
    @IBOutlet private(set) public weak var overviewLabel: UILabel! {
        didSet {
            overviewLabel.numberOfLines = 0
        }
    }
    @IBOutlet private(set) public weak var taglineLabel: UILabel!
    @IBOutlet private(set) public weak var revenueLabel: UILabel!
    @IBOutlet private(set) public weak var releaseDateLabel: UILabel!
    @IBOutlet private(set) public weak var statusLabel: UILabel!
    @IBOutlet private(set) public weak var watchlistButton: UIButton! {
        didSet {
            watchlistButton.setTitle("", for: .normal)
        }
    }
    
    public func configure(with item: MovieDetailsPresentationModel) {
        thumbnailImage.kf.setImage(with: item.thumbnail.isEmpty ? nil : URL(string: item.thumbnail), placeholder: UIImage(named: "moviePoster"))
        titleLabel.text = item.title
        overviewLabel.text = item.overview
        taglineLabel.text = item.tagline
        revenueLabel.text = item.revenue
        releaseDateLabel.text = item.releaseDate
        statusLabel.text = item.status
        watchlistButton.setImage(item.isInWatchlist ? UIImage(named: "bookmarkActive") : UIImage(named: "bookmark"), for: .normal)
    }
}
