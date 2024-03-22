//
//  ApiAuthException.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 22.03.2024.
//

import Foundation
struct ApiAuthException: Error {
    let message: String
    init(_ message: String) {
        self.message = message
    }
}
