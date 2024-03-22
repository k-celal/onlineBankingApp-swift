//
//  userModel.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 22.03.2024.
//

import Foundation
struct UserModel {
    let userId: String
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    let token: String
    let code: String
    let verified: Int
    let verifiedAt: Date
    let createdAt: Date
    let updatedAt: Date
}
