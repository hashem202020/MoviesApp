//
//  ImageAndLabelCollectionViewCell.swift
//  AppUIKit
//
//  Created by Khaled hashem on 26/04/2022.
//

import UIKit
import Kingfisher

final public class ImageAndLabelCollectionViewCell: UICollectionViewCell {

    @IBOutlet private(set) public weak var thumbnailImage: UIImageView!
    @IBOutlet private(set) public weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 2
        }
    }

    public func configure(with item: MoviePresentationModel) {
        thumbnailImage.kf.setImage(with: item.thumbnail.isEmpty ? nil : URL(string: item.thumbnail), placeholder: UIImage(named: "moviePoster"))
        titleLabel.text = item.title
    }
    
    public func configure(with item: CastMemberPresentationModel) {
        thumbnailImage.kf.setImage(with: item.profile.isEmpty ? nil : URL(string: item.profile), placeholder: UIImage(named: "moviePoster"))
        titleLabel.text = item.name
    }
}
