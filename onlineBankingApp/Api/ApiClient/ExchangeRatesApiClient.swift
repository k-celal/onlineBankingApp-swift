//
//  ExchangeRatesApiServiceInterface.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 29.03.2024.
//
import Foundation
class ExchangeRatesApiClient: ExchangeRatesApiServiceInterface {
    private let baseURL = "https://api.freecurrencyapi.com/"

    func getLatestCurrencies(apiKey: String, baseCurrency: String, currencies: String, completion: @escaping (Result<CurrencyResponse, Error>) -> Void) {
        guard var urlComponents = URLComponents(string: "\(baseURL)/v1/latest") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "apikey", value: apiKey),
            URLQueryItem(name: "base_currency", value: baseCurrency),
            URLQueryItem(name: "currencies", value: currencies)
        ]
        
        guard let url = urlComponents.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let currencyResponse = try decoder.decode(CurrencyResponse.self, from: data)
                completion(.success(currencyResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    // Diğer hata durumları buraya eklenebilir
}
