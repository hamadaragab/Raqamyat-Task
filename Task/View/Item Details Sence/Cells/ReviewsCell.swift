//
//  ReviewsCell.swift
//  Task
//
//  Created by Hamada Ragab on 10/12/2022.
//

import UIKit
import Cosmos
class ReviewsCell: UICollectionViewCell {
    
    @IBOutlet weak var rateDescription: UILabel!
    @IBOutlet weak var rateTitle: UILabel!
    @IBOutlet weak var rateView: CosmosView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func bindCell(review: Reviews) {
        rateTitle.text = review.title
        rateDescription.text = review.review
        rateView.rating = Double(review.rate ?? 0)
    }
    
}
