//
//  NetworkingUniversitiesTests.swift
//  NovastoneCodeTestTests
//
//  Created by Anderson Gralha on 23/08/20.
//  Copyright © 2020 Anderson Gralha. All rights reserved.
//

import XCTest
import Nimble

@testable import NovastoneCodeTest

class NetworkingUniversitiesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchUniversities() throws {
        let requestExpectation = expectation(description: "Request should finish with success")
        var universities: [University] = []
        NetworkingController.shared.fetchUniversities { result in
            switch result {
            case .success(let _universities):
                universities = _universities
                requestExpectation.fulfill()
            case .failure:
                fail()
            }
        }
        wait(for: [requestExpectation], timeout: 180.0)
        expect(universities.count) > 0
    }

}
