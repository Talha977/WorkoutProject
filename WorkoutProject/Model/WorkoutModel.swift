//
//  ExerciseModel.swift
//  WorkoutProject
//
//  Created by Mnet on 06/07/1441 AH.
//  Copyright © 1441 Talha. All rights reserved.
//

import Foundation

class WorkoutModel:NSObject {
    
    static var shared = WorkoutModel()

    var isUpdated = false
    
    var exerciseArr = [Exercise]()
    
    var workoutNames = [String]()
    
    var exerciseMon = [Exercise]()
    var exerciseTue = [Exercise]()
    var exerciseWed = [Exercise]()
    var exerciseThu = [Exercise]()
    var exerciseFri = [Exercise]()
    var exerciseSat = [Exercise]()
    var exerciseSun = [Exercise]()
    
    var selDay = String()
    
    var currentWorkout = String()
    
}
