//
//  SevenPeaksTaskTests.swift
//  SevenPeaksTaskTests
//
//  Created by Adinarayana Machavarapu on 23/10/21.
//

import XCTest
@testable import SevenPeaksTask

class CarViewControllerTests: XCTestCase {

    var carsViewController : CarsViewController!
    var carsViewModel: CarsViewModel!
    var mockApiManager : MockApiManager!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        carsViewController = storyboard.instantiateViewController(withIdentifier: "CarsViewController") as? CarsViewController
        carsViewController.loadView()
        mockApiManager = MockApiManager()
        carsViewModel = CarsViewModel(networkClient: mockApiManager)
        carsViewController.carViewModel = carsViewModel
    }

    func testViewDidLoad() {
        carsViewController.viewDidLoad()
        let statusBarStyle = carsViewController.preferredStatusBarStyle
        XCTAssertEqual(statusBarStyle, UIStatusBarStyle.lightContent)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        carsViewController = nil
    }
}
