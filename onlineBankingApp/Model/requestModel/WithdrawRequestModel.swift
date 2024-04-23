//
//  WithdrawRequestModel.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 23.04.2024.
//

import Foundation
struct WithdrawRequestModel: Codable {
    let accountId: String
    let withdrawAmount: String
    
    enum CodingKeys: String, CodingKey {
        case accountId = "account_id"
        case withdrawAmount = "withdrawal_amount"
    }
}
