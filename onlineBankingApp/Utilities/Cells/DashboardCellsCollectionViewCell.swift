//
//  DashboardCellsCollectionViewCell.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 22.04.2024.
//

import UIKit

class DashboardCellsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var account_ID: UILabel!
    @IBOutlet weak var account_no: UILabel!
    @IBOutlet weak var account_Name: UILabel!
    @IBOutlet weak var account_Type: UILabel!
    @IBOutlet weak var balance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
