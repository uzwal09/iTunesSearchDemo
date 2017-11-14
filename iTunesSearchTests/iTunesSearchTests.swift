//
//  iTunesSearchTests.swift
//  iTunesSearchTests
//
//  Created by Uzwal on 5/26/17.
//  Copyright © 2017 PracticeSession. All rights reserved.
//

import XCTest
@testable import iTunesSearch

class iTunesSearchTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
      
      }
  
    func testForInstantingHomeViewController() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    let mainViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewControllerID") as! HomeViewController
    
    XCTAssertNotNil(mainViewController,"Need to instantiate HomeViewController")
  
  }
  
  func testForInstantingDetailViewController() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailedView") as! DetailViewController
    
    XCTAssertNotNil(detailViewController,"Need to instantiate DetailViewController")
    
  }
  
}
