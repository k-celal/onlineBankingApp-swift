//
//  BaseViewController.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 30.03.2024.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Toolbar'ı oluştur
        let toolbar = UIToolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toolbar)
        
        // Toolbar'ı alt kenara, genişliği view genişliğine, yüksekliği 44 olarak ayarla
        toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        toolbar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        toolbar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        // Çıkış butonunu oluştur ve toolbar'a ekle
        let logoutButton = UIBarButtonItem(title: "Çıkış", style: .plain, target: self, action: #selector(logoutButtonTapped))
        toolbar.items?.append(logoutButton)
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
    @objc func logoutButtonTapped() {
        ApiAuthService.logout { error in
            if let error = error {
                // Çıkış işlemi başarısız oldu
                print("Logout failed: \(error.localizedDescription)")
                // Hata mesajını göster
                self.showToast(message: "Cıkıs islemi basarisiz. Lutfen tekrar deneyiniz.")
            } else {
                // Çıkış işlemi başarılı oldu
                print("Logout successful")
                // Başarılı mesajını göster
                self.showToast(message: "Cıkıs islemi basarili")
                // Kullanıcıyı giriş ekranına yönlendirin veya başka bir işlem yapın
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                           let window = windowScene.windows.first {
                            window.rootViewController = loginViewController
                        }
                    }
                }
            }
        }
    }
}
