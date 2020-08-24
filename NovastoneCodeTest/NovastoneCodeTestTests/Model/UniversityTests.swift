//
//  UniversityTests.swift
//  NovastoneCodeTestTests
//
//  Created by Anderson Gralha on 23/08/20.
//  Copyright © 2020 Anderson Gralha. All rights reserved.
//

import XCTest
import Nimble

@testable import NovastoneCodeTest

class UniversityTests: XCTestCase {

    let testJson = """
    { "web_pages": [ "http://www.marywood.edu" ], "name": "Marywood University", "alpha_two_code": "PA", "state-province": "CA", "domains": [ "marywood.edu" ], "country": "United States" }
    """
    
    var testUniversity: University!
    
    override func setUpWithError() throws {
        let jsonData = testJson.data(using: .utf8)!
        testUniversity = try! JSONDecoder().decode(University.self, from: jsonData)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Make sure the model returns correct filter string
    func testFilteredParameters() throws {
        expect(self.testUniversity.searchString).to(contain(testUniversity.name!.lowercased()))
        expect(self.testUniversity.searchString).to(contain(testUniversity.alphaTwoCode!.lowercased()))
        expect(self.testUniversity.searchString).to(contain(testUniversity.country!.lowercased()))
        expect(self.testUniversity.searchString).toNot(contain(testUniversity.webPages!))
        expect(self.testUniversity.searchString).toNot(contain(testUniversity.stateProvince!))
        expect(self.testUniversity.searchString).toNot(contain(testUniversity.webPages!.joined(separator: " ")))
        expect(self.testUniversity.searchString).toNot(contain(testUniversity.domains!.joined(separator: " ")))
    }

}
