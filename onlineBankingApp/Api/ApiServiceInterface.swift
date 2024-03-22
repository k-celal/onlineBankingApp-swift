//
//  ApiServiceInterface.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 22.03.2024.
//

import Foundation

struct ApiServiceInterface{
    static let baseURL = "http://127.0.0.1:8070"
    
    static func login(loginRequestModel: LoginRequestModel, completion: @escaping (Result<AccessTokenModel, Error>) -> Void) {
        let url = URL(string: "\(baseURL)/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONEncoder().encode(loginRequestModel) else {
            completion(.failure(ApiAuthException("Login işlemi başarısız oldu.")))
            return
        }
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // handle response
        }.resume()
    }
}
