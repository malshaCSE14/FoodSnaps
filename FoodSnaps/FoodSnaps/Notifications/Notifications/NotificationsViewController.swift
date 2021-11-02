//
//  NotificationsViewController.swift
//  FoodSnaps
//
//  Created by Malsha Hansini on 26/09/2021.
//

import UIKit
import RxSwift
import RxCocoa

class NotificationsViewController: UIViewController, UITableViewDelegate {
    // MARK: IB outlets
    @IBOutlet weak var tblNotifications: UITableView!
    @IBOutlet weak var tblNotificationsHeight: NSLayoutConstraint!
    
    // MARK: Rx variables
    private let disposeBag = DisposeBag()
    
    // MARK: Properties
    private let viewModel = NotificationsViewModel()
    private let estimatedRowHeight = 74.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
        viewModel.paginator = Paginator<String>(provider: viewModel)
        configPagination()
        bindData()
    }
    
    private func configTable() {
        let nib = UINib(nibName: NotificationsTableViewCell.cellIdentifier, bundle: nil)
        tblNotifications.delegate = self
        tblNotifications.register(nib, forCellReuseIdentifier: NotificationsTableViewCell.cellIdentifier)
        tblNotifications.rowHeight = UITableView.automaticDimension
        tblNotifications.estimatedRowHeight = CGFloat(self.estimatedRowHeight)
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
        
        tblNotifications.reachedBottom
            .bind(to: viewModel.paginator!.loadNextPageTrigger).disposed(by: disposeBag)
    }
    
    private func bindData() {
        let activity1 = ActivityItem(id: "1", activityDescription: "started following you", name: "Yasiru Priyadarshana", time: "1d")
        let activity2 = ActivityItem(id: "2", activityDescription: "started following you 1d Yasiru Priyadarshana started following you", name: "Yasiru Priyadarshana", time: "1d")
        let activity3 = ActivityItem(id: "3", postImageUrl: "aa", activityDescription: "liked your photo", name: "Yasiru Priyadarshana", time: "11min")
        let elements = [activity1, activity2, activity3, activity1, activity2, activity3, activity1, activity2, activity3, activity1, activity2, activity3]
        Observable.just(elements).bind(to: tblNotifications.rx.items) { tableView, row, element in
            tableView.invalidateIntrinsicContentSize()
            tableView.layoutIfNeeded()
            let indexPath = IndexPath(row: row, section: 0)
            if indexPath.row == 0 {
                let cell = UITableViewCell()
                cell.textLabel?.text = "Your activities"
                cell.accessoryType = .disclosureIndicator
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier:  NotificationsTableViewCell.cellIdentifier, for: indexPath) as! NotificationsTableViewCell
                cell.layoutIfNeeded()
                cell.set(name: element.name ?? "",
                         nameRange: NSRange(location: element.nameStartingLocation ?? 0,
                                            length: element.name?.count ?? 0),
                         descriptionText: element.activityDescription ?? "",
                         time: element.time ?? "",
                         timeRange: NSRange(location: (element.name?.count ?? 0) + (element.activityDescription?.count ?? 0) + 2,
                                            length: element.time?.count ?? 0), imageUrl: element.postImageUrl)
                return cell
            }
        }.disposed(by: disposeBag)
        
        
        //        tblNotifications.rx
        //            .observe(CGSize.self, "contentSize")
        //            .distinctUntilChanged()
        //            .observe(on: MainScheduler.instance)
        //            .subscribe(onNext: { [weak self] size in
        //                if (size?.height ?? 0.0) > 0 {
        //                    self?.tblNotificationsHeight.constant = (size?.height ?? 0) - 5
        //                }
        //            }).disposed(by: disposeBag)
    }
}
