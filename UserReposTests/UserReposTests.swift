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
    var reposJson = """
    [{
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
    }]
"""
    
    var repoData: Data!
    var dataSource: RepoTableDataSource!
    
    override func setUp() {
        repoData = reposJson.data(using: .utf8)
        dataSource = RepoTableDataSource(isTesting: true)
    }

    override func tearDown() {
        repoData = nil
        dataSource = nil
    }
    
    func decodeRepoData() -> [Repo]? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let repos = try? decoder.decode([Repo].self, from: repoData)
        return repos
    }

    //MARK:- Repo and Ownwr Tests
    
    func testRepoAndOwnerDataDecodedCorrectly() {
        let repos = decodeRepoData()
        
        if let repo = repos?.first {
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
        let repos = decodeRepoData()
        
        if let repo = repos?.first {
            XCTAssertEqual(repo.formmatedDate, "2019 04 07")
        } else {
            XCTFail("Error decoding repo data")
        }
    }
    
    func testAPIServiceFetchUserReposAreFetched() {
        let session = URLSessionMock()
        session.testData = repoData
        let apiService = APIService()
        let expectation = XCTestExpectation(description: "Dowloading repos are downloading correctly.")
        
        apiService.GET(using: session, endpoint: .userRepos, params: nil) { (result: Result<[Repo], APIService.APIError>) in
            switch result {
            case let .success(repo):
                XCTAssertEqual(repo.first?.name, "Codextended")
                expectation.fulfill()
            case let .failure(error):
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testRepoAPIManagerFetchUserReposAreFetched() {
        let session = URLSessionMock()
        session.testData = repoData
        var apiService = APIService()
        apiService.session = session
        let repoAPIManager = RepoAPIManager(apiService: apiService)
        
        let expectation = XCTestExpectation(description: "Dowloading repos are downloading correctly.")
        repoAPIManager.fetchUserRepos { (result: Result<[Repo], APIService.APIError>) in
            switch result {
            case let .success(repo):
                XCTAssertEqual(repo.first?.name, "Codextended")
                expectation.fulfill()
            case let .failure(error):
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    //MARK:- Repo DataSource Tests

    func testReposArrayCountIsZeroAtFirst() {
        XCTAssertEqual(dataSource.repos.count, 0)
    }
    
    func testSettingReposPropertyIsSettingCorrectly() {
        let repos = decodeRepoData()
        
        if let repos = repos {
            dataSource.repos = repos
            XCTAssertEqual(dataSource.repos.count, 1)
        } else {
            XCTFail()
        }
    }
    
    func testTableViewCellForRowAtIndexPathLabelsDataEqualToCurrentRepoData() {
        dataSource.repos = decodeRepoData() ?? []
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let navController = storyBoard.instantiateInitialViewController() as! UINavigationController
        let userReposController = navController.viewControllers.first as! UserReposController
        userReposController.dataSource = dataSource
        
        userReposController.loadViewIfNeeded()
        
        for (index, repo) in dataSource.repos.enumerated() {
            let indexPath = IndexPath(row: index, section: 0)
            guard let cell = dataSource.tableView(userReposController.tableView, cellForRowAt: indexPath) as? RepoCell else { return }
            XCTAssertEqual(cell.titleLabel.text, repo.name)
            XCTAssertEqual(cell.languageLabel.text, repo.language)
            XCTAssertEqual(cell.descriptionLabel.text, repo.description)
            XCTAssertEqual(cell.dateLabel.text, repo.formmatedDate)
            XCTAssertEqual(cell.forksLabel.text, "\(repo.forksCount)")
            XCTAssertEqual(cell.userImageView.url?.absoluteString, repo.owner.avatarURL)
        }
    }
    
    //MARK:- UserReposController
    
    func testTableViewNotNil() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let navController = storyBoard.instantiateInitialViewController() as! UINavigationController
        let userReposController = navController.viewControllers.first as! UserReposController
        
        userReposController.loadViewIfNeeded()
        
        XCTAssertNotNil(userReposController.tableView)
    }
}
