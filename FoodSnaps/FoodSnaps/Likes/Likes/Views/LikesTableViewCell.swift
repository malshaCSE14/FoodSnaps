//
//  LikesTableViewCell.swift
//  FoodSnaps
//
//  Created by Malsha Hansini on 29/09/2021.
//

import UIKit

class LikesTableViewCell: UITableViewCell {
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgPost: UIImageView!
    @IBOutlet weak var btnFollow: UIButton!
    
    static let cellIdentifier = "LikesTableViewCell"
    
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
    
    func set(descriptionText: String) {
        self.lblDescription.text = descriptionText
    }
}
