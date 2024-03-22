//
//  ApiAuthService.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 22.03.2024.
//

import Foundation
class ApiAuthService {
    static let localStorageManager = LocalStorageManager()
    
    static func login(loginRequestModel: LoginRequestModel, completion: @escaping (Result<AccessTokenModel, Error>) -> Void) {
        let baseURL = "http://127.0.0.1:8070" // API'nin temel URL'si
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
            // Error log
            if let error = error {
                completion(.failure(error))
                return
            }

            // Data log
            if let data = data {
                do {
                    let responseData = try JSONDecoder().decode(AccessTokenModel.self, from: data)
                    // Access token'i localStorageManager'a kaydet
                    localStorageManager.saveAccessToken(accessToken: responseData.accessToken)
                    print(responseData.accessToken)
                    // Success completion
                    completion(.success(responseData))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(ApiAuthException("Response data is nil.")))
            }
        }.resume()

    }
}
