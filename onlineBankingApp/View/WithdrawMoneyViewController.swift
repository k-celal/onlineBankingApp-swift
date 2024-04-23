//
//  WithdrawMoneyViewController.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 23.04.2024.
//

import UIKit

class WithdrawMoneyViewController: UIViewController {
    var AccountId: Int?
    @IBOutlet weak var withdrawMoneyField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func withrawMoneyButtonTapped(_ sender: UIButton) {
        
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}
