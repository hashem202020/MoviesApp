//
//  HorizontalCastMembersListCell.swift
//  AppUIKit
//
//  Created by Khaled hashem on 26/04/2022.
//

import UIKit

final public class HorizontalCastMembersListCell: UITableViewCell {

    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        let space = 10 as CGFloat
        flowLayout.itemSize = CGSize(width: 120, height: 220)
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }()
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.setCollectionViewLayout(flowLayout, animated: false)
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            collectionView.dataSource = self
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.register(UINib(nibName: "ImageAndLabelCollection", bundle: nil), forCellWithReuseIdentifier: "ImageAndLabelCollection")
        }
    }
    
    private var items = [CastMemberPresentationModel]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    
    public func configure(with items: [CastMemberPresentationModel]) {
        self.items = items
    }
}

extension HorizontalCastMembersListCell: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageAndLabelCollection", for: indexPath) as? ImageAndLabelCollectionViewCell else { return UICollectionViewCell() }

        cell.configure(with: items[indexPath.item])
        return cell
    }
}
