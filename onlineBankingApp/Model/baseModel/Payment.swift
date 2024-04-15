//
//  Payment.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 15.04.2024.
//

import Foundation
struct Payment: Codable {
    let paymentID: Int
    let accountID: Int
    let beneficiary: String
    let beneficiaryAccNo: String
    let amount: Double
    let referenceNo: String
    let status: String
    let reasonCode: String
    let createdAt: [Int]
    
    enum CodingKeys: String, CodingKey {
        case paymentID = "payment_id"
        case accountID = "account_id"
        case beneficiary = "beneficiary"
        case beneficiaryAccNo = "beneficiary_acc_no"
        case amount = "amount"
        case referenceNo = "reference_no"
        case status = "status"
        case reasonCode = "reason_code"
        case createdAt = "created_at"
    }
}

