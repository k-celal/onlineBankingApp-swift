//
//  PaymentMoneyViewController.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 26.04.2024.
//

import UIKit

class PaymentMoneyViewController: UIViewController {
    var accountId: Int?
    @IBOutlet weak var beneficary: UITextField!
    @IBOutlet weak var reference: UITextField!
    @IBOutlet weak var paymentAmount: UITextField!
    @IBOutlet weak var aboneNo: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func paymentMoneyButtonTapped(_ sender: UIButton) {
        guard let amountStringPayment = paymentAmount.text else {
                showToast(message: "Lütfen bir miktar girin.")
                return
            }
            
            // Sayısal kontrol
            guard let paymentAmount = Double(amountStringPayment) else {
                showToast(message: "Lütfen geçerli bir miktar girin.")
                return
            }
            
            guard let amountStringBeneficary = beneficary.text else {
                showToast(message: "Lütfen bir kurum girin.")
                return
            }
            
            guard let amountStringAboneNo = aboneNo.text else {
                showToast(message: "Lütfen bir abone no girin.")
                return
            }
            
            guard let referenceText = reference.text else {
                showToast(message: "Lütfen bir referans girin.")
                return
            }
            
            // API isteği
            let apiService = ApiPostTransactionService()
            apiService.paymentMoney(
                beneficiary: amountStringBeneficary,
                accountNumber: amountStringAboneNo,
                reference: referenceText,
                accountId: "\(accountId ?? 0)", // Convert Int to String
                paymentAmount: "\(paymentAmount)" // Convert Double to String
            ) { result in
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
