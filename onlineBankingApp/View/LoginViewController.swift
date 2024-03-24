//
//  LoginViewController.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 23.03.2024.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let apiAuthService = ApiAuthService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        //navigateToRegister()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        login(email: email, password: password)
    }
    
    func login(email: String, password: String) {
        ApiAuthService.login(loginRequestModel: LoginRequestModel(email: email, password: password)) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.handleLoginSuccess()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.handleLoginFailure(error: error)
                }
            }
        }
    }
    
    func handleLoginSuccess() {
        showToast(message: "Login successful")
        //navigateToDashboard()
    }
    
    func handleLoginFailure(error: Error) {
        if let apiError = error as? ApiAuthException {
            showToast(message: apiError.localizedDescription)
        } else {
            showToast(message: "Login failed. Please try again.")
        }
        print("Login error: \(error.localizedDescription)")
    }
    
    func showToast(message: String) {
        let toast = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        present(toast, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            toast.dismiss(animated: true)
        }
    }
}
