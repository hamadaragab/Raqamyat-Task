//
//  ItemImageCell.swift
//  Task
//
//  Created by Hamada Ragab on 10/12/2022.
//

import UIKit

class ItemImageCell: UICollectionViewCell {

    @IBOutlet weak var itemImage: UIImageView!
     var itemImageUrl: String? {
        didSet {
            self.itemImage.setImage(with: itemImageUrl ?? "")
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
