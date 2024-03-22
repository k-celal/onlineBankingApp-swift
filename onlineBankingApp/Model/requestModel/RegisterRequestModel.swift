//
//  RegisterRequestModel.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 22.03.2024.
//

import Foundation

struct RegisterRequestModel: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case password
    }
}
