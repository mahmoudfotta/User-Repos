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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.register(RepoCell.self, forCellReuseIdentifier: RepoCell.reuseIdentifier)
    }
}

extension UserReposController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.reuseIdentifier, for: indexPath) as? RepoCell else {
            fatalError("Couldn't deque new repo cell")
        }
        cell.titleLabel.text = "New repo"
        cell.descriptionLabel.text = "Extensions giving Swift's Codable API type inference super powers 🦸‍♂️🦹‍♀️ Extensions giving Swift's Codable API type inference super powers 🦸‍♂️🦹‍♀️"
        cell.languageLabel.text = "Swift"
        cell.forksLabel.text = "200"
        cell.dateLabel.text = "4/4/2018"
        return cell
    }
}
