//
//  MenuViewController.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 30.03.2024.
//

import Foundation
import UIKit

class MenuViewController: BaseViewController {
    
    @IBOutlet weak var viewDashboardButton: UIButton!
    @IBOutlet weak var viewCreateAccountButton: UIButton!
    @IBOutlet weak var paymentHistoryButton: UIButton!
    @IBOutlet weak var transferHistoryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Toolbar ayarlamalar
        view.addSubview(toolbar)
        
//        // Dashboard sayfasına yönlendirme butonu
//        viewDashboardButton.addTarget(self, action: #selector(viewDashboard), for: .touchUpInside)
//        
//        // Hesap oluşturma sayfasına yönlendirme butonu
//        viewCreateAccountButton.addTarget(self, action: #selector(viewCreateAccount), for: .touchUpInside)
//        
//        // Ödeme Geçmişi sayfasına yönlendirme butonu
//        paymentHistoryButton.addTarget(self, action: #selector(paymentHistory), for: .touchUpInside)
//        
//        // Transfer Geçmişi sayfasına yönlendirme butonu
//        transferHistoryButton.addTarget(self, action: #selector(transferHistory), for: .touchUpInside)
    }
    
    @objc func viewDashboard() {
        
    }
    
    @objc func viewCreateAccount() {

    }
    
    @objc func paymentHistory() {
    
    }
    
    @objc func transferHistory() {
    
    }
}
