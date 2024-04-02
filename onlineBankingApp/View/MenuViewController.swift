//
//  MenuViewController.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 30.03.2024.
//

import Foundation
import UIKit

class MenuViewController: BaseViewController {
    
    @IBOutlet weak var viewDashboard: UIButton!

    @IBOutlet weak var paymentHistory: UIButton!
    @IBOutlet weak var transactionHistory: UIButton!
    @IBOutlet weak var createAccount: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Toolbar ayarlamalar
        view.addSubview(toolbar)
    }
    
    @IBAction func viewDashboardTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "menuToDashboardSegue", sender: nil)
    }
    
    @IBAction func paymentHistoryTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "menuToPaymentHistSegue", sender: nil)
    }
    
    @IBAction func transactionHistoryTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "menuToTransactionHistSegue", sender: nil)
    }
    
    @IBAction func createAccountTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "menuToCreateAccSegue", sender: nil)
    }
}

