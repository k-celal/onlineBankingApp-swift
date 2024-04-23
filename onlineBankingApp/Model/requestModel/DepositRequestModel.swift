//
//  DepositRequestModel.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 23.04.2024.
//

import Foundation
struct DepositRequestModel: Codable {
    let accountId: String
    let depositAmount: String
    
    enum CodingKeys: String, CodingKey {
        case accountId = "account_id"
        case depositAmount = "deposit_amount"
    }
}
