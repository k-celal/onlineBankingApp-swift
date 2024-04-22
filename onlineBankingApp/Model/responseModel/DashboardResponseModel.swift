//
//  DashboardResponseModel.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 22.04.2024.
//

import Foundation
struct DashboardResponse: Codable {
    let totalBalance: Double
    let userAccounts: [AccountModel]
    
    enum CodingKeys: String, CodingKey {
        case totalBalance = "totalBalance"
        case userAccounts = "userAccounts"
    }
}
