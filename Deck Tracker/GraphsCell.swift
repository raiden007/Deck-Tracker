//
//  GraphsCell.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 29/09/15.
//  Copyright © 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class GraphsCell : UITableViewCell {
    
    
    @IBOutlet weak var playerDeck: UILabel!
    @IBOutlet weak var playerWinPercent: UILabel!
    @IBOutlet weak var graphImage: UIImageView!
    @IBOutlet weak var opponentWinPercent: UILabel!
    @IBOutlet weak var opponentDeck: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}