//
//  MealDBAPIServiceTests.swift
//  FetchMealsTests
//
//  Created by Joe Bonniwell on 2/28/22.
//

import XCTest
@testable import FetchMeals


let sampleCategoryJSONData = """
{
    \"categories\":[
        {
            \"idCategory\":\"1\",
            \"strCategory\":\"Beef\",
            \"strCategoryThumb\":\"https:\\/\\/www.themealdb.com\\/images\\/category\\/beef.png\",
            \"strCategoryDescription\":\"Beef is the culinary name for meat from cattle, particularly skeletal muscle. Humans have been eating beef since prehistoric times.[1] Beef is a source of high-quality protein and essential nutrients.[2]\"
        },
        {
            \"idCategory\":\"2\",
            \"strCategory\":\"Chicken\",
            \"strCategoryThumb\":\"https:\\/\\/www.themealdb.com\\/images\\/category\\/chicken.png\",
            \"strCategoryDescription\":\"Chicken is a type of domesticated fowl, a subspecies of the red junglefowl. It is one of the most common and widespread domestic animals, with a total population of more than 19 billion as of 2011.[1] Humans commonly keep chickens as a source of food (consuming both their meat and eggs) and, more rarely, as pets.\"
        },
        {
            \"idCategory\":\"3\",
            \"strCategory\":\"Dessert\",
            \"strCategoryThumb\":\"https:\\/\\/www.themealdb.com\\/images\\/category\\/dessert.png\",
            \"strCategoryDescription\":\"Dessert is a course that concludes a meal. The course usually consists of sweet foods, such as confections dishes or fruit, and possibly a beverage such as dessert wine or liqueur, however in the United States it may include coffee, cheeses, nuts, or other savory items regarded as a separate course elsewhere. In some parts of the world, such as much of central and western Africa, and most parts of China, there is no tradition of a dessert course to conclude a meal.\\r\\n\\r\\nThe term dessert can apply to many confections, such as biscuits, cakes, cookies, custards, gelatins, ice creams, pastries, pies, puddings, and sweet soups, and tarts. Fruit is also commonly found in dessert courses because of its naturally occurring sweetness. Some cultures sweeten foods that are more commonly savory to create desserts.\"
        }
    ]
}
""".data(using: .utf8)!

class MealDBAPIServiceCallbackSuccessStub: MealDBAPIService {
    override func getDataFromURL(_ url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        DispatchQueue.main.async {
            completionHandler(sampleCategoryJSONData, nil, nil)
        }
    }
}

class MealDBAPIServiceCallbackErrorStub: MealDBAPIService {
    override func getDataFromURL(_ url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        DispatchQueue.main.async {
            // todo: generate an error here
            completionHandler(nil, nil, nil)
        }
    }
}

class MealDBAPIServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMealDBAPIServiceExists() throws {
        let mealDBAPIService = MealDBAPIService()
        XCTAssertNotNil(mealDBAPIService, "MealDBAPIService unable to be initialized")
    }
    
    func testMealDBAPIServiceDecodesSampleResponse() throws {
        let categories = categoriesFromResponseData(sampleCategoryJSONData)
        XCTAssertEqual(3, categories.count)
        XCTAssertTrue(type(of: categories.first!) == MealCategory.self)
    }
    
    func testMealDBAPIServiceCallsCallbackForCategories() throws {
        let successMealDB = MealDBAPIServiceCallbackSuccessStub()
        let successExpectation = self.expectation(description: "API Callback Success")
        successMealDB.fetchAllCategories(withCallback: {meals in
            successExpectation.fulfill()
            // meals would be 3 here ideally, but that is also testing the parsing
        })
        
        let errorMealDB = MealDBAPIServiceCallbackErrorStub()
        let errorExpectation = self.expectation(description: "API Callback Error")
        errorMealDB.fetchAllCategories(withCallback: {meals in
            errorExpectation.fulfill()
            // could also assert that meals is empty here
        })
        
        waitForExpectations(timeout: 2, handler: nil)
    }

}
