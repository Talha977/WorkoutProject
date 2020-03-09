//
//  AddWorkoutViewController.swift
//  WorkoutProject
//
//  Created by Mnet on 06/07/1441 AH.
//  Copyright © 1441 Talha. All rights reserved.
//

import UIKit
import RealmSwift


class AddWorkoutViewController: UIViewController {
    
    var selDay = String()
    
    @IBOutlet weak var BtnAdd: UIButton!
    
    // For Updated Only
    
    var workoutName = String()
    var numberOfSets = String()
    var repRange = String()
    var weights = String()
    var notes = String()
    
    
    //    MARK: - IBOUTLETS
    
//    @IBOutlet weak var TF_NoWorkout: UITextField!
    
    
    @IBOutlet weak var TF_Notes: UITextField!
    
    @IBOutlet weak var TF_NoSets: UITextField!
    
    @IBOutlet weak var TF_RepRange: UITextField!
    
//    @IBOutlet weak var TF_Weights: UITextField!
    
    
    //    MARK: - IBActions
    
    
    @IBAction func btnAdd(_ sender: UIButton) {
        
//        if WorkoutModel.shared.isUpdated {
        updateWorkoutWithExercise()
//        }
//        else{
//        AddWorkoutWithExercise()
//        }
        
    }
    
    //    MARK: - didLoadFunctions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
//        if WorkoutModel.shared.isUpdated {
         
//            TF_NoWorkout.text = workoutName
            TF_NoSets.text = numberOfSets
            TF_RepRange.text = repRange
            TF_Notes.text = notes
        
//            TF_Weights.text = weights
            BtnAdd.setTitle("Update", for: .normal)
            
//        }
    }
    
    
//    func AddWorkoutWithExercise() {
//
//        let newExercise = Exercise()
////        newExercise.nameOfWorkout = TF_NoWorkout.text!
//        newExercise.nameOfWorkout = workoutName
//        newExercise.numberOfSets = TF_NoSets.text!
//        newExercise.repRange = TF_RepRange.text!
////        newExercise.weights = TF_Weights.text!
//        newExercise.Notes = TF_Notes.text ?? ""
//
//        newExercise.Day = selDay
//
//        let realm = try! Realm()
//        try! realm.write {
//            realm.add(newExercise)
//        }
//
//        getExercises()
//    }
    
    func updateWorkoutWithExercise() {
        
        let realm = try! Realm()
        
        for tempExercise in realm.objects(Exercise.self)
        {
        
            if tempExercise.nameOfWorkout == workoutName {
            
             try! realm.write {
            
                
                
                tempExercise.numberOfSets = TF_NoSets.text ?? ""
                tempExercise.repRange = TF_RepRange.text ?? ""
                tempExercise.Notes = TF_Notes.text ?? ""
//                tempExercise.weights = TF_Weights.text ?? ""
           }
        
           print(realm.objects(Exercise.self))
//        }
        }
        
    }
    
    func getExercises() {
        let realm = try! Realm()
        let Exercises = realm.objects(Exercise.self)
        print(Exercises)
        
    }
    
}
}

// For updating Data

//if let user = realm.objects(User.self).first
//{
//   try! realm.write {
//      user.name = "James"
//
//      if let pet = user.pet
//      {
//         pet.name = "Jack"
//      }
//   }
//
//   print(realm.objects(User.self).first)
//}

// For Deleting Data

//if let user = realm.objects(User.self).first
//{
//   try! realm.write {
//      realm.delete(user)
//   }
//
//   print(realm.objects(User.self))
//}
