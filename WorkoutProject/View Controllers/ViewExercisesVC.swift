//
//  ViewExercisesVC.swift
//  WorkoutProject
//
//  Created by Mnet on 08/07/1441 AH.
//  Copyright © 1441 Talha. All rights reserved.
//

import UIKit
import RealmSwift

class ViewExercisesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var thisExer = [Exercise]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "WorkoutTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "WorkoutCell")
//        tableView.register(WorkoutTableViewCell.self, forCellReuseIdentifier: "WorkoutCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        resetValues()
        getExercises()
        WorkoutModel.shared.isUpdated = false
        self.tableView.reloadData()
    }
    
    func resetValues() {
        
           WorkoutModel.shared.exerciseMon.removeAll()
           WorkoutModel.shared.exerciseTue.removeAll()
           WorkoutModel.shared.exerciseWed.removeAll()
           WorkoutModel.shared.exerciseThu.removeAll()
           WorkoutModel.shared.exerciseFri.removeAll()
           WorkoutModel.shared.exerciseSat.removeAll()
           WorkoutModel.shared.exerciseSun.removeAll()
        
    }
    
    
}


extension ViewExercisesVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return thisExer.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell") as! WorkoutTableViewCell
        
        if indexPath.row == 0 {
            
            cell.lblWorkoutName.text = "Workout Name"
            cell.TF_Workout.text = thisExer[indexPath.section].nameOfWorkout
        }
        
        else if indexPath.row == 1 {
            
            cell.lblWorkoutName.text = "Number Of Sets"
            cell.TF_Workout.text = thisExer[indexPath.section].numberOfSets
        }
        
        else if indexPath.row == 2{
            
            cell.lblWorkoutName.text = "Rep Range"
            cell.TF_Workout.text = thisExer[indexPath.section].repRange
        }
        
        else {
                  
                  cell.lblWorkoutName.text = "Weights"
                  cell.TF_Workout.text = thisExer[indexPath.section].weights
              }
              
        
        
//        cell.TF_Workout.text = "TESTING3423r"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nextVC = self.storyboard?.instantiateViewController(identifier: "AddWorkout") as! AddWorkoutViewController
            WorkoutModel.shared.isUpdated = true
              nextVC.selDay = thisExer[indexPath.section].Day
              nextVC.numberOfSets = thisExer[indexPath.section].numberOfSets
              nextVC.repRange = thisExer[indexPath.section].repRange
              nextVC.workoutName = thisExer[indexPath.section].nameOfWorkout
            nextVC.weights = thisExer[indexPath.section].weights
        
//              WorkoutModel.shared.selDay = daysArr[sender.tag]
            self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    func getExercises() {
        let realm = try! Realm()
        let Exercises = realm.objects(Exercise.self)
        print(Exercises)
        
        for tempExercise in Exercises {
            
            if tempExercise.Day == "Monday" && WorkoutModel.shared.selDay == "Monday" {
                WorkoutModel.shared.exerciseMon.append(tempExercise)
                thisExer = WorkoutModel.shared.exerciseMon
                }
            
            else if tempExercise.Day == "Tuesday" && WorkoutModel.shared.selDay == "Tuesday" {
                WorkoutModel.shared.exerciseTue.append(tempExercise)
                thisExer = WorkoutModel.shared.exerciseTue
            }
            
            else if tempExercise.Day == "Wednesday" && WorkoutModel.shared.selDay == "Wednesday" {
                
                WorkoutModel.shared.exerciseWed.append(tempExercise)
                thisExer = WorkoutModel.shared.exerciseWed
            }
            
            else if tempExercise.Day == "Thursday" && WorkoutModel.shared.selDay == "Thursday"{
                
                WorkoutModel.shared.exerciseThu.append(tempExercise)
                thisExer = WorkoutModel.shared.exerciseThu
                
            }
            
            else if tempExercise.Day == "Friday" && WorkoutModel.shared.selDay == "Friday"{
                
                WorkoutModel.shared.exerciseFri.append(tempExercise)
                thisExer = WorkoutModel.shared.exerciseFri
            }
            
            else if tempExercise.Day == "Saturday" && WorkoutModel.shared.selDay == "Saturday"{
                
                WorkoutModel.shared.exerciseSat.append(tempExercise)
                thisExer = WorkoutModel.shared.exerciseSat

                    
            }
            
            else if tempExercise.Day == "Sunday" && WorkoutModel.shared.selDay == "Sunday"{
                
                WorkoutModel.shared.exerciseSun.append(tempExercise)
                thisExer = WorkoutModel.shared.exerciseSun

                
            }
        }
    }
}
