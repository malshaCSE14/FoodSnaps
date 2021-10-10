//
//  PreviewViewController.swift
//  FoodSnaps
//
//  Created by Malsha Hansini on 09/10/2021.
//

import UIKit
import RxSwift
import RxCocoa

class PreviewViewController: UIViewController {
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionView: TwoColumnCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        bindUI()
    }
    
    private func configUI() {
        let ratio = (image.image?.size.width ?? 0) / (image.image?.size.height ?? 1)
        let newHeight = image.frame.width / ratio
        imageViewHeight.constant = newHeight
        image.layoutIfNeeded()
        
        profilePic.layer.cornerRadius = 20
        
        view.bringSubviewToFront(btnBack)
    }
    
    private func bindUI() {
//        collectionViewHeight.constant = collectionView.collectionView.contentSize.height
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
