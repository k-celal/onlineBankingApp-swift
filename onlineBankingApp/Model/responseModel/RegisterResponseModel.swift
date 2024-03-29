//
//  RegisterResponseModel.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 24.03.2024.
//

import Foundation

struct RegisterResponseModel: Codable {
    let message: String
    let user: UserModel
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case user = "user"
    }
}
