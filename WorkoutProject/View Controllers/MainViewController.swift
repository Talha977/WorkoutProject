//
//  MainViewController.swift
//  Expandable-TableViewCell-StackView
//
//  Created by Akash Malhotra on 7/8/16.
//  Copyright © 2016 Akash Malhotra. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {
    
    
//    MARK: - VARIABLES
    
    var currentDay = String()
    
    var currentExercises = [Exercise]()
    
    //    MARK: - OUTLETS
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var BtndayPlus: UIButton!
    
    @IBOutlet weak var lblDay: UILabel!
    
//    var tempExercises = ["Bicep Curl","Tri Curl","Shi Curl","Li Curl","Mi Curl","Ci Curl",]
    
    //    MARK: - Life Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        print(path)
        
        currentDay =  Date.getDayOfWeek()
        self.lblDay.text = currentDay
        getCurrentExerArr()
        
        getExercises()
        BtndayPlus.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    //    MARK: - FUNCTIONS

    
    @objc func showAlert() {
        
        let alert = UIAlertController(title: "New Workout", message: "Workout Name", preferredStyle: .alert)

        alert.addTextField { (TF_workoutName) in
                 
        }

        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
//            print("Text field: \(textField.text)")
            self.currentExercises.removeAll()
            
            let newExercise = Exercise()
                     //        newExercise.nameOfWorkout = TF_NoWorkout.text!
                         newExercise.nameOfWorkout = textField!.text!
                             
                     //        newExercise.weights = TF_Weights.text!
                             

                         newExercise.Day = self.lblDay.text!
                        newExercise.WorkoutDate = Date.asString()
                        let realm = try! Realm()
                            try! realm.write {
                                 realm.add(newExercise)
                                
                             }
            self.getExercises()
             
            
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func getExercises() {
        
        var config = Realm.Configuration()
        config.schemaVersion = 1
        config.migrationBlock = {
        migration, oldSchemaVersion in
            
        if (oldSchemaVersion < 1) {
                
                migration.enumerateObjects(ofType: Exercise.className(), {
                  oldObj,newObj in
                    
                    newObj!["Notes"] = ""
                    newObj!["WorkoutDate"] = ""
                    
                })
                
            }
            
        }
        let realm = try! Realm(configuration: config)
//        let realm = try! Realm()
        let Exercises = realm.objects(Exercise.self)
              for exercise in Exercises {
                    
                    if exercise.Day == currentDay{
                    self.currentExercises.append(exercise)
                 }
                 self.tableView.reloadData()
                 print(currentExercises)
        
    }
    }
    
    @objc func showSetup(sender:UIButton) {
        
        let nextVC = self.storyboard?.instantiateViewController(identifier: "AddWorkout") as! AddWorkoutViewController
        nextVC.selDay = lblDay.text!
        nextVC.workoutName = currentExercises[sender.tag].nameOfWorkout
        nextVC.numberOfSets = currentExercises[sender.tag].numberOfSets
        nextVC.repRange = currentExercises[sender.tag].repRange
        nextVC.notes = currentExercises[sender.tag].Notes
        self.navigationController?.pushViewController(nextVC, animated: true)
        
        
    }
    func migrateAct() {
            var config = Realm.Configuration()
            Realm.Configuration.defaultConfiguration = config

    }
    
    func getCurrentExerArr() {
            
        let model = WorkoutModel.shared
        
        switch currentDay {
            
        case "Monday":
            currentExercises = model.exerciseMon
            
        case "Tuesday":
            currentExercises = model.exerciseTue
            
        case "Wednesday":
            currentExercises = model.exerciseWed
            
        case "Thursday":
            currentExercises = model.exerciseThu
            

        case "Friday":
            currentExercises = model.exerciseFri
            

        case "Saturday":
            currentExercises = model.exerciseSat
            
        case "Sunday":
            currentExercises = model.exerciseSun
            
        default:
        return
        }
        
        
    }


}

//    MARK: - TABLEVIEW EXTENSION


extension MainViewController:UITableViewDelegate,UITableViewDataSource {
    
    
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // return WorkoutModel.shared.exerciseMon.count
            currentExercises.count
            
    
    }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
            
    //        cell.btnPlus.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
    //        cell.TF_Workout.text = tempExercises[indexPath.row]
            cell.TF_Workout.text =  currentExercises[indexPath.row].nameOfWorkout
            cell.btnPlus.tag = indexPath.row
            cell.btnPlus.addTarget(self, action: #selector(showSetup), for: .touchUpInside)
            
            return cell
        }
        
        
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 50
        }
    
}
