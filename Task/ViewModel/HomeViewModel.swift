//
//  HomeViewModel.swift
//  Task
//
//  Created by Hamada Ragab on 09/12/2022.
//

import Foundation
import RxSwift
import RxCocoa
class HomeViewModel {
     let itemsData = BehaviorRelay<[ItemsData]>(value: [])
     let loading: PublishSubject<Bool> = PublishSubject()
     let error : PublishSubject<Error> = PublishSubject()
     let fetchMoreDatas : PublishSubject<Void> = PublishSubject()
    private let disposable = DisposeBag()
    private var pageCounter = 1
    private var maxValue = 1
    init() {
        bind()
    }
    private func bind() {

        fetchMoreDatas.subscribe { [weak self] _ in
            guard let self = self else { return }
            self.requestData()
        }
        .disposed(by: disposable)
    }
    public func requestData(){
         if pageCounter > maxValue  {
            return
        }
        self.loading.onNext(true)
        APICaller<BaseResponse>.makeRequest(url: "https://macariastore.com/api/products/pages?category_id=5&page=\(pageCounter)", page: pageCounter, method: .get, paramters: [:]).subscribe { (result) in
            self.loading.onNext(false)
            switch result {
            case .error(let error):
            self.error.onNext(error)
            case .completed:
                print("")
            case .next(let model):
                self.handleItemsDataResponse(response: model)
            }
        }.disposed(by: disposable)
}
    private func handleItemsDataResponse(response: BaseResponse) {

        maxValue = response.item?.meta?.pagination?.total_pages ?? 1
        if pageCounter == 1, let finalData = response.item?.data {
            self.itemsData.accept(finalData)
        } else if let data = response.item?.data {
            let oldDatas =  self.itemsData.value
            self.itemsData.accept(oldDatas + data)
        }
        pageCounter += 1
    }
    
}
