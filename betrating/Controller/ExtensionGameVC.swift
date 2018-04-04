//
//  File.swift
//  betrating
//
//  Created by Yuriy borisov on 22.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import Foundation
import UIKit

extension GamesVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch dateOrLeagueController.selectedSegmentIndex{
        case 0:
            let date: String?
            switch gaameCategory{
            case .soccer:
                date = soccerByDate?[section]?[0]?.matchDate
            case .hockey:
                date = hockeyByDate?[section]?[0]?.matchDate
            case .tennis:
                date = tennisByDate?[section]?[0]?.matchDate
            case .basketball:
                date = basketballByDate?[section]?[0]?.matchDate
            }
            guard date != nil else {return ""}
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date2 = dateFormatter.date(from: date!)
            if date2 != nil{
                dateFormatter.dateFormat = "dd MMMM"
                return dateFormatter.string(from: date2!)
            }
            return ""
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if dateOrLeagueController.selectedSegmentIndex == 0{
            return UIScreen.main.bounds.width / 10
        }else{
            return UIScreen.main.bounds.width / 20
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if dateOrLeagueController.selectedSegmentIndex == 0{
            switch gaameCategory{
            case .soccer:
                return soccerByDate?.count ?? 0
            case .hockey:
                return hockeyByDate?.count ?? 0
            case .tennis:
                return tennisByDate?.count ?? 0
            case .basketball:
                return basketballByDate?.count ?? 0
            }
        }else{
            switch gaameCategory{
            case .soccer:
                return soccerByLeague?.count ?? 0
            case .hockey:
                return hockeyByLeague?.count ?? 0
            case .tennis:
                return tennisByLeague?.count ?? 0
            case .basketball:
                return basketballByLeague?.count ?? 0
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dateOrLeagueController.selectedSegmentIndex == 0{
            
            switch gaameCategory{
            case .soccer:
                if soccerByDate?[section]?[0] != nil{
                    return soccerByDate?[section]?.count ?? 0
                }else{
                    return 0
                }
            case .hockey:
                if hockeyByDate?[section]?[0] != nil{
                    return hockeyByDate?[section]?.count ?? 0
                }else{
                    return 0
                }
            case .tennis:
                if  tennisByDate?[section]?[0] != nil{
                    return tennisByDate?[section]?.count ?? 0
                }else{
                    return 0
                }
            case .basketball:
                if basketballByDate?[section]?[0] != nil{
                    return basketballByDate?[section]?.count ?? 0
                }else{
                    return 0
                }
            }
        }else{
            switch gaameCategory{
            case .soccer:
                if soccerByLeague?[section]?[0] != nil{
                    return soccerByLeague?[section]?.count ?? 0
                }else{
                    return 0
                }
            case .hockey:
                if hockeyByLeague?[section]?[0] != nil{
                    return hockeyByLeague?[section]?.count ?? 0
                }else{
                    return 0
                }
            case .tennis:
                if tennisByLeague?[section]?[0] != nil{
                    return tennisByLeague?[section]?.count ?? 0
                }else{
                    return 0
                }
            case .basketball:
                if basketballByLeague?[section]?[0] != nil{
                    return basketballByLeague?[section]?.count ?? 0
                }else{
                    return 0
                }
            }
//            if gamesByLeague?.isEmpty != true{
//                return gamesByLeague?[section]!.count ?? 0
//
//            }else{
//                return 0
//            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch dateOrLeagueController.selectedSegmentIndex{
        case 1:
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "gamesCellBig", for: indexPath) as! GamesCellBig
                
                let game: [[MatchesQueryQuery.Data.Match?]?]?
                
                switch gaameCategory{
                case .soccer:
                    game = soccerByLeague
                case.hockey:
                    game = hockeyByLeague
                case .tennis:
                    game = tennisByLeague
                case .basketball:
                    game = basketballByLeague
                }
                
                guard game != nil else {
                    return cell
                }
                guard game?.isEmpty != true else {return cell}
                guard (game?[indexPath.section]?[indexPath.row]) != nil else {return cell}
                let currentGame = game?[indexPath.section]?[indexPath.row]
                
                cell.configCell(currentGame: currentGame, dateFormatter: dateFormatter, service: service, indexPath: indexPath)
                
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "gamesCellSmall", for: indexPath) as! GamesCellSmall
                let game: [[MatchesQueryQuery.Data.Match?]?]?
                
                switch gaameCategory{
                case .soccer:
                    game = soccerByLeague
                case.hockey:
                    game = hockeyByLeague
                case .tennis:
                    game = tennisByLeague
                case .basketball:
                    game = basketballByLeague
                }
                guard game != nil else {
                    return cell
                }
                guard game?.isEmpty != true else {return cell}
                guard (game?[indexPath.section]) != nil else {return cell}

                guard (game?[indexPath.section]?[indexPath.row]) != nil else {return cell}
                guard let currentGame = game?[indexPath.section]?[indexPath.row] else {return cell}
                
                if currentGame != nil{
                    cell.configCell(currentGame: currentGame, dateFormatter: dateFormatter, service: service, indexPath: indexPath)
                }
                return cell
            }
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "gamesCellSmall", for: indexPath) as! GamesCellSmall
            
