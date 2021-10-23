//
//  SevenPeaksTaskTests.swift
//  SevenPeaksTaskTests
//
//  Created by Adinarayana Machavarapu on 23/10/21.
//

import Foundation
@testable import SevenPeaksTask

class CarsData {
   static let viewModel = CarsViewModel()
    class func mockLocationDisplayModel() -> [CarsDisplayViewModel]? {
        let jsonData = CarsData.getDataFromJson()
        if jsonData != nil {
            let json = try! JSONDecoder().decode(Cars.self, from: jsonData!)
           return viewModel.getCarListViewModelData(response: json)
        }
        return nil
    }
     func getCarListViewModelData(response: Cars) -> [CarsDisplayViewModel]{
        var carObjects = [CarsDisplayViewModel]()
        for i in response.content ?? [CarContent]() {
            let dateTime =  CarsData.viewModel.changeDateFormat(dateString: i.dateTime ?? "")
            let object = CarsDisplayViewModel(id:i.id ?? 0, title: i.title ?? "", dateTime: dateTime ?? "", ingress: i.ingress ?? "", imageUrl: i.image ?? "")
            carObjects.append(object)
        }
        return carObjects.sorted(by: { $0.id > $1.id })
    }
    
    class func getDataFromJson() -> Data? {
       if let path = Bundle(for: self).path(forResource: "locations", ofType: "json") {
            do {
                return try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            } catch {
                return nil
            }
        }
        return nil
    }
    
}
