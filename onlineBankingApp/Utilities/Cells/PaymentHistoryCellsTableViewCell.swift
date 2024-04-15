//
//  PaymentHistory.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 15.04.2024.
//

import UIKit

class PaymentHistoryCellsTableViewCell: UITableViewCell {
    @IBOutlet weak var t_date: UILabel!
    @IBOutlet weak var t_status: UILabel!
    @IBOutlet weak var t_amount: UILabel!
    @IBOutlet weak var t_abonelik: UILabel!
    @IBOutlet weak var t_hesaNo: UILabel!
    @IBOutlet weak var t_id: UILabel!
    @IBOutlet weak var t_aboneNo: UILabel!
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
