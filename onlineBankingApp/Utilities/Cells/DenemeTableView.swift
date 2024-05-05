//
//  DenemeTableView.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 3.05.2024.
//

import UIKit

class DenemeTableView: UITableViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var hesapNoLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var statuslabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(transaction: Transaction) {
        //self.dateLabel.text = "\(transaction.createdAt ?? )"
        self.statuslabel.text = transaction.status
        self.amountLabel.text = "\(transaction.amount)"
        self.typeLabel.text = transaction.transactionType
        self.hesapNoLabel.text = transaction.source
        self.idLabel.text = "\(transaction.transactionID)"
    }
    
}
