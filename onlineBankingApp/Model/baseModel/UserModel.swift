//
//  userModel.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 22.03.2024.
//

import Foundation


struct UserModel: Codable {
    let userId: String?
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    let token: String?
    let code: String?
    let verified: Int
    let verifiedAt: Date?
    let createdAt: Date?
    let updatedAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case email = "email"
        case password = "password"
        case token = "token"
        case code = "code"
        case verified = "verified"
        case verifiedAt = "verified_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


