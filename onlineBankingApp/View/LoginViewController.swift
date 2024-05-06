import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var financialDataButton: UIButton! // Financial Data butonu eklendi
    let apiAuthService = ApiAuthService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        showToast(message: "Giris Basarili") {
            self.performSegue(withIdentifier: "loginToMenuSegue", sender: nil)
        }
    }
    
    func handleLoginFailure(error: Error) {
        if let apiError = error as? ApiAuthException {
            showToast(message: apiError.localizedDescription)
        } else {
            showToast(message: "Giris Basarisiz, Lutfen tekrar deneyin.")
        }
        print("Login error: \(error.localizedDescription)")
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
