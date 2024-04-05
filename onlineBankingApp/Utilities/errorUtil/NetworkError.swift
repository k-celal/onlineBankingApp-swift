//
//  NetworkError.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 2.04.2024.
//

import Foundation
enum NetworksError: Error {
    case missingAccessToken
    case invalidURL
    case invalidResponse
    case statusCode(Int)
    case invalidData
    case decodingError
    case serializationError
}

