//
//  CarsViewModel.swift
//  SevenPeaksTask
//
//  Created by Adinarayana Machavarapu on 23/10/21.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import NetworkManager

protocol CarsViewModelProtocol {
    func fetchCarsList()
}

class CarsViewModel {
    let networkClient: NetworkClient
    private let dateFormatter    = DateFormatter()
    private let currentDateTime  = Date()
    private let currentCalendar  = Calendar.current
    private let disposeBag       = DisposeBag()
    private let carDetailsHelper = CarDetailsHelper()
    let showLoading              = BehaviorRelay<Bool>(value : true)
    var carsDisplayViewModel : PublishSubject<[CarsDisplayViewModel]> = PublishSubject()
    var presentError         : PublishSubject<ErrorViewModel>         = PublishSubject()
    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }
}
extension CarsViewModel: CarsViewModelProtocol {
    
    /**
     Fetch cars details from server and saving into core data and sorting data before going to display. Fetching data from core data when there is not internet connection and also checking the Car Details object is nil or empty before going to present error.
     */
    func fetchCarsList() {
        self.showLoading.accept(false)
        networkClient.request(type: Cars.self, service: ApiRequestEndpoints.getCarsList) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case.success(let response):
                DispatchQueue.main.async {
                    self.showLoading.accept(true)
                    self.carDetailsHelper.saveData(carsModel: response)
                    self.carsDisplayViewModel.onNext(self.getCarListViewModelData(response: response))

                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showLoading.accept(true)
                    self.carDetailsHelper.fetchCarDetailsFromCoreData { (model) in
                        guard model.content != nil, !(model.content?.isEmpty ?? true) else {
                            var errorObject = ErrorViewModel(title: nil, message: NetworkError.getTheErrorMessage(error: error))
                            if errorObject.message != internetErrorFromNetwork {
                                errorObject = ErrorViewModel(title: nil, message: noDataAvailableError)
                            }
                            self.presentError.onNext(errorObject)
                            return
                        }
                        self.carsDisplayViewModel.onNext(self.getCarListViewModelData(response: model))
                    }
                }
            }
        }
    }
    
    
    /**
     This method used to create list of CarsDisplayViewModel with required properties and sorting data descending order
     
     - parameter response: Cars Model
     
     - returns: Array of CarsDisplayViewModel
     */
    func getCarListViewModelData(response: Cars) -> [CarsDisplayViewModel]{
        var carObjects = [CarsDisplayViewModel]()
        for i in response.content ?? [CarContent]() {
            let dateTime =  changeDateFormat(dateString: i.dateTime ?? "")
            let object = CarsDisplayViewModel(id:i.id ?? 0, title: i.title ?? "", dateTime: dateTime ?? "", ingress: i.ingress ?? "", imageUrl: i.image ?? "")
            carObjects.append(object)
        }
        return carObjects.sorted(by: { $0.id > $1.id })
    }
    
    /**
     Format date with string as per requirement
     
     - parameter dateString: dateString
     
     - returns: Formatted date string
     */
    func changeDateFormat(dateString: String) -> String? {
        dateFormatter.dateFormat = CarsDateFormatter.dateFromApi
        let date = dateFormatter.date(from: dateString)
        if let date = date {
            let dateYear = currentCalendar.component(Calendar.Component.year, from: date)
            let currentDateYear = currentCalendar.component(Calendar.Component.year, from: currentDateTime)
            if dateYear == currentDateYear {
                dateFormatter.dateFormat = CarsDateFormatter.sameYearFormat
                return dateFormatter.string(from: date) + ", \(getTimeFromDate(date: date))"
            } else {
                dateFormatter.dateFormat = CarsDateFormatter.differentYearFormat
                return dateFormatter.string(from: date) + ", \(getTimeFromDate(date: date))"
            }
        }
        return nil
    }
    
    /**
     Get the time from date based on the  device settings
     
     - parameter date: Date
     
     - returns: Formatted time string
     */
    private func getTimeFromDate(date: Date) -> String {
        dateFormatter.setLocalizedDateFormatFromTemplate(CarsDateFormatter.diviceSettingTime)
        return  dateFormatter.string(from: date)
    }
}
