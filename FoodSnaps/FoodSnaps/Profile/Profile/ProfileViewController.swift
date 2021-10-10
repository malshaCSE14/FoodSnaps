//
//  ProfileViewController.swift
//  FoodSnaps
//
//  Created by Malsha Hansini on 26/09/2021.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        configUI()
    }
    
    private func configUI() {
        configProfilePic()
        configCollectionView()
        configureSegmentedControl()
    }
    
    private func configProfilePic() {
        imgProfilePic.layer.cornerRadius = 50
        imgProfilePic.layer.borderWidth = 2
        imgProfilePic.layer.borderColor = UIColor.init(named: "avatarBorder")?.cgColor
        imgProfilePic.layer.masksToBounds = true
    }
    
    private func configureSegmentedControl() {
        segmentedControl.selectedSegmentIndex = 0
    }
    
    private func configCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        let screenWidth = UIScreen.main.bounds.width - 30
        layout.itemSize = CGSize(width: screenWidth / 2, height: screenWidth / 2)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        collectionView.collectionViewLayout = layout
        let nib = UINib(nibName: SnapCollectionViewCell.cellIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: SnapCollectionViewCell.cellIdentifier)
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SnapCollectionViewCell.cellIdentifier, for: indexPath) as! SnapCollectionViewCell
        cell.layer.cornerRadius = 10
        return cell
    }
}
