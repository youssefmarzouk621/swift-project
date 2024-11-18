//
//  AuthentificationInteractorProtocol.swift
//  netflix
//
//  Created by Youssef on 17/11/2024.
//

import Foundation
import Combine


protocol AuthentificationInteractorProtocol {
    func authenticate(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
}
