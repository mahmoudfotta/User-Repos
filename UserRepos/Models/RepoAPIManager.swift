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
    
    func fetchUserRepos(completionHandler: @escaping (Result<[Repo], APIService.APIError>) -> Void) {
        apiService.GET(using: apiService.session, endpoint: .userRepos) { (result: Result<[Repo], APIService.APIError>) in
            switch result {
            case let .success(repos):
                completionHandler(.success(repos))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
}
