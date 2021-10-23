//
//  CarDetailsHelper.swift
//  SevenPeaksTask
//
//  Created by Adinarayana Machavarapu on 23/10/21.
//

import Foundation
import UIKit
import CoreData

class CarDetailsHelper {
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    /**
     This method is used to performBackgroundTask to fetch list of CarDetails Entity objects and adding to Car Model
     
     - parameter completion: Car Model
     
     - returns: Car Model
     */
    func fetchCarDetailsFromCoreData(completion: @escaping (Cars) -> ()) {
        self.appDelegate.persistentContainer.performBackgroundTask { (content) in
            let carsDetailsEntity = self.getDataFromDb()
            guard let carListEntity = carsDetailsEntity  else { return }
            var carResponseModel = Cars()
            var carContentModel = [CarContent]()
            for cars in carListEntity {
                var carContent = CarContent()
                carContent.title = cars.title
                carContent.id = cars.id
                carContent.image = cars.image_url
                carContent.ingress = cars.ingress
                carContent.changed = cars.changed
                carContent.created = cars.created
                carContentModel.append(carContent)
            }
            carResponseModel.content = carContentModel
            completion(carResponseModel)
        }
    }
    
    /**
     This method is used to save the list of CarContent object into core data
     
     - parameter carsModel: Car Model
     */
    func saveData(carsModel: Cars) {
        guard let carsList = carsModel.content else {
            return
        }
        let existingObjects = self.getDataFromDb()
        var alreadyExistObject = [Double:Double]()
        for i in existingObjects ?? [CarsDetails]() {
            alreadyExistObject[i.id] = i.changed
        }
        for car in carsList {
            if alreadyExistObject[car.id ?? -1] != car.changed {
            let carEntity = CarsDetails(context: self.managedContext)
            carEntity.date_time = car.dateTime
            carEntity.ingress = car.ingress
            carEntity.title = car.title
            carEntity.image_url = car.image
            carEntity.id = car.id ?? 0
            carEntity.changed = car.changed ?? 0
            }
        }
        self.saveCarItems()
    }
    
    /**
     This method is used to fetch list of CarDetails Entity object
     
     - returns: List of CarsDetails
     */
    private func getDataFromDb() -> [CarsDetails]? {
        let request : NSFetchRequest<CarsDetails> = CarsDetails.fetchRequest()
        return try? managedContext.fetch(request)
    }
    
    /**
     This is used to save Entity Objects if any  changes happed in NSManagedObjectContext
     */
    private func saveCarItems () {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                let error = error as NSError
                print("database error \(error), \(error.userInfo)")
            }
        }
    }

}
