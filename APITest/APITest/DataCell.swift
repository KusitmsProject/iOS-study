//
//  DataCell.swift
//  APITest
//
//  Created by 오예진 on 2022/10/24.
//

import UIKit

class DataCell: UICollectionViewCell {
    @IBOutlet weak var userID: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var createLabel: UILabel!
    @IBOutlet weak var updateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
