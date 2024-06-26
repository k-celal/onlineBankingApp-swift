//
//  DashboardViewController.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 22.04.2024.
//

import UIKit

class DashboardViewController: BaseViewController {
    private let apiGetTransactionService = ApiGetTransactionService()
    private var response_data: DashboardResponse? // Placeholder for response
    var selectedAccount: AccountModel?
    @IBOutlet weak var totalBalance: UILabel!
    @IBOutlet weak var dashboardCollectionView: UICollectionView!
    @IBOutlet weak var logout: UIButton!
    override func viewDidLoad() {
            super.viewDidLoad()

            // Set up collection view
            dashboardCollectionView.delegate = self
            dashboardCollectionView.dataSource = self
            dashboardCollectionView.register(UINib(nibName: "DashboardCellsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "hashboardCell")

        dashboardCollectionView.isScrollEnabled = false
            // Fetch dashboard data
            fetchDashboardData()
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "accountOperationSegue" {
            // Hedef view controller'ı al
            guard let destinationVC = segue.destination as? AccountOperationsViewController else {
                return
            }
            
            // Seçilen hesabı aktar
            destinationVC.selectedAccount = selectedAccount
        }
    }
        private func fetchDashboardData() {
            apiGetTransactionService.getDashboard { [weak self] result in
                guard let self = self else { return }

                switch result {
                case .success(let dashboardResponse):
                    self.response_data = dashboardResponse
                    DispatchQueue.main.async {
                        self.dashboardCollectionView.reloadData()
                        if let totalBalance = self.response_data?.totalBalance {
                                            self.totalBalance.text = "Toplam Bakiye: \(totalBalance)"
                                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    // Handle error
                }
            }
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
    @IBAction func nextButtonTapped(_ sender: UIButton) {
            // Mevcut görüntülenen hücrenin indeksini al
            guard let currentIndexPath = dashboardCollectionView.indexPathsForVisibleItems.first else {
                return
            }
            
            // Bir sonraki hücrenin indeksini oluştur
            let nextIndexPath = IndexPath(item: currentIndexPath.item + 1, section: currentIndexPath.section)
            
            // Bir sonraki hücreye kaydır
            dashboardCollectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
        }
    @IBAction func previousButtonTapped(_ sender: UIButton) {
            // Mevcut görüntülenen hücrenin indeksini al
            guard let currentIndexPath = dashboardCollectionView.indexPathsForVisibleItems.first else {
                return
            }
            
            // Bir önceki hücrenin indeksini oluştur
            let previousIndexPath = IndexPath(item: currentIndexPath.item - 1, section: currentIndexPath.section)
            
            // Bir önceki hücreye kaydır
            dashboardCollectionView.scrollToItem(at: previousIndexPath, at: .centeredHorizontally, animated: true)
        }
    }


    extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return response_data?.userAccounts.count ?? 0
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardCell", for: indexPath) as? DashboardCellsCollectionViewCell else {
                fatalError("Failed to dequeue a reusable cell.")
            }

            guard let account = response_data?.userAccounts[indexPath.item] else {
                return cell
            }
            selectedAccount = account
            // Configure the cell with account data
            cell.account_ID.text = "Hesap ID: \(account.accountId)"
            cell.account_no.text = "Hesap Numarası: \(account.accountNumber)"
            cell.account_Name.text = "Hesap Adı: \(account.accountName)"
            cell.account_Type.text = "Hesap Türü: \(account.accountType)"
            cell.balance.text = "Bakiye: \(account.balance)"

            return cell
        }
    }
extension DashboardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Burada hücre boyutlarını ayarlayabilirsiniz
        let width = collectionView.bounds.width - 20 // Örnek olarak, hücrenin genişliğini koleksiyon görünümünün genişliğinden 20 piksel azaltıyoruz
        let height: CGFloat = 400 // Örnek olarak, hücrenin yüksekliğini 100 piksel olarak belirliyoruz
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Burada koleksiyon görünümünün iç kenar boşluğunu ayarlayabilirsiniz
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // Örnek olarak, her yönde 10 piksel iç kenar boşluğu belirliyoruz
    }
}


