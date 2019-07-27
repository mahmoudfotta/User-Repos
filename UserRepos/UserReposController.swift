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
    let repoApiManager = RepoAPIManager()
    var repos = [Repo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchRepos()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.register(RepoCell.self, forCellReuseIdentifier: RepoCell.reuseIdentifier)
    }
    
    func fetchRepos() {
        repoApiManager.fetchUserRepos {[weak self] (result: Result<[Repo], APIService.APIError>) in
            switch result {
            case let .success(repos):
                self?.repos = repos
                self?.title = repos.first?.owner.name
                self?.tableView.reloadData()
            case let .failure(error):
                print(error)
            }
        }
    }
}

extension UserReposController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.reuseIdentifier, for: indexPath) as? RepoCell else {
            fatalError("Couldn't deque new repo cell")
        }
        let repo = repos[indexPath.row]
        cell.titleLabel.text = repo.name
        cell.descriptionLabel.text = repo.description
        cell.languageLabel.text = repo.language ?? ""
        cell.forksLabel.text = "\(repo.forksCount)"
        cell.dateLabel.text = repo.formmatedDate
        cell.userImageView.url = URL(string: repo.owner.avatarURL)
        return cell
    }
}
