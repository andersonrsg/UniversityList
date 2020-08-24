//
//  UniversityListViewModelTests.swift
//  NovastoneCodeTestTests
//
//  Created by Anderson Gralha on 23/08/20.
//  Copyright © 2020 Anderson Gralha. All rights reserved.
//

import XCTest
import Nimble

@testable import NovastoneCodeTest

class UniversityListViewModelTests: XCTestCase {

    let testJson = """
    [{ "web_pages": [ "http://www.marywood.edu" ], "name": "Marywood University", "alpha_two_code": "PA", "state-province": null, "domains": [ "marywood.edu" ], "country": "United States" }, { "web_pages": [ "https://www.cstj.qc.ca", "https://ccmt.cstj.qc.ca", "https://ccml.cstj.qc.ca" ], "name": "Cégep de Saint-Jérôme", "alpha_two_code": "CA", "state-province": null, "domains": [ "cstj.qc.ca" ], "country": "Canada" }, { "web_pages": [ "http://www.lindenwood.edu/" ], "name": "Lindenwood University", "alpha_two_code": "US", "state-province": null, "domains": [ "lindenwood.edu" ], "country": "United States" }]
    """
    
    var viewModel: UniversityListViewModel!
    
    override func setUpWithError() throws {
        let jsonData = testJson.data(using: .utf8)!
        let universities: [University] = try! JSONDecoder().decode([University].self, from: jsonData)
        viewModel = UniversityListViewModel(universities: universities)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchUniversities() throws {
        let requestExpectation = expectation(description: "Successful Fetch Universities")
        var result: UniversityListViewModel.FetchUniversitiesResult?
        
        viewModel.fetchUniversities { (_result) in
            result = _result
            requestExpectation.fulfill()
        }
        
        wait(for: [requestExpectation], timeout: 180.0)
        expect(result) == .success
        
    }

    // Make sure the viewmodel is able to search phrases, words, incomplete words, and doesn't consider letter case
    func testFilteredData() throws {
        let data = viewModel.filteredData("United States")
        expect(data.count).to(equal(3))
        
        let data2 = viewModel.filteredData("united states")
        expect(data2.count).to(equal(3))
        
        let data3 = viewModel.filteredData("canada")
        expect(data3.count).to(equal(2))
        
        let data4 = viewModel.filteredData("cana")
        expect(data4.count).to(equal(2))
        
        let data5 = viewModel.filteredData("CANADA")
        expect(data5.count).to(equal(2))
    }
    
    // Make sure the viewModel is filtering the searchable parameters
    func testFilteredParameters() throws {
        let name = viewModel.filteredData("Marywood University")
        expect(name.count).to(equal(2))
        
        let country = viewModel.filteredData("united states")
        expect(country.count).to(equal(3))
        
        let alphaTwo = viewModel.filteredData("CA")
        expect(alphaTwo.count).to(equal(2))
        
        let name2 = viewModel.filteredData("unknown")
        expect(name2.count).to(equal(1))
    }

}
