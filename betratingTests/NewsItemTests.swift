//
//  NewsItemTests.swift
//  betratingTests
//
//  Created by Yuriy borisov on 24.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import XCTest
@testable import betrating
class NewsItemTests: XCTestCase {
    
    let testObject: [String:Any] = ["id" : 1,
                                    "name" : "sport news",
                                    "preview" : "http://image.jpg",
                                    "date" : "16.07.1992",
                                    "category" : ["Soccer", "England", "Prime league"],
                                    "content" : "<p>Букмекерская контора Betcity определила вероятного победителя Лиги Европы. Здесь в фаворитах «Атлетико», на которого предлагается коэффициент 6,0.</p>\n<p>Основной соперник испанской команды — лондонский «Арсенал». Сделанная на него ставка увеличит деньги в 7,5 раза. Из российских команд выделяется только «Зенит», занимающий седьмую строчку с коэффициентом 19,0.</p>\n<p>Среди главных аутсайдеров — дебютант еврокубка «Астана», на которую предлагается коэффициент 150,0.</p>\n",
                                    "tags" : ["Prime league", "Soccer", "For people who love sports"]]
    
    let testObjectWithNilFields: [String : Any] = ["id" : 0,
                                                   "name" : "another news",
                                                   "content" : "some cool content"]
    
   
    
    func test_newsItemParsing(){
        let testItem = NewsItem(json: testObject)
        
        XCTAssertEqual(testItem.id, 1)
        XCTAssertEqual(testItem.name, "sport news")
        XCTAssertEqual(testItem.preview, "http://image.jpg")
        XCTAssertEqual(testItem.date, "16.07.1992")
        XCTAssertEqual(testItem.category!, ["Soccer", "England", "Prime league"])
        XCTAssertEqual(testItem.content, "<p>Букмекерская контора Betcity определила вероятного победителя Лиги Европы. Здесь в фаворитах «Атлетико», на которого предлагается коэффициент 6,0.</p>\n<p>Основной соперник испанской команды — лондонский «Арсенал». Сделанная на него ставка увеличит деньги в 7,5 раза. Из российских команд выделяется только «Зенит», занимающий седьмую строчку с коэффициентом 19,0.</p>\n<p>Среди главных аутсайдеров — дебютант еврокубка «Астана», на которую предлагается коэффициент 150,0.</p>\n")
        XCTAssertEqual(testItem.tags!,  ["Prime league", "Soccer", "For people who love sports"])
    }
    
    func test_newsItemParsingWithNil(){
        let testItem = NewsItem(json: testObjectWithNilFields)
        XCTAssertEqual(testItem.id, 0)
        XCTAssertEqual(testItem.name, "another news")
        XCTAssertEqual(testItem.preview, nil)
        XCTAssertEqual(testItem.date, nil)
        XCTAssertEqual(testItem.content, "some cool content")
        XCTAssert(testItem.tags == nil)
    }
    
}
