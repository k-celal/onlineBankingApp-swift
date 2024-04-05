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
    let createdAt: Date?
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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        accountId = try container.decode(Int.self, forKey: .accountId)
        userId = try container.decode(Int.self, forKey: .userId)
        accountNumber = try container.decode(String.self, forKey: .accountNumber)
        accountName = try container.decode(String.self, forKey: .accountName)
        accountType = try container.decode(String.self, forKey: .accountType)
        balance = try container.decode(Decimal.self, forKey: .balance)
        
        if let dateString = try container.decodeIfPresent(String.self, forKey: .createdAt) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            createdAt = formatter.date(from: dateString)
        } else {
            createdAt = nil
        }
        
        updatedAt = try container.decode([Int].self, forKey: .updatedAt)
    }
}


