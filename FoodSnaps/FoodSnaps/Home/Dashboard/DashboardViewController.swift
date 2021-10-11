//
//  DashboardViewController.swift
//  FoodSnaps
//
//  Created by Malsha Hansini on 26/09/2021.
//

import UIKit
import RxSwift
import RxCocoa

class DashboardViewController: UIViewController {
    let previewView: PreviewViewController? = nil

    @IBOutlet weak var collectionView: TwoColumnCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
    }
}

extension DashboardViewController: FSPresentDelegate {
    func presentDetailView() {
        let previewView = PreviewViewController(nibName: "PreviewViewController", bundle: nil)
        self.navigationController?.pushViewController(previewView, animated: true)
    }
}
