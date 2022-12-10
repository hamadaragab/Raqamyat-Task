//
//  HomeRouter.swift
//  Task
//
//  Created by Hamada Ragab on 10/12/2022.
//

import Foundation
import UIKit
protocol HomeRouterProtocol : class{
    func routeToItemDetails(itemDetails: ItemsData)
}

class HomeRouter: HomeRouterProtocol {
    var viewController: HomeViewViewController!
    init(viewController: HomeViewViewController) {
        self.viewController = viewController
    }
    func routeToItemDetails(itemDetails: ItemsData){
        let detailVC = ItemDetailsView.init()
        detailVC.itemDetailsViewModel.itemsData.onNext(itemDetails)
        self.viewController.navigationController?.pushViewController(detailVC, animated: true)
    }

}
