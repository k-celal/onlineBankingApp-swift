//
//  AccountOperationsViewController.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 23.04.2024.
//

import UIKit

class AccountOperationsViewController: UIViewController {
    var selectedAccount: AccountModel?
    @IBOutlet weak var accountBalance: UILabel!
    @IBOutlet weak var accountType: UILabel!
    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var accountNo: UILabel!
    @IBOutlet weak var accountID: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Seçilen hesabın bilgilerini göster
        showAccountDetails()
    }
    
    func showAccountDetails() {
        guard let account = selectedAccount else {
            return
        }
        // Hesap bilgilerini güncelle
        accountID.text = "Hesap ID: \(account.accountId)"
        accountNo.text = "Hesap Numarası: \(account.accountNumber)"
        accountName.text = "Hesap Adı: \(account.accountName)"
        accountType.text = "Hesap Türü: \(account.accountType)"
        accountBalance.text = "Bakiye: \(account.balance)"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

