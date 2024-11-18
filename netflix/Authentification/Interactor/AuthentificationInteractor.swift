//
//  AuthentificationInteractor.swift
//  netflix
//
//  Created by Youssef on 17/11/2024.
//

import Foundation
import Combine

class AuthentificationInteractor:AuthentificationInteractorProtocol{
    
    private var apiManager: ApiManager
    private var cancellables = Set<AnyCancellable>()
    //var keychainService = KeychainService()
    init(apiManager: ApiManager) {
        self.apiManager = apiManager
    }
    
    func authenticate(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            completion(.failure(URLError(.cannotCreateFile)))
            return
        }
        let headers = [ "Content-Type": "application/json"   ]
        let urlString = "\(apiManager.determineAppEnvironment())/api/users/login"
        print(urlString)
        apiManager.fetchData(urlString: urlString, body: jsonData, headers: headers)
        
            .tryMap { (data, response) -> User in
                guard response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                let decoder = JSONDecoder()
                return try decoder.decode(User.self, from: data)
            }
            .sink(receiveCompletion: { apiCompletion in
                switch apiCompletion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                    completion(.failure(error))
                }
            }, receiveValue: { response in
                completion(.success(response))
            })
            .store(in: &cancellables)
        
    }
    
    
    
}
