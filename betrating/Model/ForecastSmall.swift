//
//  ForecastSmall.swift
//  betrating
//
//  Created by Yuriy borisov on 17.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import Foundation

class ForecastSmall{
    let id: Int
    let name: String
    var currentName: String{

        let str = name.replacingOccurrences(of: " – ", with: "\n").replacingOccurrences(of: " &#8212; ", with: "\n")
        return str.capitalized
    }
    let leaguePreview : String
    let date: String
    let headerFirstPart: String?
    let headerSecondPart: String?
    let headerThirdPart: String?
    var fuulHeader: String{
        if headerThirdPart != ""{
            return  (headerSecondPart ?? "") + " • " + (headerFirstPart ?? "")
        }else{
            return  headerFirstPart ?? ""
            
        }
    }
    
    init(json: [String:Any]) {
        self.id = json["id"] as! Int
        self.name = json["name"] as! String
        self.leaguePreview = json["league_preview"] as! String
        print(json["date"])
        let date = json["date"] as! [String : Any]
        let month = date["month"] as! String
        let day = date["day"] as! String
        let time = date["time"] as! String
        self.date = "\(day) \(month) \(time)"
        if let category = json["category"] as? [String:Any]{
            self.headerFirstPart = category["name"] as? String
            if let parent = category["parent"] as? [String:Any] {
                self.headerSecondPart = parent["name"] as? String
                if let secondParent = parent["parent"] as? [String:Any]{
                    self.headerThirdPart = secondParent["name"] as? String
                }else{
                    self.headerThirdPart = ""
                }
            }else{
                self.headerSecondPart = ""
                self.headerThirdPart = ""
            }
        }else{
            self.headerSecondPart = ""
            self.headerThirdPart = ""
            self.headerFirstPart = ""
        }
    }
}

