//
//  APIService.swift
//  UserRepos
//
//  Created by Mahmoud Abolfotoh on 7/26/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import Foundation

struct APIService {
    let baseURL = URL(string: "https://api.github.com")!
    let decoder = JSONDecoder()
    
    var session: URLSessionProtocol = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: config)
    }()
    
    enum APIError: Error {
        case noResponse
        case jsonDecodingError(error: Error)
        case networkError(error: Error)
    }
    
    func GET<T: Codable>(for route: APIRoute, session: URLSessionProtocol, params: [String: String]? = nil, completionHandler: @escaping (Result<T, APIError>) -> Void) {
        let url = route.resolve(baseURL: baseURL, parameters: params)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.noResponse))
                }
                return
            }
            guard error == nil else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.networkError(error: error!)))
                }
                return
            }
            do {
                self.decoder.dateDecodingStrategy = .iso8601
                let object = try self.decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(.success(object))
                }
            } catch let error {
                DispatchQueue.main.async {
                    completionHandler(.failure(.jsonDecodingError(error: error)))
                }
            }
        }
        task.resume()
    }
}
