//
//  APODServiceTests.swift
//  APOD
//
//  Created by Fabricio Pujol on 18/02/25.
//

import XCTest
import OHHTTPStubs
@testable import APOD

final class APODServiceTests: XCTestCase {
    
    var apodService: APODService!

    override func setUpWithError() throws {
        apodService = APODService()
    }

    override func tearDownWithError() throws {
        apodService = nil
    }

    func testGetAPODSucess() throws {
        let expectation = self.expectation(description: "fetch APOD")
        
        apodService.getAPOD { result in
            switch result {
            case .success(let success):
                XCTAssertNotNil(success, "Success não pode ser nil!!")
                expectation.fulfill()
            case .failure:
                XCTFail("A request não pode cair no caso de failure.")
            }
        }
        waitForExpectations(timeout: 10)
    }
    
    func testGetAPODFailure() throws {
        let expectation = self.expectation(description: "fetch APOD failure")
        
        HTTPStubs.stubRequests { request in
            request.url?.absoluteString.contains("https://api.nasa.gov/planetary/apod?api_key=0LkAF0pB3OzKR35aMoxV6u1n61keu1hgY231CH4L&thumbs=true") ?? false
        } withStubResponse: { _ in
            return HTTPStubsResponse(error: NSError(domain: "com.test.error", code: 404))
        }
        
        apodService.getAPOD { result in
            switch result {
            case .success:
                XCTFail("A request não pode cair no caso de success.")
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
        HTTPStubs.removeAllStubs()
    }
    
    func testGetAPODByDateSucess() throws {
        let expectation = self.expectation(description: "fetch APOD By Date")
        
        apodService.getAPODByDate(date: "2025-02-16") { result in
            switch result {
            case .success(let success):
                XCTAssertNotNil(success, "Success não pode ser nil!!")
                expectation.fulfill()
            case .failure:
                XCTFail("A request não pode cair no caso de failure.")
            }
        }
        waitForExpectations(timeout: 10)
    }
    
    func testGetAPODByDateFailure() throws {
        let expectation = self.expectation(description: "fetch APOD By Date failure")
        
        HTTPStubs.stubRequests { request in
            request.url?.absoluteString.contains("https://api.nasa.gov/planetary/apod?api_key=0LkAF0pB3OzKR35aMoxV6u1n61keu1hgY231CH4L&date=") ?? false
        } withStubResponse: { _ in
            return HTTPStubsResponse(error: NSError(domain: "com.test.error", code: 404))
        }
        
        apodService.getAPODByDate(date: "2025-02-16") { result in
            switch result {
            case .success:
                XCTFail("A request não pode cair no caso de success.")
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
        HTTPStubs.removeAllStubs()
    }

}
