//
//  NotificationsTableViewCell.swift
//  FoodSnaps
//
//  Created by Malsha Hansini on 29/09/2021.
//

import UIKit

class NotificationsTableViewCell: UITableViewCell {
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgPost: UIImageView!
    @IBOutlet weak var descriptionRightSpace: NSLayoutConstraint!
    
    static let cellIdentifier = "NotificationsTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nibSetup()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        nibSetup()
    }
    
    private func nibSetup() {
        imgProfilePic.layer.cornerRadius = 30
    }
    
    private func configRightView(imageUrl: String?) {
        if let url = imageUrl {
            imgPost.isHidden = false
        } else {
            imgPost.isHidden = true
        }
        descriptionRightSpace.constant = (imageUrl != nil) ? 85 : 15
    }
    
    func set(name: String, nameRange: NSRange, descriptionText: String, time: String, timeRange: NSRange, imageUrl: String?) {
        let attributedString = NSMutableAttributedString(string:name + " " + descriptionText + " " + time)
        let nameAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.boldBodyText.withSize(TextSize.body.rawValue)
        ]
        let timeAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.normalBodyText.withSize(TextSize.body.rawValue),
            NSAttributedString.Key.foregroundColor: UIColor.gray
        ]
        attributedString.addAttributes(nameAttributes as [NSAttributedString.Key: Any], range: nameRange)
        attributedString.addAttributes(timeAttributes as [NSAttributedString.Key: Any], range: timeRange)
        self.lblDescription.attributedText = attributedString
        configRightView(imageUrl: imageUrl)
    }
}
