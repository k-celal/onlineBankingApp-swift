//
//  TransactionHistoryViewController.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 5.04.2024.
//

import UIKit



class TransactionHistoryViewController: UIViewController {
    private let apiGetTransactionService = ApiGetTransactionService()
    private var response_data: TransactionHistoryResponse? // Placeholder for response data
    
    @IBOutlet weak var transactionHistoryTable: UITableView! // Table view outlet
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
        
        transactionHistoryTable.delegate = self
        transactionHistoryTable.dataSource = self
        // Call the API service to get transaction history
        apiGetTransactionService.getTransactionHistory { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let transactionHistoryResponse):
                // Handle successful response
                self.response_data = transactionHistoryResponse
                DispatchQueue.main.async {
                    self.transactionHistoryTable.reloadData() // Reload table view with fetched data
                }
            case .failure(let error):
                // Handle error
                print(error.localizedDescription) // Print the error message
            }
        }
    }
}

extension TransactionHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response_data?.transactionHistory.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as? TransactionCellsTableViewCell else {
            fatalError("Failed to dequeue a reusable cell.")
        }
        guard let transaction = response_data?.transactionHistory[indexPath.row] else {
            return cell
        }
        let createdAtString = formatIntArrayToDate(transaction.createdAt, format: "dd/MM/yyyy HH:mm:ss")
        // Configure the cell with transaction data
        cell.t_date.text = createdAtString
        cell.t_status.text = transaction.status
        cell.t_amount.text = "\(transaction.amount)"
        cell.t_type.text = transaction.transactionType
        cell.t_hesaNo.text = transaction.source
        cell.t_id.text = "\(transaction.transactionID)"
        return cell
    }
}
