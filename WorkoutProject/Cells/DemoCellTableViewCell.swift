//
//  DemoCellTableViewCell.swift
//  WorkoutProject
//
//  Created by Mnet on 06/07/1441 AH.
//  Copyright © 1441 Talha. All rights reserved.
//

import UIKit
import FoldingCell

class DemoCellTableViewCell: FoldingCell {

    @IBOutlet weak var lblDayFolded: UILabel!
    @IBOutlet weak var lblDayUnFolded: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var btnUpdate: UIButton!
    
    
    @IBOutlet weak var bottomHeight: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
            foregroundView.layer.cornerRadius = 10
            foregroundView.layer.masksToBounds = true
        bottomHeight.constant = 50
            super.awakeFromNib()
        }

        override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
            let durations = [0.26, 0.2, 0.2]
            return durations[itemIndex]
        }
    }

    // MARK: - Actions ⚡️

    extension DemoCellTableViewCell {

        @IBAction func buttonHandler(_: AnyObject) {
            print("tap")
            
            
        }
    }

