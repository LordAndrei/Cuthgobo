//
//  WothcocuTests.swift
//  CuthgoboTests
//
//  Created by Andrei Freeman on 8/22/20.
//

import XCTest
@testable import Cuthgobo

class WothcocuTests: XCTestCase {
    
    var wothcocu = Wothcocu()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testConvertToDirection() throws {
        // func convertToDirection(distance: CGFloat) -> Int {
        
        var testDistance: CGFloat = -7.345
        XCTAssertEqual(wothcocu.convertToDirection(distance: testDistance), -1)
        
        testDistance = 0.0
        XCTAssertEqual(wothcocu.convertToDirection(distance: testDistance), 0)
        
        testDistance = 45.139
        XCTAssertEqual(wothcocu.convertToDirection(distance: testDistance), 1)
        
        testDistance = 0.034
        XCTAssertEqual(wothcocu.convertToDirection(distance: testDistance), 0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
