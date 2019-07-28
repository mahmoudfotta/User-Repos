//
//  UserReposTests.swift
//  UserReposTests
//
//  Created by Mahmoud Abolfotoh on 7/26/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import XCTest
@testable import UserRepos

class UserReposTests: XCTestCase {
    var repoJson = """
    {
    "name": "Codextended",
    "full_name": "JohnSundell/Codextended",
    "owner": {
    "login": "JohnSundell",
    "avatar_url": "https://avatars3.githubusercontent.com/u/2466701?v=4",
    },
    "html_url": "https://github.com/JohnSundell/Codextended",
    "description": "Extensions giving Swift's Codable API type inference super powers 🦸‍♂️🦹‍♀️",
    "fork": false,
    "url": "https://api.github.com/repos/JohnSundell/Codextended",
    "created_at": "2019-04-06T23:33:12Z",
    "language": "Swift",
    "forks_count": 36,
    "forks": 36,
    }
"""
    
    var repoData: Data!
    var dataSource: RepoTableDataSource!
    
    override func setUp() {
        repoData = repoJson.data(using: .utf8)
        dataSource = RepoTableDataSource(isTesting: true)
    }

    override func tearDown() {
        repoData = nil
        dataSource = nil
    }
    
    func decodeRepoData() -> Repo? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let repo = try? decoder.decode(Repo.self, from: repoData)
        return repo
    }

    //MARK:- Repo and Ownwr Tests
    
    func testRepoAndOwnerDataDecodedCorrectly() {
        let repo = decodeRepoData()
        
        if let repo = repo {
            XCTAssertEqual(repo.name, "Codextended")
            XCTAssertEqual(repo.language, "Swift")
            XCTAssertEqual(repo.forksCount, 36)
            XCTAssertEqual(repo.repoURL, "https://github.com/JohnSundell/Codextended")
            XCTAssertEqual(repo.owner.name, "JohnSundell")
            XCTAssertEqual(repo.owner.avatarURL, "https://avatars3.githubusercontent.com/u/2466701?v=4")
        } else {
            XCTFail("Error decoding repo data")
        }
    }
    
    func testRepoDateFormatIsCorrect() {
        let repo = decodeRepoData()
        
        if let repo = repo {
            XCTAssertEqual(repo.formmatedDate, "2019 04 07")
        } else {
            XCTFail("Error decoding repo data")
        }
    }
    
    //MARK:- Repo DataSource Tests

    func testReposArrayCountIsZeroAtFirst() {
        XCTAssertEqual(dataSource.repos.count, 0)
    }
    
    func testSettingReposPropertyIsSettingCorrectly() {
        let repo = decodeRepoData()
        
        if let repo = repo {
            dataSource.repos = [repo]
            XCTAssertEqual(dataSource.repos.count, 1)
        } else {
            XCTFail()
        }
    }
    
    //MARK:- UserREposController
    
    func testTableViewNotNil() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let navController = storyBoard.instantiateInitialViewController() as! UINavigationController
        let userReposController = navController.viewControllers.first as! UserReposController
        
        userReposController.loadViewIfNeeded()
        
        XCTAssertNotNil(userReposController.tableView)
    }
}
