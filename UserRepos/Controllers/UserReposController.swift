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
    let loadingController = LoadingController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        add(loadingController)
        
        dataSource.dataChanged = { [weak self] isChanged in
            self?.loadingController.remove()
            if isChanged {
                self?.title = self?.dataSource.repoOwnerName()
                self?.tableView.reloadData()
            }
        }
    }
    
    func setupTableView() {
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.register(RepoCell.self, forCellReuseIdentifier: RepoCell.reuseIdentifier)
    }
}

extension UserReposController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = dataSource.repo(at: indexPath)
        let repoWebController = RepoWebController()
        repoWebController.repo = repo
        navigationController?.pushViewController(repoWebController, animated: true)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
