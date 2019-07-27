//
//  ImageFetcher.swift
//  UserRepos
//
//  Created by Mahmoud Abolfotoh on 7/27/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import UIKit

struct ImageFetcher {
    private static let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: config)
    }()
    
    private static var currentDownloads = [URL: [ImageDownloadCompletion]]()
    typealias ImageDownloadCompletion = (UIImage?, URL) -> Void
    
    public static func fetchImage(forURL url: URL, completionHandler: @escaping ImageDownloadCompletion) {
        if currentDownloads.keys.contains(url) {
            self.currentDownloads[url]?.append(completionHandler)
            return
        }
        
        self.currentDownloads[url] = [completionHandler]
        let task = self.session.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                let image: UIImage? = data.flatMap(UIImage.init)
                self.currentDownloads[url]?.forEach { ($0(image, url)) }
                self.currentDownloads.removeValue(forKey: url)
            }
        }
        task.resume()
    }
}
