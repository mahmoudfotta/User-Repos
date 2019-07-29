//
//  ViewController.swift
//  UserRepos
//
//  Created by Mahmoud Abolfotoh on 7/26/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import UIKit

class UserReposController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var dataSource = RepoTableDataSource()
    let delegate = RepoTableDelegate()
    let loadingController = LoadingController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        add(loadingController)
        
        handleDataSourceDataChanged()
        handleCellTapped()
    }
    
    func setupTableView() {
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableView.register(RepoCell.self, forCellReuseIdentifier: RepoCell.reuseIdentifier)
    }
    
    func handleDataSourceDataChanged() {
        dataSource.dataChanged = { [weak self] isChanged in
            self?.loadingController.remove()
            if isChanged {
                self?.title = self?.dataSource.repoOwnerName()
                self?.tableView.reloadData()
            }
        }
    }
    
    func handleCellTapped() {
        delegate.cellTapped = { [weak self] indexPath in
            let repo = self?.dataSource.repo(at: indexPath)
            let repoWebController = RepoWebController()
            repoWebController.repo = repo
            self?.navigationController?.pushViewController(repoWebController, animated: true)
        }
    }
}
