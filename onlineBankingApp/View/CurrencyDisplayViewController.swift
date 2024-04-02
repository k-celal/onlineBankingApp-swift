//
//  CurrencyDisplayViewController.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 29.03.2024.
//

import Foundation
import UIKit

class CurrencyDisplayViewController: UIViewController {
    
    @IBOutlet weak var eurRateLabel: UILabel!
    @IBOutlet weak var usdRateLabel: UILabel!
    @IBOutlet weak var jpyRateLabel: UILabel!
    @IBOutlet weak var gbpRateLabel: UILabel!
    @IBOutlet weak var audRateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // API key, base currency ve hedef currencies parametrelerini belirle
        // API key, base currency ve hedef currencies parametrelerini belirle
                let apiKey = "fca_live_K4BWWsi9ONsX3hPyzn2xYl7ylQ6WsczT7tVsXAZe"
                let baseCurrency = "USD"
                let currencies = "EUR,TRY,JPY,GBP,AUD"
                
                // ExchangeRatesApiGetRequestService oluştur
                let apiGetRequestService = ExchangeRatesApiClient()
                
                // API'den verileri al
                apiGetRequestService.getLatestCurrencies(apiKey: apiKey, baseCurrency: baseCurrency, currencies: currencies) { result in
                    switch result {
                    case .success(let response):
                        // Verileri işle
                        DispatchQueue.main.async {
                            // TextView'lere verileri yaz
                            let data = response.data
                            print(data)
                            self.eurRateLabel.text = String(format: "1 EUR Karşılığı: %.2f ₺", (data["TRY"] ?? 0) / (data["EUR"] ?? 1))
                            self.usdRateLabel.text = String(format: "1 USD Karşılığı: %.2f ₺", data["TRY"] ?? 0)
                            self.jpyRateLabel.text = String(format: "1 JPY Karşılığı: %.2f ₺", (data["TRY"] ?? 0) / (data["JPY"] ?? 1))
                            self.gbpRateLabel.text = String(format: "1 GBP Karşılığı: %.2f ₺", (data["TRY"] ?? 0) / (data["GBP"] ?? 1))
                            self.audRateLabel.text = String(format: "1 AUD Karşılığı: %.2f ₺", (data["TRY"] ?? 0) / (data["AUD"] ?? 1))
                        }
                    case .failure(let error):
                        // Hata durumunda işlemler
                        print("Request failed: \(error.localizedDescription)")
                        // Hata durumunda bile LoginActivity'ye yönlendir
                        DispatchQueue.main.async {
                            if let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                                self.present(loginVC, animated: true, completion: nil)
                            }
                        }
                    }
                }
    }
}
