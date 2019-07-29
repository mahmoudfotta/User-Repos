//
//  RepoAPIManager.swift
//  UserRepos
//
//  Created by Mahmoud Abolfotoh on 7/27/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import Foundation

struct RepoAPIManager {
    var apiService: APIService
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    func fetchUserRepos(for route: APIRoute, completionHandler: @escaping (Result<[Repo], APIService.APIError>) -> Void) {
        apiService.GET(for: route, session: apiService.session) { (result: Result<[Repo], APIService.APIError>) in
            switch result {
            case let .success(repos):
                completionHandler(.success(repos))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
}
