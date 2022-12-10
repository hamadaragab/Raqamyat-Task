//
//  ItemDetailsView.swift
//  Task
//
//  Created by Hamada Ragab on 09/12/2022.
// ReviewsCell

import UIKit
import RxSwift
import RxCocoa
import Cosmos
class ItemDetailsView: UIViewController {
    
    @IBOutlet weak var itemQuntity: UILabel!
    @IBOutlet weak var pageCcontrrol: UIPageControl!
    @IBOutlet weak var suggestItemsCollecction: UICollectionView!
    @IBOutlet weak var reviewsCollection: UICollectionView!
    @IBOutlet weak var descriptionLBL: UILabel!
    @IBOutlet weak var colorsCollection: UICollectionView!
    @IBOutlet weak var sizeCollection: UICollectionView!
    @IBOutlet weak var reviewsCount: UILabel!
    @IBOutlet weak var itemRating: CosmosView!
    @IBOutlet weak var itemOldPrice: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemImagesCollection: UICollectionView!
    let quntity = BehaviorRelay<String>(value: "0")
    private let disposeBag = DisposeBag()
    var itemDetailsViewModel = ItemDetailsViewModel()
    var router: ItemDetailsRouterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        bindItemDetailsData()
        itemDetailsViewModel.subscribeToItemData()
        registerCollectionViewCells()
        bindItemImagesCollections()
        bindItemSizeCollections()
        bindItemColorCollections()
        bindItemReviewCollections()
        bindSuggestedItemsCollections()
    }
    @IBAction func backDidTapped(_ sender: Any) {
        router?.popUpToHomeView()
    }
    
    @IBAction func minusDidTapped(_ sender: Any) {
        let currentValue = Int(quntity.value) ?? 0
        if currentValue > 0 {
            quntity.accept("\(currentValue - 1)")
        }
    }
    @IBAction func plusDidTapped(_ sender: Any) {
        let currentValue = Int(quntity.value) ?? 0
        quntity.accept("\(currentValue + 1)")
    }
    private func setUpView() {
        router = ItemDetailsRouterRouter(viewController: self)
        quntity.bind(to: itemQuntity.rx.text).disposed(by: disposeBag)
    }
    private func registerCollectionViewCells() {
        itemImagesCollection.register(UINib(nibName: "ItemImageCell", bundle: nil), forCellWithReuseIdentifier: String(describing: ItemImageCell.self))
        sizeCollection.register(UINib(nibName: "ItemSizeCell", bundle: nil), forCellWithReuseIdentifier: String(describing: ItemSizeCell.self))
        colorsCollection.register(UINib(nibName: "ItemColorCell", bundle: nil), forCellWithReuseIdentifier: String(describing: ItemColorCell.self))
        reviewsCollection.register(UINib(nibName: "ReviewsCell", bundle: nil), forCellWithReuseIdentifier: String(describing: ReviewsCell.self))
        suggestItemsCollecction.register(UINib(nibName: "ItemCell", bundle: nil), forCellWithReuseIdentifier: String(describing: ItemCell.self))
    }
    private func bindItemDetailsData() {
        itemDetailsViewModel.itemDataDescrption.subscribe { [weak self] item in
            guard let itemDetails = item.element, let self = self else { return }
            self.itemName.text = itemDetails?.name ?? ""
            self.itemPrice.text = itemDetails?.price ?? ""
            self.itemOldPrice.text = itemDetails?.old_price ?? ""
            self.reviewsCount.text = "\(itemDetails?.review_count ?? 0) Reviews"
            self.itemRating.rating = Double(itemDetails?.rate ?? 0)
            self.descriptionLBL.text = itemDetails?.description ?? ""
            self.pageCcontrrol.numberOfPages = itemDetails?.images?.count ?? 0
        }.disposed(by: disposeBag)
    }
    private func bindItemImagesCollections() {
        itemDetailsViewModel
            .itemsImages
            .observe(on: MainScheduler.instance)
            .bind(to: itemImagesCollection.rx.items(cellIdentifier: "ItemImageCell", cellType: ItemImageCell.self)) {  (row,image,cell) in
                cell.itemImageUrl = image
            }.disposed(by: disposeBag)
        itemImagesCollection.rx.willDisplayCell
                    .observeOn(MainScheduler.instance)
                    .subscribe(onNext: { [weak self] (cell, indexPath) in
                        self?.pageCcontrrol.currentPage = indexPath.row
                     }).disposed(by: disposeBag)
        itemImagesCollection.rx.setDelegate(self).disposed(by: disposeBag)
    }
    private func bindItemSizeCollections() {
        itemDetailsViewModel
            .itemsSize
            .observe(on: MainScheduler.instance)
            .bind(to: sizeCollection.rx.items(cellIdentifier: "ItemSizeCell", cellType: ItemSizeCell.self)) {  (row,size,cell) in
                cell.size = size.name ?? ""
            }.disposed(by: disposeBag)
        sizeCollection.rx.setDelegate(self).disposed(by: disposeBag)
    }
    private func bindItemColorCollections() {
        itemDetailsViewModel
            .itemsColors
            .observe(on: MainScheduler.instance)
            .bind(to: colorsCollection.rx.items(cellIdentifier: "ItemColorCell", cellType: ItemColorCell.self)) {  (row,color,cell) in
                cell.itemColorHex = color.color_hex
            }.disposed(by: disposeBag)
        colorsCollection.rx.setDelegate(self).disposed(by: disposeBag)
    }
    private func bindItemReviewCollections() {
        itemDetailsViewModel
            .itemsReviews
            .observe(on: MainScheduler.instance)
            .bind(to: reviewsCollection.rx.items(cellIdentifier: "ReviewsCell", cellType: ReviewsCell.self)) {  (row,review,cell) in
                cell.bindCell(review: review)
            }.disposed(by: disposeBag)
        reviewsCollection.rx.setDelegate(self).disposed(by: disposeBag)
    }
    private func bindSuggestedItemsCollections() {
        itemDetailsViewModel
            .suggestedItems
            .observe(on: MainScheduler.instance)
            .bind(to: suggestItemsCollecction.rx.items(cellIdentifier: "ItemCell", cellType: ItemCell.self)) {  (row,suggestedItem,cell) in
                cell.itemData = suggestedItem
            }.disposed(by: disposeBag)
        suggestItemsCollecction.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
}
extension ItemDetailsView :UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = 0.0
        var height = 0.0
        if collectionView == itemImagesCollection {
         width = collectionView.bounds.width
         height = collectionView.bounds.height
        } else if collectionView == sizeCollection  {
             width = 70
             height = sizeCollection.bounds.height
        }else if collectionView == colorsCollection {
            width = 30
            height = colorsCollection.bounds.height
        }else if collectionView == reviewsCollection {
            width = reviewsCollection.bounds.width
            height = reviewsCollection.bounds.height
        }else {
             width = (collectionView.bounds.width - 20) / 2
            height = 270
        }
        return CGSize(width: width, height: height)
    }
}
