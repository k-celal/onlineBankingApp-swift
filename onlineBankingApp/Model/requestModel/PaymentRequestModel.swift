//
//  PaymentRequestModel.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 26.04.2024.
//

import Foundation
struct PaymentRequestModel: Codable {
    let beneficiary: String
    let account_number: String
    let account_id: String
    let reference: String
    let payment_amount: String
    
    enum CodingKeys: String, CodingKey {
        case beneficiary = "beneficiary"
        case account_number = "account_number"
        case account_id = "account_id"
        case reference = "reference"
        case payment_amount = "payment_amount"
    }
}
