//
//  CurrencyResponse.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 29.03.2024.
//

import Foundation

struct CurrencyResponse: Codable {
    let data: [String: Double]
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

