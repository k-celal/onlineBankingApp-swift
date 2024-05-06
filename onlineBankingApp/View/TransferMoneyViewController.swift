//
//  TransferMoneyViewController.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 26.04.2024.
//

import UIKit

class TransferMoneyViewController: UIViewController {
    var accountId: Int?
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var targetAccount: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func transferMoneyButtonTapped(_ sender: UIButton) {
        guard let amountString = amount.text else {
                showToast(message: "Lütfen bir miktar girin.")
                return
            }
        guard let amountStringTargetAcc = targetAccount.text else {
                showToast(message: "Lütfen bir hedef hesap girin.")
                return
            }
        let apiService = ApiPostTransactionService()
        apiService.transferMoney(sourceAccount: "\(accountId ?? 0)", targetAccount: amountStringTargetAcc, amount: amountString
        ){ result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    // API'den dönen mesajı ekrana bastır
                    self.showToast(message: response.message){
                        self.performSegue(withIdentifier: "transferToMain", sender: nil)
                    }
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
