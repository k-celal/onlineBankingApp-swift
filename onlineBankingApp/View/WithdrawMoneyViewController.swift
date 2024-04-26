//
//  WithdrawMoneyViewController.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 23.04.2024.
//

import UIKit

class WithdrawMoneyViewController: UIViewController {
    var accountId: Int?
    @IBOutlet weak var withdrawMoneyField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func withrawMoneyButtonTapped(_ sender: UIButton) {
        guard let amountString = withdrawMoneyField.text else {
            showToast(message: "Lütfen bir miktar girin.")
            return
        }
        
        // Sayısal kontrol
        guard let withdrawAmount = Double(amountString) else {
            showToast(message: "Lütfen geçerli bir miktar girin.")
            return
        }
        
        // API isteği
        let apiService = ApiPostTransactionService()
        apiService.withdrawMoney(accountId: "\(accountId ?? 0)", withdrawAmount: "\(withdrawAmount)") { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    // API'den dönen mesajı ekrana bastır
                    self.showToast(message: response.message)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showToast(message: error.localizedDescription)
                }
            }
        }
    }
    
    func showToast(message: String, completion: (() -> Void)? = nil) {
        let toast = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        present(toast, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            toast.dismiss(animated: true) {
                completion?() // completion bloğunu kontrol ediyoruz ve varsa çağırıyoruz
            }
        }
    }

}
