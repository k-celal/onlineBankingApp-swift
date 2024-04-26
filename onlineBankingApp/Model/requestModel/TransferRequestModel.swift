//
//  TransferRequestModel.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 26.04.2024.
//

import Foundation
struct TransferRequestModel: Codable {
    var sourceAccount: String
    var targetAccount: String
    var amount: String
    
    enum CodingKeys: String, CodingKey {
        case sourceAccount = "sourceAccount"
        case targetAccount = "targetAccount"
        case amount = "amount"
    }
}
