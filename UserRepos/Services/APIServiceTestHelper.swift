//
//  APIServiceTestHelper.swift
//  UserReposTests
//
//  Created by Mahmoud Abolfotoh on 7/29/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with url: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }

class DataTaskMock: URLSessionDataTask {
    override func resume() { }
}

class URLSessionMock: URLSessionProtocol {
    var testData: Data?
    var testReponse: URLResponse?
    var testError: Error?
    
    func dataTask(with url: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        defer {
            completionHandler(testData, testReponse, testError)
        }
        return DataTaskMock()
    }
}
