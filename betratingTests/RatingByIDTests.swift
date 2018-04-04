//
//  RatingByIDTests.swift
//  betratingTests
//
//  Created by Yuriy borisov on 25.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import XCTest
@testable import betrating

class RatingByIDTests: XCTestCase {
    
    let testObject: [String : Any] = ["id" : 10, "name" : "ultra bets", "logo" : "http://logo.img", "votes" : 123, "legal" : true, "rating" : 5, "russian_language" : true, "russian_support" : false, "currencies" : ["EUR", "USD", "RUB"], "live" : false, "bonus" : 10, "has_professional" : false, "has_demo" : false, "has_betting" : true,  "has_mobile_mode" : true, "description" : "Some abstract bookmaker" ]
    
    let testObjectWithNilFields: [String : Any] = ["id" : 10, "name" : "ultra bets", "logo" : "http://logo.img", "votes" : 123, "legal" : true, "rating" : 5]
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_ratingByIDParsing(){
        
        let testItem = RatingByID(json: testObject)
        XCTAssertEqual(testItem.id, 10)
        XCTAssertEqual(testItem.name, "ultra bets")
        XCTAssertEqual(testItem.logo, "http://logo.img")
        XCTAssertEqual(testItem.votes, 123)
        XCTAssertEqual(testItem.legal, true)
        XCTAssertEqual(testItem.rating, 5)
        XCTAssertEqual(testItem.russianLanguage, true)
        XCTAssertEqual(testItem.russianSupport, false)
        XCTAssertEqual(testItem.currensies!, ["EUR", "USD", "RUB"])
        XCTAssertEqual(testItem.live, false)
        XCTAssertEqual(testItem.bonus, 10)
        XCTAssertEqual(testItem.hasProfeesional, false)
        XCTAssertEqual(testItem.hasDemo, false)
        XCTAssertEqual(testItem.hasBetting, true)
        XCTAssertEqual(testItem.hasMobileMode, true)
        XCTAssertEqual(testItem.description, "Some abstract bookmaker")
    }
    
    func test_ratingByIDParsingWithNilFields(){
        let testItem = RatingByID(json: testObjectWithNilFields)
        XCTAssertEqual(testItem.id, 10)
        XCTAssertEqual(testItem.name, "ultra bets")
        XCTAssertEqual(testItem.logo, "http://logo.img")
        XCTAssertEqual(testItem.votes, 123)
        XCTAssertEqual(testItem.legal, true)
        XCTAssertEqual(testItem.rating, 5)
        XCTAssertEqual(testItem.russianLanguage, nil)
        XCTAssertEqual(testItem.russianSupport, nil)
        XCTAssert(testItem.currensies == nil)
        XCTAssertEqual(testItem.live, nil)
        XCTAssertEqual(testItem.bonus, nil)
        XCTAssertEqual(testItem.hasProfeesional, nil)
        XCTAssertEqual(testItem.hasDemo, nil)
        XCTAssertEqual(testItem.hasBetting, nil)
        XCTAssertEqual(testItem.hasMobileMode, nil)
        XCTAssertEqual(testItem.description, nil)
    }
    
   
    
}
