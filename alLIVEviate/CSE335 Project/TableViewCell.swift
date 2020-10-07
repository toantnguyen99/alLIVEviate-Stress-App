//
//  TableViewCell.swift
//  CSE335 Project
//
//  Created by tnguy107 on 4/12/19.
//  Copyright © 2019 tnguy107. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var imageStressHistory: UIImageView!
    @IBOutlet weak var stressLevel: UILabel!
    @IBOutlet weak var lowEnergyScore: UILabel!
    @IBOutlet weak var headachesScore: UILabel!
    @IBOutlet weak var tenseMusclesScore: UILabel!
    @IBOutlet weak var insominiaScore: UILabel!
    @IBOutlet weak var skinRashesScore: UILabel!
    @IBOutlet weak var painScore: UILabel!
    @IBOutlet weak var durationScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
