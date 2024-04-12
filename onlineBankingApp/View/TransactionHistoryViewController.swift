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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transactionHistoryTable.delegate = self
        transactionHistoryTable.dataSource = self
        transactionHistoryTable.register(TransactionCellsTableViewCell.self, forCellReuseIdentifier: "rransactionCell")
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
        
        // Configure the cell with transaction data
        cell.t_date.text = "\(transaction.createdAt)"
        cell.t_status.text = transaction.status
        cell.t_amount.text = "\(transaction.amount)"
        cell.t_type.text = transaction.transactionType
        cell.t_hesaNo.text = transaction.source
        cell.t_id.text = "\(transaction.transactionID)"
        
        return cell
    }
}
