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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "withdrawMoneySegue" {
            // Hedef view controller'ı al
            guard let destinationVC = segue.destination as? WithdrawMoneyViewController else {
                return
            }
            // Account ID'yi DepositMoneyViewController'a aktar
            destinationVC.accountId = selectedAccount?.accountId
            }
        if segue.identifier == "depositMoneySegue" {
            // Hedef view controller'ı al
            guard let destinationVC = segue.destination as? DepositMoneyViewController else {
                return
            }
            // Account ID'yi DepositMoneyViewController'a aktar
            destinationVC.accountID = selectedAccount?.accountId
            }
        if segue.identifier == "paymentMoneySegue" {
            // Hedef view controller'ı al
            guard let destinationVC = segue.destination as? PaymentMoneyViewController else {
                return
            }
            destinationVC.accountId = selectedAccount?.accountId
            }
        if segue.identifier == "transferMoneySegue" {
            // Hedef view controller'ı al
            guard let destinationVC = segue.destination as? TransferMoneyViewController else {
                return
            }
            destinationVC.accountId = selectedAccount?.accountId
            }
        }

    }

