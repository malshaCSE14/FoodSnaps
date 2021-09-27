//
//  ProfileViewController.swift
//  FoodSnaps
//
//  Created by Malsha Hansini on 26/09/2021.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var imgProfilePic: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        configUI()
    }
    
    private func configUI() {
        configProfilePic()
    }
    
    private func configProfilePic() {
        imgProfilePic.layer.cornerRadius = 40
        imgProfilePic.layer.borderWidth = 2
        imgProfilePic.layer.borderColor = UIColor.init(named: "avatarBorder")?.cgColor
        imgProfilePic.layer.masksToBounds = true
    }
}
