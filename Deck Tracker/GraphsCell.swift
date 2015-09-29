//
//  GraphsCell.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 29/09/15.
//  Copyright © 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class GraphsCell : UITableViewCell {
    
    

    @IBOutlet weak var playerDeckLabel: UILabel!
    @IBOutlet weak var winPercentLabel: UILabel!
    @IBOutlet weak var gamesListLabel: UILabel!
    @IBOutlet weak var opponentLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}