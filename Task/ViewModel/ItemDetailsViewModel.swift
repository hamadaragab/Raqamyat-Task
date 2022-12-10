//
//  ItemDetailsViewModel.swift
//  Task
//
//  Created by Hamada Ragab on 10/12/2022.
//

import Foundation
import RxSwift
import RxCocoa
class ItemDetailsViewModel {
    public let itemsData :PublishSubject<ItemsData> = PublishSubject()
     let itemsImages = BehaviorRelay<[String]>(value: [])
     let itemsSize = BehaviorRelay<[Sizes]>(value: [])
     let itemsColors = BehaviorRelay<[Colors]>(value: [])
     let itemsReviews = BehaviorRelay<[Reviews]>(value: [])
     let suggestedItems = BehaviorRelay<[ItemsData]>(value: [])
     let itemDataDescrption: BehaviorRelay<ItemsData?> = BehaviorRelay(value: nil)
    private let disposable = DisposeBag()
    init() {
        subscribeToItemData()
    }
    func subscribeToItemData() {
        itemsData.subscribe{ [weak self] itemData in
            guard let itemData = itemData.element,
                  let self = self else { return }
            self.itemDataDescrption.accept(itemData)
            self.itemsImages.accept(itemData.images ?? [])
            self.itemsSize.accept(itemData.sizes ?? [])
            self.itemsColors.accept(itemData.colors ?? [])
            self.itemsReviews.accept(itemData.reviews ?? [])
            self.suggestedItems.accept(itemData.suggestedProducts?.data ?? [])
        }.disposed(by: disposable)
    }
    
}
