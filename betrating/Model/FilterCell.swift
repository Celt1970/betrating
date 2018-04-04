//
//  FilterCell.swift
//  betrating
//
//  Created by Yuriy borisov on 14.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import UIKit

class FilterCellSimple: UITableViewCell {
    @IBOutlet weak var labelForRow: UILabel!
    @IBOutlet weak var switchfoRow: UISwitch!
    
    var delegate: FilterChangedDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func switcherSwitched(_ sender: UISwitch) {
        if switchfoRow.isOn{
            delegate?.changeStateTo(value: 1, position: [sender.tag - 1,0])
        }else{
            delegate?.changeStateTo(value: 0, position: [sender.tag - 1,0])
        }
    }
}
class FilterCellStars: UITableViewCell {
    
    @IBOutlet weak var firstStar: UIButton!
    @IBOutlet weak var secondStar: UIButton!
    @IBOutlet weak var thirdStar: UIButton!
    @IBOutlet weak var fourthStar: UIButton!
    @IBOutlet weak var fifthStar: UIButton!
    
    var delegate: FilterChangedDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func anyStarPressed(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "star\(sender.tag)"){
            sender.setImage(UIImage(named: "starPressed\(sender.tag)"), for: .normal)
            delegate?.changeStateTo(value: 1, position: [1, sender.tag - 1])
            
        }else{
            sender.setImage(UIImage(named: "star\(sender.tag)"), for: .normal)
            delegate?.changeStateTo(value: 0, position: [1, sender.tag - 1])
            
        }
    }
    
}



class FilterCellMoney: UITableViewCell {
    @IBOutlet weak var labelForRow: UILabel!
    
    @IBOutlet weak var dollarSign: UIButton!
    @IBOutlet weak var euroSign: UIButton!
    
    @IBOutlet weak var rublSign: UIButton!
    
    var delegate: FilterChangedDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func moneySignPressed( _ sender: UIButton){
        if sender.tag == 1{
            if sender.currentImage == #imageLiteral(resourceName: "dollarSign"){
                sender.setImage(#imageLiteral(resourceName: "dollarSignPressed"), for: .normal)
                delegate?.changeStateTo(value: 1, position: [4, sender.tag - 1])

            }else{
                sender.setImage(#imageLiteral(resourceName: "dollarSign"), for: .normal)
                delegate?.changeStateTo(value: 0, position: [4, sender.tag - 1])

            }
        } else if sender.tag == 2{
            if sender.currentImage == #imageLiteral(resourceName: "euroSign"){
                sender.setImage(#imageLiteral(resourceName: "euroSignPressed"), for: .normal)
                delegate?.changeStateTo(value: 1, position: [4, sender.tag - 1])

            }else{
                sender.setImage(#imageLiteral(resourceName: "euroSign"), for: .normal)
                delegate?.changeStateTo(value: 0, position: [4, sender.tag - 1])

            }
        }else if sender.tag == 3{
            if sender.currentImage == #imageLiteral(resourceName: "rublSign"){
                sender.setImage(#imageLiteral(resourceName: "rublSignPressed"), for: .normal)
                delegate?.changeStateTo(value: 1, position: [4, sender.tag - 1])

            }else{
                sender.setImage(#imageLiteral(resourceName: "rublSign"), for: .normal)
                delegate?.changeStateTo(value: 0, position: [4, sender.tag - 1])

            }
        }
        
    }
    
    
}
class FilterCellClear: UITableViewCell {
    @IBOutlet weak var clearFiltersButton: UIButton!
    
    var delegate: FilterChangedDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func clearFiltersBtnPressed(_ sender: UIButton) {
        delegate?.clearButton()
    }
    
}

