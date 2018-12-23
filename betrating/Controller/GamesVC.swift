//
//  GamesVC.swift
//  betrating
//
//  Created by Yuriy borisov on 14.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import UIKit

class GamesVC: UIViewController {
    
    let betRatingGreen = UIColor(red: 0, green: 169/255, blue: 103/255, alpha: 1)
    let betRatingGray = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateOrLeagueController: UISegmentedControl!
    
    @IBOutlet weak var footballButton: UIButton!
    @IBOutlet weak var hockeyButton: UIButton!
    @IBOutlet weak var tennisButton: UIButton!
    @IBOutlet weak var basktvallButton: UIButton!
    
    var gaameCategory = statisticsCategoryes.soccer
    var games: [MatchesQueryQuery.Data.Match?]?
    var gamesByDate: [[MatchesQueryQuery.Data.Match?]]?
    var gamesByLeague: [[MatchesQueryQuery.Data.Match?]?]?
    
    var soccerByLeague: [[MatchesQueryQuery.Data.Match?]?]?
    var soccerByDate: [[MatchesQueryQuery.Data.Match?]?]?
    
    var hockeyByLeague: [[MatchesQueryQuery.Data.Match?]?]?
    var hockeyByDate: [[MatchesQueryQuery.Data.Match?]?]?
    
    var tennisByLeague: [[MatchesQueryQuery.Data.Match?]?]?
    var tennisByDate: [[MatchesQueryQuery.Data.Match?]?]?
    
    var basketballByLeague: [[MatchesQueryQuery.Data.Match?]?]?
    var basketballByDate: [[MatchesQueryQuery.Data.Match?]?]?
    
    var configuration = URLSessionConfiguration.default
    var session:URLSession{
        return URLSession(configuration: configuration)
    }
    var service: NetworkService?
    
    let dateFormatter = DateFormatter()
    
