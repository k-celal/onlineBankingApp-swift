//
//  RegisterViewController.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 24.03.2024.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!

    let apiAuthService = ApiAuthService()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func registerButtonTapped(_ sender: Any) {
        guard let firstName = firstNameTextField.text,
              let lastName = lastNameTextField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text else {
            return
        }

        register(firstName: firstName, lastName: lastName, email: email, password: password)
    }

    func register(firstName: String, lastName: String, email: String, password: String) {
        ApiAuthService.register(firstName: firstName, lastName: lastName, email: email, password: password) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.handleRegistrationSuccess()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.handleRegistrationFailure(error: error)
                }
            }
        }
    }

    func handleRegistrationSuccess() {
        showToast(message: "Registration successful. Please check your email \(String(describing: emailTextField.text)) to confirm your account." ) {
            // Sunum tamamlandığında yapılacak işlemler burada olacak
            self.performSegue(withIdentifier: "registerToLoginSegue", sender: nil)
            print("Yönlendirme")
        }
    }

    func handleRegistrationFailure(error: Error) {
        showToast(message: "Registration failed. Please try again.") 
        print("Registration error: \(error.localizedDescription)")
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
