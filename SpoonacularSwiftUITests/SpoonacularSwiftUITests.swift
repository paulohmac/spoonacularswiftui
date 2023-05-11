//
//  SpoonacularSwiftUITests.swift
//  SpoonacularSwiftUITests
//
//  Created by Paulo H.M. on 03/05/23.
//

import XCTest
import Alamofire
import Combine

@testable import SpoonacularSwiftUI

final class SpoonacularSwiftUITests: XCTestCase {

    var service : SpoonacularHttpService?
    
    override func setUpWithError() throws {
        service = SpoonacularHttpService()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDefaultParameters() throws {
        let parameters = service?.generateRequestParameters()
        XCTAssertNotNil( parameters , "Default parameters creation problem")
        XCTAssert( parameters?.count == 1 , "Default parameters problem")
        XCTAssertNotNil( parameters?[ServiceConfiguration.appClientKey] , "parameters app client key")
        XCTAssert( parameters?[ServiceConfiguration.appClientKey] as! String  == ServiceConfiguration.appClientKeyValue, "parameters app client key")
    }

    func testDefaultHeaders() throws {
        let parameters = service?.generateRequestHeaders()
        XCTAssertNotNil( parameters , "Default headers creation problem")
        XCTAssert( parameters?.count == 1 , "Default headers problem")
        XCTAssertNotNil( parameters?[ServiceConfiguration.headerKey] , "parameters app headers")
        XCTAssert( parameters?[ServiceConfiguration.headerKey] as! String  == ServiceConfiguration.headerValue, "parameters headers")
    }

    func testDefaultRequest() throws {
        let url = URL(string: ServiceConfiguration.searchUrl)!

        var parameters = service?.generateRequestParameters()
        
        let headers = (service?.generateRequestHeaders())
        
        if let headers, var parameters = parameters {
            XCTAssertNotNil( service?.sendRequest(url,
                               HTTPMethod.get,
                               headers,
                               &parameters) , "Default request notnull")
        }

    }

    func testRecipesRequest() throws {
        var cancellableSet: Set<AnyCancellable> = []

        let url = URL(string: ServiceConfiguration.searchUrl)!
        
        var parameters = "coffee"
        
        let headers = service?.generateRequestHeaders()
        if let headers {
            service?.getRecipes(ingredients: parameters)
            .sink { completion in
                var problem = false
                if case .failure(_) = completion   {
                    problem = true
                }
                XCTAssertFalse(problem , "Recipes request fail")
            } receiveValue: {[weak self] value in
                guard let self = self else { return }
                XCTAssertNotNil( value?.recipes  , "Recipes list is null")
            }
            .store(in: &cancellableSet)
        }
    }

    
    
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
