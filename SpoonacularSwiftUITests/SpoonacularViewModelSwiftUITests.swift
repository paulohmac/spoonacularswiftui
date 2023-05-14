//
//  SpoonacularViewModelSwiftUITests.swift
//  SpoonacularSwiftUITests
//
//  Created by Paulo H.M. on 13/05/23.
//

import XCTest
@testable import SpoonacularSwiftUI


final class SpoonacularViewModelSwiftUITests: XCTestCase {

    var sut : MainSpoonacularViewModel?
    var sut2 : IngredientsViewModel?

    
    override func setUpWithError() throws {
        sut = MainSpoonacularViewModel()
        sut2 = IngredientsViewModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchByIngredients(){
        XCTAssertNoThrow(MainSpoonacularViewModel(), "create ingredints list")

        sut?.getFindRecipes(ingredients: "coffee")
        XCTAssertNotNil(sut?.recipeList, "fail recipeList")

        sut?.getFindRecipes(ingredients: "xxsxxa")
        XCTAssertTrue( sut?.recipeList.count == 0, "fail recipeList invalidList")

        sut?.getFindRecipes(ingredients: "")
        XCTAssertTrue( sut?.recipeList.count == 0, "fail recipeList without code")
    }

    func testRetriveIngredientsList(){

        XCTAssertNoThrow(IngredientsViewModel(), "create ingredints list")
        
        sut2?.listIngredients(idRecipe:  "1095997")
        XCTAssertNotNil(sut2?.ingredients, "fail ingredints list")

        sut2?.listIngredients(idRecipe:  "-6666")
        XCTAssertNotNil(sut2?.ingredients, "fail ingredints list invalid code")

        sut2?.listIngredients(idRecipe:  "")
        XCTAssertNotNil(sut2?.ingredients, "fail ingredints list without code")
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
