//
//  DepositMoneyViewController.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 23.04.2024.
//

import UIKit

class DepositMoneyViewController: UIViewController {
    var accountID : Int?
    @IBOutlet weak var depositAmountField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func depositMoneyButtonTapped(_ sender: UIButton) {
            guard let amountString = depositAmountField.text else {
                showAlert(message: "Lütfen bir miktar girin.")
                return
            }
            
            // Sayısal kontrol
            guard let depositAmount = Double(amountString) else {
                showAlert(message: "Lütfen geçerli bir miktar girin.")
                return
            }
            
            // API isteği
            let apiService = ApiPostTransactionService()
            apiService.depositMoney(accountId: "\(accountID ?? 0)", depositAmount: "\(depositAmount)") { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        // API'den dönen mesajı ekrana bastır
                        self.showAlert(message: response.message)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.showAlert(message: error.localizedDescription)
                    }
                }
            }
        }
        
        func showAlert(message: String) {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
