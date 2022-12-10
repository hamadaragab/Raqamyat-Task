//
//  ItemColorCell.swift
//  Task
//
//  Created by Hamada Ragab on 10/12/2022.
//

import UIKit

class ItemColorCell: UICollectionViewCell {

    @IBOutlet weak var itemColor: UILabel!
     var itemColorHex: String? {
        didSet {
            self.itemColor.backgroundColor = UIColor(hexString: itemColorHex ?? "")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
