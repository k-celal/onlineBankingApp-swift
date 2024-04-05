//
//  CreateAccountRequestModel.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 2.04.2024.
//

import Foundation
struct CreateAccountRequestModel: Codable {
    let accountName: String
    let accountType: String
    
    enum CodingKeys: String, CodingKey {
        case accountName = "account_name"
        case accountType = "account_type"
    }
}
