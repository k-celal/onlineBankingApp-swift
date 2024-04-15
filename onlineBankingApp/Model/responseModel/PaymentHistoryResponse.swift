//
//  PaymentHistoryResponse.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 15.04.2024.
//

import Foundation
struct PaymentHistoryResponse: Codable {
    let paymentHistory: [Payment]
    
    enum CodingKeys: String, CodingKey {
        case paymentHistory = "payment_history"
    }
}
