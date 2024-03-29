//
//  ExchangeRatesApiServiceInterface.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 29.03.2024.
//

import Foundation
protocol ExchangeRatesApiServiceInterface {
    func getLatestCurrencies(apiKey: String, baseCurrency: String, currencies: String, completion: @escaping (Result<CurrencyResponse, Error>) -> Void)
}
