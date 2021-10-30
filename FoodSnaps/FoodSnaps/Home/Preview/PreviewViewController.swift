//
//  PreviewViewController.swift
//  FoodSnaps
//
//  Created by Malsha Hansini on 09/10/2021.
//

import UIKit
import RxSwift

class PreviewViewController: UIViewController {
    // MARK: - Properties
    private var viewModel = PreviewViewModel()
    
    // MARK: - Rx variable
    private let disposeBag = DisposeBag()
    
    // MARK: IB Outlets
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionView: TwoColumnCollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        bindUI()
        viewModel.paginator = Paginator<String>(provider: viewModel)
        configPagination()
        collectionView.delegate = self
    }
    
    private func configUI() {
        let ratio = (image.image?.size.width ?? 0) / (image.image?.size.height ?? 1)
        let newHeight = UIScreen.main.bounds.width / ratio
        imageViewHeight.constant = newHeight
        image.layoutIfNeeded()
        
        profilePic.layer.cornerRadius = 20
        
        view.bringSubviewToFront(btnBack)
    }
    
    private func bindUI() {
        collectionView.collectionView.rx
            .observe(CGSize.self, "contentSize")
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] size in
                self?.collectionViewHeight.constant = size?.height ?? 0
            }).disposed(by: disposeBag)
    }
    
    // MARK: Pagination
    private func configPagination() {

//        self.refreshControl?.rx.controlEvent(.valueChanged)
//            .map { [weak self] _ in
//                self?.viewModel.paginator!.pageIndex = 0
//            }
//            .bind(to: viewModel.paginator!.refreshTrigger)
//            .disposed(by: disposeBag)
//
//        viewModel.paginator!.loading.asObservable()
//            .observeOn(MainScheduler.instance)
//            .subscribe(onNext: { [weak self] isLoading in
//                if !isLoading {
//                    self?.refreshControl?.endRefreshing()
//                }
//            }).disposed(by: disposeBag)

        scrollView.reachedBottom
            .bind(to: viewModel.paginator!.loadNextPageTrigger).disposed(by: disposeBag)
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension PreviewViewController: FSPresentDelegate {
    func presentDetailView() {
        let previewView = PreviewViewController(nibName: "PreviewViewController", bundle: nil)
        self.navigationController?.pushViewController(previewView, animated: true)
    }
}
