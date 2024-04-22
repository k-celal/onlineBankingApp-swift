//
//  PaymentHistoryViewController.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 18.04.2024.
//

import Foundation
import UIKit

class PaymentHistoryViewController: UIViewController {
    private let apiGetTransactionService = ApiGetTransactionService()
    private var response_data: PaymentHistoryResponse? // Placeholder for response
    private var dateFormatter = DateFormatter()
    @IBOutlet weak var paymentHistoryTable: UITableView!
    func formatIntArrayToDate(_ dateComponents: [Int], format: String) -> String {
        // Tarih bileşenlerini al
        guard dateComponents.count == 6 else {
            // Eğer bileşenlerin sayısı beklendiği gibi değilse, nil döndür
            return "Date not available"
        }
        
        // NSDateComponents ile tarih bileşenlerini ayarla
        var components = DateComponents()
        components.year = dateComponents[0]
        components.month = dateComponents[1]
        components.day = dateComponents[2]
        components.hour = dateComponents[3]
        components.minute = dateComponents[4]
        components.second = dateComponents[5]
        
        // NSDateFormatter kullanarak stringe dönüştür
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = Calendar.current.date(from: components) else {
            // Tarih oluşturulamazsa, nil döndür
            return "Date not available"
        }
        
        // String olarak biçimlendir ve döndür
        return dateFormatter.string(from: date)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        paymentHistoryTable.delegate = self
        paymentHistoryTable.dataSource = self
        paymentHistoryTable.register(PaymentHistoryCellsTableViewCell.self, forCellReuseIdentifier: "raymentCell")
        // Call the API service to get transaction history
        apiGetTransactionService.getPaymentHistory { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let paymentHistoryResponse):
                // Handle successful response
                self.response_data = paymentHistoryResponse
                DispatchQueue.main.async {
                    self.paymentHistoryTable.reloadData() // Reload table view with fetched data
                }
            case .failure(let error):
                // Handle error
                print(error.localizedDescription) // Print the error message
            }
        }
    }
}

extension PaymentHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response_data?.paymentHistory.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "paymentCell", for: indexPath) as? PaymentHistoryCellsTableViewCell else {
            fatalError("Failed to dequeue a reusable cell.")
        }
        
        guard let payment = response_data?.paymentHistory[indexPath.row] else {
            return cell
        }
        
        let createdAtString = formatIntArrayToDate(payment.createdAt, format: "dd/MM/yyyy HH:mm:ss")



        cell.t_date.text = createdAtString
        cell.t_status.text = payment.status
        cell.t_amount.text = "\(payment.amount)"
        cell.t_abonelik.text = payment.beneficiary
        cell.t_hesaNo.text = "\(payment.accountID)"
        cell.t_id.text = "\(payment.paymentID)"
        cell.t_aboneNo.text = "\(payment.beneficiaryAccNo)"
        return cell
    }
    
}
