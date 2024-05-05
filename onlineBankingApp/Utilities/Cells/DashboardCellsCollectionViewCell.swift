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
        // Hücrenin köşe yarıçapını ayarla
        contentView.layer.cornerRadius = 20  // İstediğiniz köşe yarıçapını buraya yazabilirsiniz
        contentView.layer.masksToBounds = true
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: contentView.bounds,
                                        byRoundingCorners: [.bottomLeft, .bottomRight],
                                        cornerRadii: CGSize(width: 20, height: 20)).cgPath
        contentView.layer.mask = shapeLayer
        
        
    }
    
    
}