            let game: [[MatchesQueryQuery.Data.Match?]?]?
            
            switch gaameCategory{
            case .soccer:
                game = soccerByDate
            case.hockey:
                game = hockeyByDate
            case .tennis:
                game = tennisByDate
            case .basketball:
                game = basketballByDate
            }
            
            guard game != nil else {return cell}
            guard (game?[indexPath.section]) != nil else {return cell}
            
            guard (game?[indexPath.section]?[0]) != nil else {return cell}
            guard let currentGame = game?[indexPath.section]?[indexPath.row] else {return cell}
            
//            if game?[indexPath.section] != nil {
//                let currentGame = game?[indexPath.section]?[indexPath.row]
                if currentGame != nil{
                    cell.configCell(currentGame: currentGame, dateFormatter: dateFormatter, service: service, indexPath: indexPath)
//                }
//                return cell
            }
            return cell
        }
    }
    
    func sortGamesByLeague(array: [MatchesQueryQuery.Data.Match?]) -> [[MatchesQueryQuery.Data.Match?]]{
        var ar = array
        var another = [[MatchesQueryQuery.Data.Match?]]()
        for i in ar{
            let add = ar.filter({
                $0?.uniqueTournamentName == i?.uniqueTournamentName
            })
            ar = ar.filter({
                $0?.uniqueTournamentName != i?.uniqueTournamentName
            })
            another.append(add)
        }
        return another.filter({
            $0.isEmpty != true
        })
    }
    
    func sortGamesByDate(array: [MatchesQueryQuery.Data.Match?]) -> [[MatchesQueryQuery.Data.Match?]]{
        
        var arr = array.filter({$0?.matchDate != nil})
        guard arr.isEmpty != true else {
            return [[nil]]
        }
        var another = [[MatchesQueryQuery.Data.Match?]]()
        
        for i in arr{
            
            let first = arr.filter({ (value: MatchesQueryQuery.Data.Match?) -> Bool in
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let dateFromI = dateFormatter.date(from: i!.matchDate!)
                dateFormatter.dateFormat = "dd MMMM"
                guard dateFromI != nil else {return false}
                let stringFromI = dateFormatter.string(from: dateFromI!)
                
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let dateFromValue = dateFormatter.date(from: value!.matchDate!)
                
                guard dateFromValue != nil else {return false}
                dateFormatter.dateFormat = "dd MMMM"
                let stringFromValue = dateFormatter.string(from: dateFromValue!)
                
                if stringFromI == stringFromValue{
                    return true
                }else{
                    return false
                }
            })
            arr = arr.filter({ (value: MatchesQueryQuery.Data.Match?) -> Bool in
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let dateFromI = dateFormatter.date(from: i!.matchDate!)
                dateFormatter.dateFormat = "dd MMMM"
                guard dateFromI != nil else {return false}
                let stringFromI = dateFormatter.string(from: dateFromI!)
                
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let dateFromValue = dateFormatter.date(from: value!.matchDate!)
                
                guard dateFromValue != nil else {return false}
                dateFormatter.dateFormat = "dd MMMM"
                let stringFromValue = dateFormatter.string(from: dateFromValue!)
                
                if stringFromI == stringFromValue{
                    return false
                }else{
                    return true
                }
            })
            another.append(first)
        }
        return another.filter({
            $0.isEmpty != true
        })
    }
}

