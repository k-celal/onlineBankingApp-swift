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
        
    }
    func showToast(message: String, completion: (() -> Void)? = nil) {
        let toast = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        present(toast, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            toast.dismiss(animated: true) {
                completion?() // completion bloğunu kontrol ediyoruz ve varsa çağırıyoruz
            }
        }
    }
}
