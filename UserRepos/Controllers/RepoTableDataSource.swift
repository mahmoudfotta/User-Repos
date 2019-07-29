//
//  RepoTableDataSource.swift
//  UserRepos
//
//  Created by Mahmoud Abolfotoh on 7/27/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import UIKit

class RepoTableDataSource: NSObject,  UITableViewDataSource {
    var repos = [Repo]()
    let repoApiManager = RepoAPIManager()
    var dataChanged: ((_ isSuccess: Bool) -> Void)?
    
    init(isTesting: Bool = false) {
        super.init()
        if !isTesting {
            fetchRepos()
        }
    }

    func fetchRepos() {
        repoApiManager.fetchUserRepos(for: ReposRoute.userRepos) {[weak self] (result: Result<[Repo], APIService.APIError>) in
            switch result {
            case let .success(repos):
                self?.repos = repos
                self?.dataChanged?(true)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func repo(at indexPath: IndexPath) -> Repo {
        return repos[indexPath.row]
    }
    
    func repoOwnerName() -> String? {
        return repos.first?.owner.name
    }
    
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
