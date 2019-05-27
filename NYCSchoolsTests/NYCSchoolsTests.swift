//
//  _0190525_AndriiKurshyn_NYCSchoolsTests.swift
//  20190525-AndriiKurshyn-NYCSchoolsTests
//
//  Created by Andrii Kurshyn on 5/25/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import XCTest
@testable import _0190525_AndriiKurshyn_NYCSchools

class NYCSchoolsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testVerifySchoolsAndScore() {
        
        let mock = Mock.schools
        MockURLProtocol.register(with: mock.data)
        
        let expectation = self.expectation(description: "APIRequest Schools did not complete")
        let request = APIRequest.schools
        request.get([School].self) { (schools, error) in
            
            XCTAssertNil(error, "ASSERT ERROR: execute completion should not have returned an error")
            XCTAssertNotNil(schools, "ASSERT ERROR: execute completion should have returned valid results")
            XCTAssert(schools!.count == mock.count, "ASSERT ERROR: execute completion's schools should be == \(mock.count)")
            
            for i in 0..<schools!.count {
                Validation.validation(schools![i], moc: mock[i])
            }
            
            let school = schools![0]
            let firstScore = Mock.score
            MockURLProtocol.responseData = firstScore.data
            school.fetchScore(completion: { (score, error) in
                XCTAssertNil(error, "ASSERT ERROR: execute completion should not have returned an error")
                XCTAssertNotNil(score, "ASSERT ERROR: execute completion should have returned valid results")
                Validation.validation(score, moc: firstScore.first!)
                
                expectation.fulfill()
            })
        }
        
        self.waitForExpectations(timeout: 10, handler: { error in
            MockURLProtocol.unregister()
        })
    }

}
