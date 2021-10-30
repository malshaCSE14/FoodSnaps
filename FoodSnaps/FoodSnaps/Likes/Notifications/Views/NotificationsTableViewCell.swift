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
    @IBOutlet weak var btnFollow: UIButton!
    
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
        configLeftView()
    }
    
    private func configLeftView(follow: Bool = false) {
        btnFollow.isHidden = !follow
        imgPost.isHidden = follow
        imgProfilePic.layer.cornerRadius = 30
    }
    
    func set(name: String, nameRange: NSRange, descriptionText: String, time: String, timeRange: NSRange) {
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
    }
}
