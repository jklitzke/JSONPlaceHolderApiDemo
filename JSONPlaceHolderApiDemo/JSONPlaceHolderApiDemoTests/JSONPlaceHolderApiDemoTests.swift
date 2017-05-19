//
//  JSONPlaceHolderApiDemoTests.swift
//  JSONPlaceHolderApiDemoTests
//
//  Created by James Klitzke on 1/18/17.
//  Copyright © 2017 James Klitzke. All rights reserved.
//

import XCTest
@testable import JSONPlaceHolderApiDemo

class MasterViewControllerTests: XCTestCase {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    var viewController : MasterViewController = MasterViewController()
    
    override func setUp() {
        super.setUp()
    
        viewController = storyboard.instantiateViewController(withIdentifier: "Master") as! MasterViewController
        viewController.jsonServices = JSONPlaceHolderServicesMock()
        viewController.loadView()
        viewController.viewDidLoad()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTableView_WithSingleUser_ShouldContainOneRow() {
        XCTAssertEqual(viewController.tableView(viewController.tableView, numberOfRowsInSection: 0), 1)
    }
    
    func testTableViewCell_WithValidUser_ShouldShowUserName() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(cell.textLabel?.text, "jdoe153")
    }
    
}

class DetailViewControllerTests : XCTestCase {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    var viewController : DetailViewController = DetailViewController()
    
    override func setUp() {
        super.setUp()
        
        viewController = storyboard.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
        viewController.user = JSONPlaceHolderServicesMock.mockUser()
        viewController.loadView()
        viewController.viewDidLoad()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDetailViewController_ShouldShowUserAddress() {
        
        guard let street = viewController.user?.address?.street,
              let city = viewController.user?.address?.city,
              let zipcode = viewController.user?.address?.zipcode,
              let textField = viewController.detailDescriptionLabel.text else {
                XCTFail("Failed to unwrap street, city and zip strings!")
                return
        }
        
        XCTAssertEqual(textField, "Address: \(street), \(city), \(zipcode)")
        
    }

}
