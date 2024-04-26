//
//  TransferResponseModel.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 26.04.2024.
//

import Foundation
struct TransferResponseModel: Codable {
    let Accounts: [AccountModel]
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case Accounts = "accounts"
        case message = "message"
    }
}
