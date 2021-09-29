//
//  LikesViewController.swift
//  FoodSnaps
//
//  Created by Malsha Hansini on 26/09/2021.
//

import UIKit
import RxSwift
import RxCocoa

class LikesViewController: UIViewController {
    @IBOutlet weak var tblLikes: UITableView!
    @IBOutlet weak var tblLikesHeight: NSLayoutConstraint!
    
    // MARK: Rx variables
    private let disposeBag = DisposeBag()
    
    // MARK: Properties
    private let estimatedRowHeight = 74.0

    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
        bindData()
    }
    
    private func configTable() {
        let nib = UINib(nibName: LikesTableViewCell.cellIdentifier, bundle: nil)
        tblLikes.register(nib, forCellReuseIdentifier: LikesTableViewCell.cellIdentifier)
        tblLikes.rowHeight = UITableView.automaticDimension
        tblLikes.estimatedRowHeight = CGFloat(self.estimatedRowHeight)
    }
    
    private func bindData() {
        let activity1 = ActivityItem(id: "1")
        let activity2 = ActivityItem(id: "2")
        let activity3 = ActivityItem(id: "3")
        let elements = [activity1, activity2, activity3, activity1, activity2, activity3, activity1, activity2, activity3, activity1, activity2, activity3]
        Observable.just(elements).bind(to: tblLikes.rx.items) { tableView, row, _ in
            let indexPath = IndexPath(row: row, section: 0)
            let cell = tableView.dequeueReusableCell(withIdentifier:  LikesTableViewCell.cellIdentifier, for: indexPath) as! LikesTableViewCell
            cell.layoutIfNeeded()
            cell.set(descriptionText: "Yasiru Priyadarshana started following you 1d Yasiru Priyadarshana started following you 1d ")
            return cell
        }.disposed(by: disposeBag)
        
        
//        tblLikes.rx
//            .observe(CGSize.self, "contentSize")
//            .distinctUntilChanged()
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: { [weak self] size in
//                if (size?.height ?? 0.0) > 0 {
//                    self?.tblLikesHeight.constant = (size?.height ?? 0) - 5
//                }
//            }).disposed(by: disposeBag)
    }
}
