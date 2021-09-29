//
//  SnapCollectionViewCell.swift
//  FoodSnaps
//
//  Created by Malsha Hansini on 29/09/2021.
//

import UIKit

class SnapCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var icon: UIImageView!
    static let cellIdentifier = "SnapCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
