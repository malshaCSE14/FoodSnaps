//
//  SettingsViewController.swift
//  FoodSnaps
//
//  Created by Malsha Hansini on 17/10/2021.
//

import UIKit
import RxSwift
import RxCocoa

enum settings: String, CaseIterable {
//    case editProfilePic
//    case editUserName
    case editPassword = "Edit Password"
//    case editBio
    case logout = "Logout"
}

class SettingsViewController: UIViewController {
    // MARK: IB outlets
    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var tblSettings: UITableView!
    
    // MARK: Rx variables
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        self.navigationItem.title = "Settings"
        configNavBar()
        configUI()
        configTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configNavBar()
    }

    private func configNavBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
    
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func configUI() {
        appIcon.layer.cornerRadius = 20
    }
    
    private func configTable() {
        let elements = settings.allCases
        Observable.just(elements).bind(to: tblSettings.rx.items) { tableView, row, element in
            let cell = UITableViewCell()
            cell.imageView?.image = #imageLiteral(resourceName: "recipe")
            cell.textLabel?.text = element.rawValue
            cell.accessoryType = .disclosureIndicator
            return cell
        }.disposed(by: disposeBag)
        self.tblSettings.tableFooterView = UIView()
    }
}
