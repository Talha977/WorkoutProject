//
//  CustomTableViewCell.swift
//  Expandable-TableViewCell-StackView
//
//  Created by Akash Malhotra on 7/8/16.
//  Copyright © 2016 Akash Malhotra. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    
    @IBOutlet weak var TF_Workout: FormTextField!
    
    @IBOutlet weak var btnPlus: UIButton!
    
    @IBOutlet weak var btnDropDown: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
