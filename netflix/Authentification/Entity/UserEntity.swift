//
//  UserEntity.swift
//  netflix
//
//  Created by Youssef on 17/11/2024.
//

import Foundation

struct User: Codable {
    let id, firstName, lastName, email: String?
    let password, phone, avatar, token: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case firstName, lastName, email, password, phone, avatar, token
    }
}
