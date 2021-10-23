//
//  CarsViewController.swift
//  SevenPeaksTask
//
//  Created by Adinarayana Machavarapu on 23/10/21.
//

import UIKit
import CoreData
import RxSwift
import RxCocoa

class CarsViewController: UIViewController {

    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    @IBOutlet weak var carsTableView     : UITableView!
    public var carsListViewModel = PublishSubject<[CarsDisplayViewModel]>()
    lazy var carViewModel: CarsViewModel = {
        return CarsViewModel()
    }()
    private let disposeBag = DisposeBag()
    private let cellReusableIdentifier   = "CarsTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupUI()
        self.setupBinding()
        self.carViewModel.fetchCarsList()
    }
    
    ///Manually Changing The StatusBarStyle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    /// Setup UI Called After The Controller's View Is loaded Into Memory.
    private func setupUI(){
        self.title = "Cars"
        let textAttributes = [NSAttributedString.Key.font:UIFont.customFont(.sfuiDisplayMedium, size: 17),NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.activityIndicator.center = self.view.center
    }
    
    
    /// Use a Binding To Create a Two-Way Connection Between a Property That Stores Data, And a View That Displays And Changes The Data.
    private func setupBinding(){
        
        carViewModel
            .showLoading
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { (status) in
                if (status){
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                } else {
                     self.activityIndicator.isHidden = false
                     self.activityIndicator.startAnimating()
                }
            })
            .disposed(by: disposeBag)
        
        carViewModel
            .presentError
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { (error) in
                self.popupAlert(title: error.title, message: error.message, actionTitles: ["Ok"], actions: [{
                    action in
                    print("Ok tapped")
                    }])
            })
            .disposed(by: disposeBag)
        
        carViewModel
            .carsDisplayViewModel
            .observe(on: MainScheduler.instance)
            .bind(to: self.carsListViewModel)
            .disposed(by: disposeBag)
        
        carsTableView.register(UINib(nibName: cellReusableIdentifier, bundle: nil), forCellReuseIdentifier: cellReusableIdentifier)
        
        carsListViewModel.bind(to: carsTableView.rx.items(cellIdentifier: cellReusableIdentifier, cellType: CarsTableViewCell.self)) {  (row, carModel, cell) in
            cell.carListViewModel = carModel
        }.disposed(by: disposeBag)
    }
}
