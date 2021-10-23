//
//  SevenPeaksTaskTests.swift
//  SevenPeaksTaskTests
//
//  Created by Adinarayana Machavarapu on 23/10/21.
//

import XCTest
@testable import SevenPeaksTask

class CarsViewModeTests: XCTestCase {
  
    var carsViewModel: CarsViewModel!
    var mockApiManager: MockApiManager!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockApiManager = MockApiManager()
        carsViewModel = CarsViewModel(networkClient: mockApiManager)
    }
    
    func testFetchCarSuccess() {
        let success = expectation(description: "fetchCars")
        Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { _ in
            success.fulfill()
        }
        mockApiManager.isShowErrorForLocations = false
        carsViewModel.fetchCarsList()
        waitForExpectations(timeout: 15, handler: nil)
        XCTAssertNotNil(carsViewModel.carsDisplayViewModel)
    }
    
    func testFetchCarsFail() {
        let completedExpectation = expectation(description: "showError")
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            completedExpectation.fulfill()
        }
        mockApiManager.isShowErrorForLocations = true
        carsViewModel.fetchCarsList()
        waitForExpectations(timeout: 8, handler: nil)
        XCTAssertNotNil(carsViewModel.carsDisplayViewModel)
    }
    
    func testDateForSameYear() {
        let str = carsViewModel.changeDateFormat(dateString: "01.10.2021 15:05")
        XCTAssertEqual(str, "01 October, 3:05 PM")
    }
    
    func testDateForDifferentYear() {
       let str = carsViewModel.changeDateFormat(dateString: "01.10.2020 15:05")
       XCTAssertEqual(str, "01 October 2020, 3:05 PM")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        carsViewModel = nil
    }



}
