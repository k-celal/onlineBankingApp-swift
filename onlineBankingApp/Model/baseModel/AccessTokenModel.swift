//
//  AccessTokenModel.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 22.03.2024.
//

import Foundation

struct AccessTokenModel: Codable {
    let accessToken: String
    let message: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case message = "message"
    }
}