    func changingSportButtonsColor(sender: UIButton){
        if sender.currentTitleColor == betRatingGreen{
            if tableView.numberOfRows(inSection: 0) != 0{
                tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
            return
        }
        let buttons = [footballButton, hockeyButton, tennisButton, basktvallButton]
        for button in buttons{
            if button == sender{
                sender.setTitleColor(betRatingGreen, for: .normal)
            }else{
                button?.setTitleColor(betRatingGray, for: .normal)
            }
        }
    }
    
    @IBAction func sportButtonPressed(_ sender: UIButton) {
        changingSportButtonsColor(sender: sender)
        gaameCategory = statisticsCategoryes(rawValue: sender.currentTitle!)!
        let cat = gaameCategory
        
        if dateOrLeagueController.selectedSegmentIndex == 0{
            switch cat{
            case .soccer:
                if self.soccerByDate != nil && self.soccerByDate?.isEmpty != true{
                    if tableView.numberOfRows(inSection: 0) != 0 && tableView.numberOfSections != 0{
                        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                    }
                    tableView.reloadData()
                }else{
                    reload(category: cat)
                }
            case .hockey:
                if self.hockeyByDate != nil && self.hockeyByDate?.isEmpty != true{
                    if tableView.numberOfRows(inSection: 0) != 0 && tableView.numberOfSections != 0{
                        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                    }
                    tableView.reloadData()
                }else{
                    reload(category: cat)
                }
            case .tennis:
                if self.tennisByDate != nil && self.tennisByDate?.isEmpty != true{
                    if tableView.numberOfRows(inSection: 0) != 0 && tableView.numberOfSections != 0{
                        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                    }
                    tableView.reloadData()
                }else{
                    reload(category: cat)
                }
            case .basketball:
                if self.basketballByDate != nil && self.basketballByDate?.isEmpty != true{
                    if tableView.numberOfRows(inSection: 0) != 0 && tableView.numberOfSections != 0{
                        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                    }
                    tableView.reloadData()
                }else{
                    reload(category: cat)
                }
            }
        }else{
            switch cat{
            case .soccer:
                if self.soccerByLeague != nil && self.soccerByLeague?.isEmpty != true{
                    if tableView.numberOfRows(inSection: 0) != 0 && tableView.numberOfSections != 0{
                        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                    }
                    tableView.reloadData()
                }else{
                    reload(category: cat)
                }
            case .hockey:
                if self.hockeyByLeague != nil && self.hockeyByLeague?.isEmpty != true{
                    if tableView.numberOfRows(inSection: 0) != 0 && tableView.numberOfSections != 0{
                        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                    }
                    tableView.reloadData()
                }else{
                    reload(category: cat)
                }
            case .tennis:
                if self.tennisByLeague != nil && self.tennisByLeague?.isEmpty != true{
                    if tableView.numberOfRows(inSection: 0) != 0 && tableView.numberOfSections != 0{
                        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                    }
                    tableView.reloadData()
                }else{
                    reload(category: cat)
                }
            case .basketball:
                if self.basketballByLeague != nil && self.basketballByLeague?.isEmpty != true{
                    if tableView.numberOfRows(inSection: 0) != 0 && tableView.numberOfSections != 0{
                        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                    }
                    tableView.reloadData()
                }else{
                    reload(category: cat)
                }
            }
        }
        
        
    }
    
    
    func reload(category: statisticsCategoryes){
        tableView.isHidden = true
        service?.fetchMatches(category: category, completion: { [weak self] games in
            
                switch category{
                case .soccer:
                    if games.first == nil {
                        self?.soccerByDate = nil
                        self?.soccerByLeague = nil
                    }
                    self?.soccerByDate = self?.sortGamesByDate(array: games)
                    self?.soccerByLeague = self?.sortGamesByLeague(array: games)
                case .hockey:
                    if games.first == nil {
                        self?.hockeyByDate = nil
                        self?.hockeyByLeague = nil
                    }
                    self?.hockeyByDate = self?.sortGamesByDate(array: games)
                    self?.hockeyByLeague = self?.sortGamesByLeague(array: games)
                case .tennis:
                    if games.first == nil {
                        self?.tennisByDate = nil
                        self?.tennisByLeague = nil
                    }
                    self?.tennisByDate  = self?.sortGamesByDate(array: games)
                    self?.tennisByLeague = self?.sortGamesByLeague(array: games)
                case .basketball:
                    if games.first == nil {
                        self?.basketballByDate = nil
                        self?.basketballByLeague = nil
                    }
                    self?.basketballByDate = self?.sortGamesByDate(array: games)
                    self?.basketballByLeague = self?.sortGamesByLeague(array: games)
                }
            
            self?.tableView.isHidden = false
            self?.tableView.reloadData()
            if self?.tableView.numberOfRows(inSection: 0) != 0 && self?.tableView.numberOfSections != 0{
                self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        })
    }
    

    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        dateFormatter.locale = Locale(identifier: "ru-RU")
        service = NetworkService()
        service?.fetchMatches(category: gaameCategory,completion: {[weak self] games in
            switch self!.gaameCategory{
            case .soccer:
                self?.soccerByDate = self?.sortGamesByDate(array: games)
                self?.soccerByLeague = self?.sortGamesByLeague(array: games)
            case .hockey:
                self?.hockeyByDate = self?.sortGamesByDate(array: games)
                self?.hockeyByLeague = self?.sortGamesByLeague(array: games)
            case .tennis:
                self?.tennisByDate  = self?.sortGamesByDate(array: games)
                self?.tennisByLeague = self?.sortGamesByLeague(array: games)
            case .basketball:
                self?.basketballByDate = self?.sortGamesByDate(array: games)
                self?.basketballByLeague = self?.sortGamesByLeague(array: games)
            }
            self?.tableView.reloadData()
            print(self?.gamesByLeague?.isEmpty == true)
        })
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
            tableView.reloadData()

        if tableView.numberOfRows(inSection: 0) != 0 && tableView.numberOfSections != 0{
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
}


