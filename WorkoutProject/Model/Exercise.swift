//
//  ExerciseModel.swift
//  WorkoutProject
//
//  Created by Mnet on 06/07/1441 AH.
//  Copyright © 1441 Talha. All rights reserved.
//

import Foundation
import RealmSwift

class Exercise:Object {
    @objc dynamic var nameOfWorkout = String()
    @objc dynamic var numberOfSets  = String()
    @objc dynamic var repRange = String()
    @objc dynamic var Day = String()
    @objc dynamic var weights = String()
    @objc dynamic var Notes = String()
    @objc dynamic var WorkoutDate = String()
    
//    init(nameOfWorkout:String,numberOfSets:String,repRange:String) {
//        self.nameOfWorkout = nameOfWorkout
//        self.numberOfSets = numberOfSets
//        self.repRange = repRange
//    }
}

