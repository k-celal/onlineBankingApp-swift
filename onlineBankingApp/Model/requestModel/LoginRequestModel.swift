//
//  LoginRequestModel.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 22.03.2024.
//

import Foundation

struct LoginRequestModel: Codable {
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case password = "password"
    }
}
