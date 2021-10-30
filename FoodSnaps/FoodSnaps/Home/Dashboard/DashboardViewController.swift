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
    // MARK: - Properties
    var viewModel: DashboardViewModel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: TwoColumnCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.white.cgColor
        collectionView.delegate = self
    }
}

extension DashboardViewController: FSPresentDelegate {
    func presentDetailView() {
        let previewView = PreviewViewController(nibName: "PreviewViewController", bundle: nil)
        self.navigationController?.pushViewController(previewView, animated: true)
    }
}
