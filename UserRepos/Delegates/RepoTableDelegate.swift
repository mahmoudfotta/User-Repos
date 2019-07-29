//
//  RepoTableDelegate.swift
//  UserRepos
//
//  Created by Mahmoud Abolfotoh on 7/29/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import UIKit

class RepoTableDelegate: NSObject, UITableViewDelegate {
    var cellTapped: ((_ indexPath: IndexPath) -> Void)?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        cellTapped?(indexPath)
    }
}
