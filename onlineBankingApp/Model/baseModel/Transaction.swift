//
//  Transaction.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 5.04.2024.
//

import Foundation
struct Transaction: Codable {
    let transactionID: Int
    let accountID: Int
    let transactionType: String
    let amount: Double
    let source: String
    let status: String
    let reasonCode: String
    let createdAt: [Int]
    
    enum CodingKeys: String, CodingKey {
        case transactionID = "transaction_id"
        case accountID = "account_id"
        case transactionType = "transaction_type"
        case amount = "amount"
        case source = "source"
        case status = "status"
        case reasonCode = "reason_code"
        case createdAt = "created_at"
    }
}
