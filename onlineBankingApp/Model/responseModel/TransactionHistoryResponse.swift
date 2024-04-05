//
//  TransactionHistoryResponse.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 5.04.2024.
//

import Foundation
struct TransactionHistoryResponse: Codable {
    let transactionHistory: [Transaction]
    
    enum CodingKeys: String, CodingKey {
        case transactionHistory = "transaction_history"
    }
}
