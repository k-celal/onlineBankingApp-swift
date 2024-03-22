//
//  AccounModel.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 22.03.2024.
//

import Foundation

struct AccountModel: Codable {
    let accountId: Int
    let userId: Int
    let accountNumber: String
    let accountName: String
    let accountType: String
    let balance: Decimal
    let createdAt: Date
    let updatedAt: [Int]
    
    enum CodingKeys: String, CodingKey {
        case accountId = "account_id"
        case userId = "user_id"
        case accountNumber = "account_number"
        case accountName = "account_name"
        case accountType = "account_type"
        case balance = "balance"
        case createdAt = "create_at"
        case updatedAt = "updated_at"
    }
}
