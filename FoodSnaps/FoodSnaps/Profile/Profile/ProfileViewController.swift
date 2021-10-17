//
//  ProfileViewController.swift
//  FoodSnaps
//
//  Created by Malsha Hansini on 26/09/2021.
//

import UIKit
import RxSwift

class ProfileViewController: UIViewController {
    // MARK: Properties
    private let viewModel = ProfileViewModel()
    
    // MARK: - Rx variable
    private let disposeBag = DisposeBag()
    
    // MARK: IB outlets
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func configUI() {
        configProfilePic()
        configCollectionView()
        configureSegmentedControl()
        viewModel.paginator = Paginator<String>(provider: viewModel)
        configPagination()
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
    
    @IBAction func didTapSettings(_ sender: Any) {
        let settingsVC = SettingsViewController()
        self.navigationController?.pushViewController(settingsVC, animated: true)
//        self.present(settingsVC, animated: true, completion: nil)
    }
}
