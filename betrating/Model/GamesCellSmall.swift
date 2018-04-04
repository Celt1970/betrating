//
//  GamesCellSmall.swift
//  betrating
//
//  Created by Yuriy borisov on 15.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import UIKit

class GamesCellSmall: UITableViewCell {
    @IBOutlet weak var firstTeamImage: UIImageView!
    @IBOutlet weak var secondTeamImage: UIImageView!
    @IBOutlet weak var firstTeamLabel: UILabel!
    @IBOutlet weak var secondTeamLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configCell(currentGame: MatchesQueryQuery.Data.Match?,
                    dateFormatter: DateFormatter,
                    service: NetworkService?,
                    indexPath: IndexPath){
        
        
        self.firstTeamLabel.text = currentGame?.teams?.first??.name 
        self.secondTeamLabel.text = currentGame?.teams?.last??.name
        
        if currentGame?.matchDate != nil{
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let some: String = (currentGame?.matchDate)!
            let datte = dateFormatter.date(from: some)
            if datte != nil{
                dateFormatter.dateFormat = "dd MMM HH:mm"
                let result = dateFormatter.string(from: datte!)
                self.dateLabel.text = result
            }
        }
        
        if currentGame?.resultScore != nil{
            let arr = currentGame!.resultScore!.split(separator: ":")
            let first = arr[0]
            let firstInt = Int(first)
            let second = arr[1]
            let secondInt = Int(second)
            
            if firstInt! < secondInt!{
                self.firstTeamLabel.textColor = UIColor.lightGray
                self.secondTeamLabel.textColor = UIColor.black
            }else if firstInt! > secondInt!{
                self.secondTeamLabel.textColor = UIColor.lightGray
                self.firstTeamLabel.textColor = UIColor.black
            }else{
                self.firstTeamLabel.textColor = UIColor.black
                self.secondTeamLabel.textColor = UIColor.black
            }
        }else{
            self.firstTeamLabel.textColor = UIColor.black
            self.secondTeamLabel.textColor = UIColor.black
        }
        self.firstTeamImage.image = nil
        self.secondTeamImage.image = nil
        self.tag = indexPath.row
        self.scoreLabel.text = currentGame?.resultScore != nil ? currentGame?.resultScore : "– : –"
        
        guard service != nil else {return}

        service?.loadImage(url: currentGame?.teams![0]?.logo, completion: {image, connect in
            if connect == true{
                return
            }
            if self.tag == indexPath.row{
                self.firstTeamImage.image = image
            }
        })
        service?.loadImage(url: currentGame?.teams![1]?.logo, completion: {image, connect in
            if connect == true{
                return
            }
            if self.tag == indexPath.row{
                self.secondTeamImage.image = image
            }
        })
    }

}
