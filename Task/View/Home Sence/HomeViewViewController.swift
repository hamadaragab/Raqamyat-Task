//
//  HomeViewViewController.swift
//  Task
//
//  Created by Hamada Ragab on 08/12/2022.
//

import UIKit
import RxCocoa
import RxSwift
import iOSDropDown
class HomeViewViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var resultTextFiedl: DropDown!
    @IBOutlet weak var sortTextField: DropDown!
    @IBOutlet weak var filterTextFiled: DropDown!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    private let disposeBag = DisposeBag()
    var homeViewModel = HomeViewModel()
    var router: HomeRouterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        didFailsGettingitems()
        configureItemsCollectionView()
        setupBindings()
        homeViewModel.requestData()
        setUpTextFileds()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func resultDidTapped(_ sender: Any) {
        self.resultTextFiedl.showList()
    }
    @IBAction func filterDidTapped(_ sender: Any) {
        self.filterTextFiled.showList()
    }
    @IBAction func sortDidTapped(_ sender: Any) {
        self.sortTextField.showList()
    }
    private func configureView() {
        loader.hidesWhenStopped = true
        self.navigationController?.navigationBar.isHidden = true
        router = HomeRouter(viewController: self)
    }
    private func setUpTextFileds() {
        // static Data for Drop Down items
        filterTextFiled.optionArray = ["Filter 1", "Filter 2", "Filter 3"]
        sortTextField.optionArray = ["Sort 1", "Sort 2", "Sort 3"]
        resultTextFiedl.optionArray = ["Result 1", "Result 2", "Result 3"]
    }
    private func didFailsGettingitems() {
        homeViewModel.error.subscribe { [weak self] error in
            guard let error = error.element,
                  let self = self else { return }
            self.showAlert(message: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    private func setupBindings() {
        homeViewModel
            .itemsData
            .observe(on: MainScheduler.instance)
            .bind(to: itemsCollectionView.rx.items(cellIdentifier: "ItemCell", cellType: ItemCell.self)) {  (row,item,cell) in
                cell.itemData = item
            }.disposed(by: disposeBag)
        itemsCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        // handle pagetion when reach to bottom of collecctionView
        itemsCollectionView.rx.didScroll.subscribe { [weak self] _ in
            guard let self = self else { return }
            let offSetY = self.itemsCollectionView.contentOffset.y
            let contentHeight = self.itemsCollectionView.contentSize.height

            if offSetY == (contentHeight - self.itemsCollectionView.frame.size.height) {
                self.homeViewModel.fetchMoreDatas.onNext(())
            }
        }.disposed(by: disposeBag)
        homeViewModel.loading.subscribe { [weak self] is_Loading in
            guard let is_Loading = is_Loading.element,
                  let self = self else { return }
            if is_Loading {
                self.loader.startAnimating()
            }else {
                self.loader.stopAnimating()
            }
        }.disposed(by: disposeBag)
        itemsCollectionView
            .rx
            .modelSelected(ItemsData.self)
            .subscribe(onNext: { selectedItem in
                self.router?.routeToItemDetails(itemDetails: selectedItem)
            }).disposed(by: disposeBag)
       
    }
    private func configureItemsCollectionView() {
        itemsCollectionView.register(UINib(nibName: "ItemCell", bundle: nil), forCellWithReuseIdentifier: String(describing: ItemCell.self))
    }
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Waring", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }
}

extension HomeViewViewController :UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let cellWidth = (width - 20) / 2 
        return CGSize(width: cellWidth, height: 270)
    }
}
