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
                imageView.image = resizeImage(image: photo.image)
                captionLabel.text = photo.caption
            }
        }
    }
    
    func resizeImage(image: UIImage) -> UIImage? {
        let size = image.size
        
        let widthRatio  = containerView.frame.width  / size.width
//        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
//        if(widthRatio > heightRatio) {
//            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
//        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
//        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
