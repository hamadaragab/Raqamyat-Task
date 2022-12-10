//
//  ItemSizeCell.swift
//  Task
//
//  Created by Hamada Ragab on 10/12/2022.
//

import UIKit

class ItemSizeCell: UICollectionViewCell {

    @IBOutlet weak var sizeName: UILabel!
     var size: String? {
        didSet {
            sizeName.text = size ?? ""
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
