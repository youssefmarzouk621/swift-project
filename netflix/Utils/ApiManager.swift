//
//  ApiManager.swift
//  netflix
//
//  Created by Youssef on 17/11/2024.
//

import Foundation
import Combine

struct ApiConstants {
    static let devBaseUrl = "http://ec2-107-22-112-49.compute-1.amazonaws.com:9000"
    static let releaseBaseUrl = "http://ec2-107-22-112-49.compute-1.amazonaws.com:9000"
    
}

enum AppEnvironment {
    case development
    case release
}

class AppConfig {
    static var apiEnvironment: AppEnvironment {
#if DEBUG
        return .development
#else
        return .release
#endif
    }
}

class ApiManager{
    private var environment:AppEnvironment
    static let shared = ApiManager(environment: AppConfig.apiEnvironment)
    init(environment: AppEnvironment) {
        self.environment = environment
    }
    
    func determineAppEnvironment() -> String {
          switch environment {
          case .development:
              return ApiConstants.devBaseUrl
          case .release:
              return ApiConstants.releaseBaseUrl
          }
      }
    
    func fetchData(
        urlString: String,
        method: String = "POST",
        body: Data? = nil,
        headers: [String: String]? = nil
    ) -> AnyPublisher<(data: Data, response: HTTPURLResponse), Error> {
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        if let headers = headers {
            request.allHTTPHeaderFields = headers
        }
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> (data: Data, response: HTTPURLResponse) in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return (data, httpResponse)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    
    
}
