//
//  GamesVCTests.swift
//  betratingTests
//
//  Created by Yuriy borisov on 24.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import XCTest
@testable import betrating

class GamesVCTests: XCTestCase {
    var gamesVC = GamesVC()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_checkSortingGamesByLeague(){
        //Проверяем алгоритм сортировки по лигам передавая заготовленный массив
        let firstMatch:MatchesQueryQuery.Data.Match? =  MatchesQueryQuery.Data.Match(uniqueTournamentName: "first", league: nil, leagueSlug: nil, matchDate: nil, status: nil, resultScore: nil, teams: nil)
        let secondMatch :MatchesQueryQuery.Data.Match? = MatchesQueryQuery.Data.Match(uniqueTournamentName: "second", league: nil, leagueSlug: nil, matchDate: nil, status: nil, resultScore: nil, teams: nil)
        let thirdMatch :MatchesQueryQuery.Data.Match? = MatchesQueryQuery.Data.Match(uniqueTournamentName: "first", league: nil, leagueSlug: nil, matchDate: nil, status: nil, resultScore: nil, teams: nil)
        let fourthMatch :MatchesQueryQuery.Data.Match? = MatchesQueryQuery.Data.Match(uniqueTournamentName: "second", league: nil, leagueSlug: nil, matchDate: nil, status: nil, resultScore: nil, teams: nil)
        
        let rawMatchesArray = [firstMatch, secondMatch, thirdMatch, fourthMatch]
        let sortedGames = gamesVC.sortGamesByLeague(array: rawMatchesArray)
        var example = [[firstMatch, thirdMatch], [secondMatch, fourthMatch]]
        XCTAssertEqual(sortedGames[0][0]?.uniqueTournamentName, example[0][0]?.uniqueTournamentName)
        XCTAssertEqual(sortedGames[0][1]?.uniqueTournamentName, example[0][1]?.uniqueTournamentName)
        XCTAssertEqual(sortedGames[1][0]?.uniqueTournamentName, example[1][0]?.uniqueTournamentName)
        XCTAssertEqual(sortedGames[1][1]?.uniqueTournamentName, example[1][1]?.uniqueTournamentName)

    }
    
    func test_checkSortingGamesByDate(){
        let firstMatch:MatchesQueryQuery.Data.Match? =  MatchesQueryQuery.Data.Match(uniqueTournamentName: nil, league: nil, leagueSlug: nil, matchDate: "2018-01-28 12:32:00", status: nil, resultScore: nil, teams: nil)
        let secondMatch :MatchesQueryQuery.Data.Match? = MatchesQueryQuery.Data.Match(uniqueTournamentName: nil, league: nil, leagueSlug: nil, matchDate: "2018-01-28 15:18:00", status: nil, resultScore: nil, teams: nil)
        let thirdMatch :MatchesQueryQuery.Data.Match? = MatchesQueryQuery.Data.Match(uniqueTournamentName: nil, league: nil, leagueSlug: nil, matchDate: "2018-01-28 20:21:00", status: nil, resultScore: nil, teams: nil)
        let fourthMatch :MatchesQueryQuery.Data.Match? = MatchesQueryQuery.Data.Match(uniqueTournamentName: nil, league: nil, leagueSlug: nil, matchDate: "2018-02-28 23:17:00", status: nil, resultScore: nil, teams: nil)
        
        let rawMatchesArray = [firstMatch, secondMatch, thirdMatch, fourthMatch]
        let sortedGames = gamesVC.sortGamesByDate(array: rawMatchesArray)
        let example = [[firstMatch, secondMatch,thirdMatch], [fourthMatch]]
        XCTAssertEqual(sortedGames[0][0]?.matchDate, example[0][0]?.matchDate)
        XCTAssertEqual(sortedGames[0][1]?.matchDate, example[0][1]?.matchDate)
        XCTAssertEqual(sortedGames[0][2]?.matchDate, example[0][2]?.matchDate)
        XCTAssertEqual(sortedGames[1][0]?.matchDate, example[1][0]?.matchDate)
    }
    
    
    
}
