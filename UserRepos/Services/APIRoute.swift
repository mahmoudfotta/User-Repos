//
//  APIRoute.swift
//  UserRepos
//
//  Created by Mahmoud Abolfotoh on 7/30/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import Foundation

protocol APIRoute {
    var path: String { get }
}

extension APIRoute {
    func resolve(baseURL: URL, parameters: [String: String]?) -> URL {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
        components.path = self.path
        if let params = parameters {
            for (_, value) in params.enumerated() {
                components.queryItems?.append(URLQueryItem(name: value.key, value: value.value))
            }
        }
        return components.url!
    }
}
