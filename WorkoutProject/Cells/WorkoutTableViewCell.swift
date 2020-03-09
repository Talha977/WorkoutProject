//
//  WorkoutTableViewCell.swift
//  WorkoutProject
//
//  Created by Mnet on 08/07/1441 AH.
//  Copyright © 1441 Talha. All rights reserved.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {

    @IBOutlet weak var lblWorkoutName:UILabel!
    @IBOutlet weak var TF_Workout:UITextField!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
