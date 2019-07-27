//
//  Repo.swift
//  UserRepos
//
//  Created by Mahmoud Abolfotoh on 7/26/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import Foundation

struct Repo: Codable {
    var name: String
    var description: String
    var forksCount: Int
    var language: String?
    var creationDate: Date
    var owner: Owner
    var repoURL: String
    
    var formmatedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MM dd"
        return formatter.string(from: creationDate)
    }
    
    enum CodingKeys: String, CodingKey {
        case name, description, language, owner
        case forksCount = "forks_count"
        case creationDate = "created_at"
        case repoURL = "html_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        forksCount = try container.decode(Int.self, forKey: .forksCount)
        language = try container.decodeIfPresent(String.self, forKey: .language)
        creationDate = try container.decode(Date.self, forKey: .creationDate)
        owner = try container.decode(Owner.self, forKey: .owner)
        repoURL = try container.decode(String.self, forKey: .repoURL)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}
