//
//  SevenPeaksTaskTests.swift
//  SevenPeaksTaskTests
//
//  Created by Adinarayana Machavarapu on 23/10/21.
//

import XCTest
import NetworkManager
@testable import SevenPeaksTask

class MockApiManager: NetworkClient {
 
    var isShowErrorForLocations = false
    var isShowNetworkError = false

    func request<T>(type: T.Type, service: EndpointProtocol, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        if !isShowErrorForLocations {
            isShowErrorForLocations = false
            let jsonData = CarsData.getDataFromJson()
            if jsonData != nil {
                let json = try! JSONDecoder().decode(type, from: jsonData!)
                completion(.success(json))
            } else {
                completion(.failure(.generalError))
            }
        } else if isShowNetworkError {
            isShowNetworkError = false
            completion(.failure(.noInternet))
        } else {
            completion(.failure(.generalError))
        }
    }
}
