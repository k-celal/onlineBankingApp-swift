//
//  CreateAccountViewController.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 2.04.2024.
//

import Foundation
import UIKit

class CreateAccountViewController: UIViewController {
    
    @IBOutlet private weak var accountNameTextField: UITextField!
    @IBOutlet private weak var accountTypeTextField: UITextField!
    @IBOutlet private weak var createAccountButton: UIButton!
    
    private let apiPostTransactionService = ApiPostTransactionService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAccountButton.addTarget(self, action: #selector(createAccountButtonTapped), for: .touchUpInside)
    }
    
    @objc private func createAccountButtonTapped() {
        guard let accountName = accountNameTextField.text,
              let accountType = accountTypeTextField.text else {
            // Handle error, input fields cannot be empty
            return
        }
        
        sendCreateAccountRequest(accountName: accountName, accountType: accountType)
    }
    
    private func sendCreateAccountRequest(accountName: String, accountType: String) {
        apiPostTransactionService.createAccount(accountName: accountName, accountType: accountType) { result in
            switch result {
            case .success(let responseData):
                DispatchQueue.main.async {
                    // Hesap açma başarılı ise
                    let message = "Hesap başarıyla açıldı: \(responseData.accountName)"
                    self.showToast(message: message){
                        self.performSegue(withIdentifier: "createAccToMenuSegue", sender: nil)
                    }
                    
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    // Hesap açma başarısız ise
                    let message = "Hesap açma işlemi başarısız oldu: \(error.localizedDescription)"
                    self.showToast(message: message)
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
