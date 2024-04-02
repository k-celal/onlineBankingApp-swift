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
    static func register(firstName: String, lastName: String, email: String, password: String, completion: @escaping (Result<RegisterResponseModel, Error>) -> Void) {
            let baseURL = "http://127.0.0.1:8070" // API'nin temel URL'si
            let url = URL(string: "\(baseURL)/register?confirm_password=1234")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let registerRequestModel = RegisterRequestModel(firstName: firstName, lastName: lastName, email: email, password: password)
            
            guard let httpBody = try? JSONEncoder().encode(registerRequestModel) else {
                completion(.failure(ApiAuthException("Registration işlemi başarısız oldu.")))
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
                        print(data)
                        let responseData = try JSONDecoder().decode(RegisterResponseModel.self, from: data)
                        print(responseData)
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
    static func logout(completion: @escaping (Error?) -> Void) {
            guard let accessToken = localStorageManager.getAccessToken() else {
                let error = NSError(domain: "AccessTokenNotFound", code: 0, userInfo: [NSLocalizedDescriptionKey: "Access token not found"])
                completion(error)
                return
            }
            
            let baseURL = "http://127.0.0.1:8070" // API'nin temel URL'si
            let url = "\(baseURL)/logout"
            
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Request Failure: \(error.localizedDescription)")
                    completion(error)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                    print("HTTP Response Error: \(httpResponse.statusCode)")
                    completion(NSError(domain: "HTTPResponseError", code: httpResponse.statusCode, userInfo: nil))
                    return
                }
                
                print("Logout Successful.")
                localStorageManager.removeAccessToken()
                completion(nil)
            }.resume()
        }
}
