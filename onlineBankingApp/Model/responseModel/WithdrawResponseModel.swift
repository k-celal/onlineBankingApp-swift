//
//  WithdrawResponseModel.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 23.04.2024.
//

import Foundation
struct WithdrawResponseModel: Codable {
    let Accounts: [AccountModel]
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case Accounts = "accounts"
        case message = "message"
    }
}
