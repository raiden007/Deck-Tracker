//
//  DecksCell.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 6/5/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet var customLabel: UILabel!
    @IBOutlet var customImage: UIImageView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(labelText:String, imageName:String) {
        self.customLabel.text = labelText
        self.customImage.image = UIImage(named: imageName)
    }

}
