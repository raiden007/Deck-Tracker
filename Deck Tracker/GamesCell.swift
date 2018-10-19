//
//  GamesCell.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 11/5/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class GamesCell: UITableViewCell {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var playerImage: UIImageView!
    @IBOutlet var opponentImage: UIImageView!
    @IBOutlet var coinLabel: UILabel!
    @IBOutlet var winLabel: UILabel!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
