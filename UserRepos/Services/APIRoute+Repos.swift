//
//  ReposRoute.swift
//  UserRepos
//
//  Created by Mahmoud Abolfotoh on 7/30/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import Foundation

enum ReposRoute: APIRoute {
    case userRepos
    
    var path: String {
        switch self {
        case .userRepos:
            return "/users/johnsundell/repos"
        }
    }
}
