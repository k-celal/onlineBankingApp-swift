//
//  ApiGetTransactionService.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 5.04.2024.
//

import Foundation
class ApiGetTransactionService {
    private let localStorageManager: LocalStorageManager
    
    init() {
        self.localStorageManager = LocalStorageManager()
    }
    func getTransactionHistory(completion: @escaping (Result<TransactionHistoryResponse, Error>) -> Void) {
        // Base URL
        guard let url = URL(string: "http://127.0.0.1:8070/app/transaction_history") else {
            completion(.failure(NetworksError.invalidURL))
            return
        }
        
        // Access token
        guard let accessToken = localStorageManager.getAccessToken() else {
            completion(.failure(NetworksError.missingAccessToken))
            return
        }
        
        // URLRequest oluştur
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        // URLSession ile isteği gönder
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Hata kontrolü
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Yanıt kontrolü
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworksError.invalidResponse))
                return
            }
            
            // Yanıtın dönüştürülmesi
            guard let data = data else {
                completion(.failure(NetworksError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(TransactionHistoryResponse.self, from: data)
                completion(.success(responseData))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    func getPaymentHistory(completion: @escaping (Result<PaymentHistoryResponse, Error>) -> Void) {
        // Base URL
        guard let url = URL(string: "http://127.0.0.1:8070/app/payment_history") else {
            completion(.failure(NetworksError.invalidURL))
            return
        }
        
        // Access token
        guard let accessToken = localStorageManager.getAccessToken() else {
            completion(.failure(NetworksError.missingAccessToken))
            return
        }
        
        // URLRequest oluştur
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        // URLSession ile isteği gönder
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Hata kontrolü
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Yanıt kontrolü
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworksError.invalidResponse))
                return
            }
            
            // Yanıtın dönüştürülmesi
            guard let data = data else {
                completion(.failure(NetworksError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(PaymentHistoryResponse.self, from: data)
                completion(.success(responseData))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    func getDashboard(completion: @escaping (Result<DashboardResponse, Error>) -> Void) {
        // Base URL
        guard let url = URL(string: "http://127.0.0.1:8070/app/dashboard") else {
            completion(.failure(NetworksError.invalidURL))
            return
        }
        
        // Access token
        guard let accessToken = localStorageManager.getAccessToken() else {
            completion(.failure(NetworksError.missingAccessToken))
            return
        }
        
        // URLRequest oluştur
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        // URLSession ile isteği gönder
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Hata kontrolü
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Yanıt kontrolü
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworksError.invalidResponse))
                return
            }
            
            // Yanıtın dönüştürülmesi
            guard let data = data else {
                completion(.failure(NetworksError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(DashboardResponse.self, from: data)
                completion(.success(responseData))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }

}
