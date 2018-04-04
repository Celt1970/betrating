//
//  FiltersVC.swift
//  betrating
//
//  Created by Yuriy borisov on 14.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import UIKit

class FiltersVC: UITableViewController {
    
    var activatedTriggers: [[Int]] = [[0],[0,0,0,0,0],[0],[0],[0,0,0],[0],[0],[0],[0],[0],[0],[0]]
    var triggersToSend = [[0],[0,0,0,0,0],[0],[0],[0,0,0],[0],[0],[0],[0],[0],[0],[0]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 2
        case 3:
            return 7
        case 4:
            return 1
        default:
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        switch section {
        case 0:
            return ""
        case 1:
            return "Рейтинг надежности"
        case 2:
            return "Русский язык"
        case 3:
            return "Ставки"
        default:
            return ""
        }
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 4{
            return 44
        }else{
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "simpleFilterCell", for: indexPath) as! FilterCellSimple
            cell.delegate = self
            cell.labelForRow.text = "Легальные"
            cell.switchfoRow.tag = 1
            if activatedTriggers[0][0] == 0{
                cell.switchfoRow.isOn = false
            }else{
                cell.switchfoRow.isOn = true
            }
            return cell
        }else if indexPath.section == 1{
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "starsFiltersCell", for: indexPath) as! FilterCellStars
            let states = activatedTriggers[1]
            if states[0] == 1{
                cell.firstStar.setImage(UIImage(named: "starPressed1"), for: .normal)
            }else{
                cell.firstStar.setImage(UIImage(named: "star1"), for: .normal)
            }
            if states[1] == 1{
                cell.secondStar.setImage(UIImage(named: "starPressed2"), for: .normal)
            }else{
                cell.secondStar.setImage(UIImage(named: "star2"), for: .normal)
            }
            if states[2] == 1{
                cell.thirdStar.setImage(UIImage(named: "starPressed3"), for: .normal)
            }else{
                cell.thirdStar.setImage(UIImage(named: "star3"), for: .normal)
            }
            if states[3] == 1{
                cell.fourthStar.setImage(UIImage(named: "starPressed4"), for: .normal)
            }else{
                cell.fourthStar.setImage(UIImage(named: "star4"), for: .normal)
            }
            if states[4] == 1{
                cell.fifthStar.setImage(UIImage(named: "starPressed5"), for: .normal)
            }else{
                cell.fifthStar.setImage(UIImage(named: "star5"), for: .normal)
            }
            cell.delegate = self
            return cell
        }else if indexPath.section == 2{
            switch indexPath.row{
            case 0:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "simpleFilterCell", for: indexPath) as! FilterCellSimple
                cell.delegate = self
                cell.switchfoRow.tag = 3

                cell.labelForRow.text = "Русский язык на сайте"
                if activatedTriggers[2][0] == 0{
                    cell.switchfoRow.isOn = false
                }else{
                    cell.switchfoRow.isOn = true
                }
                return cell
            case 1:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "simpleFilterCell", for: indexPath) as! FilterCellSimple
                cell.delegate = self
                cell.switchfoRow.tag = 4
                cell.labelForRow.text = "Поддержка на русском"
                if activatedTriggers[3][0] == 0{
                    cell.switchfoRow.isOn = false
                }else{
                    cell.switchfoRow.isOn = true
                }
                return cell
            default:
                break
            }
        }else if indexPath.section == 3{
            switch indexPath.row{
            case 0:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "moneyFilterCell", for: indexPath) as! FilterCellMoney
                cell.delegate = self
                let states = activatedTriggers[4]
                if states[0] == 1{
                    cell.dollarSign.setImage(#imageLiteral(resourceName: "dollarSignPressed"), for: .normal)
                }else{
                    cell.dollarSign.setImage(#imageLiteral(resourceName: "dollarSign"), for: .normal)
                }
                
                if states[1] == 1{
                    cell.euroSign.setImage(#imageLiteral(resourceName: "euroSignPressed"), for: .normal)
                }else{
                    cell.euroSign.setImage(#imageLiteral(resourceName: "euroSign"), for: .normal)
                }
                
                if states[2] == 1{
                    cell.rublSign.setImage(#imageLiteral(resourceName: "rublSignPressed"), for: .normal)
                }else{
                    cell.rublSign.setImage(#imageLiteral(resourceName: "rublSign"), for: .normal)
                }
                
                return cell
            case 1:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "simpleFilterCell", for: indexPath) as! FilterCellSimple
                cell.labelForRow.text = "Ставки Live"
                cell.delegate = self
                cell.switchfoRow.tag = 6
                if activatedTriggers[5][0] == 0{
                    cell.switchfoRow.isOn = false
                }else{
                    cell.switchfoRow.isOn = true
                }
                return cell
            case 2:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "simpleFilterCell", for: indexPath) as! FilterCellSimple
                cell.labelForRow.text = "С бонусами"
                cell.delegate = self
                cell.switchfoRow.tag = 7
                if activatedTriggers[6][0] == 0{
                    cell.switchfoRow.isOn = false
                }else{
                    cell.switchfoRow.isOn = true
                }
                return cell
            case 3:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "simpleFilterCell", for: indexPath) as! FilterCellSimple
                cell.labelForRow.text = "Для профессионалов"
                cell.delegate = self
                cell.switchfoRow.tag = 8
                if activatedTriggers[7][0] == 0{
                    cell.switchfoRow.isOn = false
                }else{
                    cell.switchfoRow.isOn = true
                }
                return cell
                
            case 4:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "simpleFilterCell", for: indexPath) as! FilterCellSimple
                cell.labelForRow.text = "С демо счетом"
                cell.delegate = self
                cell.switchfoRow.tag = 9
                if activatedTriggers[8][0] == 0{
                    cell.switchfoRow.isOn = false
                }else{
                    cell.switchfoRow.isOn = true
                }
                return cell
            case 5:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "simpleFilterCell", for: indexPath) as! FilterCellSimple
                cell.labelForRow.text = "Биржи ставок"
                cell.delegate = self
                cell.switchfoRow.tag = 10
                if activatedTriggers[9][0] == 0{
                    cell.switchfoRow.isOn = false
                }else{
                    cell.switchfoRow.isOn = true
                }
                return cell
                
            case 6:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "simpleFilterCell", for: indexPath) as! FilterCellSimple
                cell.labelForRow.text = "Доступ с мобильного"
                cell.delegate = self
                cell.switchfoRow.tag = 11
                if activatedTriggers[10][0] == 0{
                    cell.switchfoRow.isOn = false
                }else{
                    cell.switchfoRow.isOn = true
                }
                return cell
            default:
                break
            }
        }else{
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "clearFiltersCell", for: indexPath) as! FilterCellClear
            cell.delegate = self
            return cell
        }
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "clearFiltersCell", for: indexPath) as! FilterCellClear
        return cell
        
    }
}

extension FiltersVC: FilterChangedDelegate{
    func changeStateTo(value: Int, position: [Int]) {
        activatedTriggers[position[0]][position[1]] = value
    }
    func clearButton() {
        activatedTriggers = [[0],[0,0,0,0,0],[0],[0],[0,0,0],[0],[0],[0],[0],[0],[0],[0]]
        tableView.reloadData()
    }
}

protocol FilterChangedDelegate{
    func changeStateTo(value: Int, position: [Int])
    func clearButton()
}
