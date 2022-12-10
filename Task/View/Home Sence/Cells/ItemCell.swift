//
//  ItemCell.swift
//  Task
//
//  Created by Hamada Ragab on 09/12/2022.
//

import UIKit
import Kingfisher
class ItemCell: UICollectionViewCell {

    @IBOutlet weak var favorriutImage: UIImageView!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    var FaveroiutTapped : (()->())?
     var itemData: ItemsData! {
        didSet {
            self.itemName.text = itemData.name ?? ""
            self.itemImage.setImage(with: itemData.image ?? "")
            self.itemPrice.text = itemData.price ?? ""
            itemData.is_fav == true ?  (favorriutImage.image = UIImage(named: "red Haert")) : (favorriutImage.image = UIImage(named: "white heart"))
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func FaveroiutDidTapped(_ sender: Any) {
        FaveroiutTapped?()
    }
    

}
