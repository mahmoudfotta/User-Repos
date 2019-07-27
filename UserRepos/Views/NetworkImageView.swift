//
//  NetworkImageView.swift
//  UserRepos
//
//  Created by Mahmoud Abolfotoh on 7/27/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import UIKit

class NetworkImageView: UIImageView {
    var url: URL? {
        didSet {
            loadImageIfNedded()
        }
    }
    private func loadImageIfNedded() {
        guard let url = url else {
            image = nil
            return
        }
        
        ImageFetcher.fetchImage(forURL: url) { [weak self] (image, url) in
            if url == self?.url {
                self?.image = image
            }
        }
    }
}
