//
//  ItemDetailsRouter.swift
//  Task
//
//  Created by Hamada Ragab on 10/12/2022.
//

import Foundation
import UIKit
protocol ItemDetailsRouterProtocol : class{
    func popUpToHomeView()
}

class ItemDetailsRouterRouter: ItemDetailsRouterProtocol {
    var viewController: ItemDetailsView!
    init(viewController: ItemDetailsView) {
        self.viewController = viewController
    }
    func popUpToHomeView(){
        self.viewController.navigationController?.popViewController(animated: true)
    }

}
