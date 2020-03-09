//
//  extensions.swift
//  WorkoutProject
//
//  Created by Mnet on 12/07/1441 AH.
//  Copyright © 1441 Talha. All rights reserved.
//

import Foundation

import UIKit

@IBDesignable
class FormTextField: UITextField {

    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
}

extension Date {

    static func getDayOfWeek() -> String
    {
        let df  = DateFormatter()
        df.dateFormat = "YYYY-MM-dd"
        let date = Date()
        df.dateFormat = "EEEE"
        return df.string(from: date);
    }
    
    static func asString() -> String {
     let formatter = DateFormatter()
       // initially set the format based on your datepicker date / server String
       formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

       let myString = formatter.string(from: Date()) // string purpose I add here
       // convert your string to date
       let yourDate = formatter.date(from: myString)
       //then again set the date format whhich type of output you need
       formatter.dateFormat = "dd-MMM-yyyy"
       // again convert your date to string
       let myStringafd = formatter.string(from: yourDate!)

       print(myStringafd)
        
      return myStringafd
     }
    
    
}

