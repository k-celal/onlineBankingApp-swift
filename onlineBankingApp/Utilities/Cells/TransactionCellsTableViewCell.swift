//
//  TransactionCellsTableViewCell.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 5.04.2024.
//

import UIKit

class TransactionCellsTableViewCell: UITableViewCell {

    @IBOutlet weak var t_date: UILabel!
    @IBOutlet weak var t_status: UILabel!
    @IBOutlet weak var t_amount: UILabel!
    @IBOutlet weak var t_type: UILabel!
    @IBOutlet weak var t_hesaNo: UILabel!
    @IBOutlet weak var t_id: UILabel!
    @IBOutlet weak var cellBackground: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
