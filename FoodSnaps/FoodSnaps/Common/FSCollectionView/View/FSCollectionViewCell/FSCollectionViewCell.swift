//
//  FSCollectionViewCell.swift
//  FoodSnaps
//
//  Created by Malsha Hansini on 09/10/2021.
//

import UIKit

class FSCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var captionLabel: UILabel!
    @IBOutlet private weak var commentLabel: UILabel!
    @IBOutlet weak var rightIcon: UIImageView!
    @IBOutlet weak var profilePic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        profilePic.layer.cornerRadius = 10
    }
    
    var photo: Photo? {
        didSet {
            if let photo = photo {
                imageView.image = photo.image
                captionLabel.text = photo.caption
            }
        }
    }
}
