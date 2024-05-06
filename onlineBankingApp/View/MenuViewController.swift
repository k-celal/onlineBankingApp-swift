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
    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var paymentHistory: UIButton!
    @IBOutlet weak var transactionHistory: UIButton!
    @IBOutlet weak var createAccount: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func viewDashboardTapped(_ sender: UIButton) {
        
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
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        ApiAuthService.logout { error in
            DispatchQueue.main.async {
                if let error = error {
                    // Çıkış işlemi başarısız oldu
                    print("Logout failed: \(error.localizedDescription)")
                    // Hata mesajını göster
                    self.showToast(message: "Cıkıs islemi basarisiz. Lutfen tekrar deneyiniz.")
                } else {
                    // Çıkış işlemi başarılı oldu
                    print("Logout successful")
                    // Başarılı mesajını göster
                    self.showToast(message: "Cıkıs islemi başarılı. İyi günler dileriz.")
                    
                    // Kullanıcıyı giriş ekranına yönlendirin veya başka bir işlem yapın
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                        // Login view controller instance'ını alın
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                           let window = windowScene.windows.first {
                            // Window üzerindeki root view controller'ı değiştirin
                            window.rootViewController = loginViewController
                            // Window'u gösterin
                            window.makeKeyAndVisible()
                        }
                    }
                }
            }
        }
    }
}

