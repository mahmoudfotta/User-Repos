//
//  RepoWebController.swift
//  UserRepos
//
//  Created by Mahmoud Abolfotoh on 7/27/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import UIKit
import WebKit

class RepoWebController: UIViewController {
    var repo: Repo?
    var webView = WKWebView()

    override func loadView() {
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let repo = repo {
            let url = URL(string: repo.repoURL)!
            webView.load(URLRequest(url: url))
        }
        if let repoTitle = repo?.name {
            title = repoTitle
        }
    }
}
