//
//  NetworkingTests.swift
//  NovastoneCodeTestTests
//
//  Created by Anderson Gralha on 23/08/20.
//  Copyright © 2020 Anderson Gralha. All rights reserved.
//

import XCTest
import Nimble

@testable import NovastoneCodeTest

class NetworkingTests: XCTestCase {
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccessfulRequest() throws {
        
        let requestExpectation = expectation(description: "Successful request")
        
        let request = NetworkingController.TestRequest1()
        var data: Data?
        var error: Error?
        NetworkingController.shared.request(request) { (_data, _, _error) in
            data = _data
            error = _error
            requestExpectation.fulfill()
        }
        
        wait(for: [requestExpectation], timeout: 180.0)
        expect(data).toNot(beNil())
        expect(error).to(beNil())
        
    }

    func testFailRequest() throws {
        let requestExpectation = expectation(description: "Failed request")
        
        let request = NetworkingController.TestRequest2()
        var data: Data?
        var error: Error?
        NetworkingController.shared.request(request) { (_data, _, _error) in
            data = _data
            error = _error
            requestExpectation.fulfill()
        }
        
        wait(for: [requestExpectation], timeout: 180.0)
        expect(data).to(beNil())
        expect(error).toNot(beNil())
    }

}
