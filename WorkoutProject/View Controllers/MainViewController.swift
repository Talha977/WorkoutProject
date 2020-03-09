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
    
     var rectOfCell = CGRect()
    var rectOfCellInSuperview = CGRect()

    
    var currentDay = String()
    
    var currentExercises = [Exercise]()
    
    //    MARK: - OUTLETS
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var BtndayPlus: UIButton!
    
    @IBOutlet weak var lblDay: UILabel!
    
    var dropDownViewController:DropdownViewController?
    

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
        
        var config = Realm.Configuration()
        config.schemaVersion = 1

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
                        let realm = try! Realm(configuration: config)
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
            
            rectOfCell = tableView.rectForRow(at: indexPath)
            rectOfCellInSuperview = tableView.convert(rectOfCell, to: tableView.superview)
            cell.TF_Workout.text =  currentExercises[indexPath.row].nameOfWorkout
            cell.btnPlus.tag = indexPath.row
            cell.btnPlus.addTarget(self, action: #selector(showSetup), for: .touchUpInside)
            cell.btnDropDown.addTarget(self, action: #selector(dropdownSelection(sender:)), for: .touchUpInside)
            
            
            return cell
        }
        
        
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 50
        }
    
}

// MARK: - Drop Down Extension

extension MainViewController: DropdownViewControllerDelegate {
    func dropDown(sender: DropdownViewController, selected: String) {
        
        removeListFromParent()
        
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches , with:event)
        //               self.removeListFromParent()
    }
    
    
    @objc func dropdownSelection(sender:UIButton)  {
        
        self.view.endEditing(true)
        if dropDownViewController == nil {
            
            //               self.uiviewHalfTxtFld.isHidden = false
            let x = rectOfCell.origin.x
            let y = rectOfCell.origin.y
            
            
            //               let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            //            guard let cell = sender.superview?.superview?.superview as? calculatorTableViewCell else {
            //                return // or fatalError() or whatever
            //            }
            //
            //            let indexPath = calculatorTableView.indexPath(for: cell)
            //
            //            rectOfCell = CGRect(x: x+20, y: (y+10) * indexPath?.row) , width: 200, height: 100)
            
            guard let cell = sender.superview?.superview as? CustomTableViewCell else {
                return // or fatalError() or whatever
            }
            
            let indexPath = tableView.indexPath(for: cell)
            
            let rectOfCellInTableView = tableView.rectForRow(at: indexPath!)
            let cellFrame = tableView.convert(rectOfCellInTableView, to: tableView.superview)
            
            var frame = CGRect(x: cell.frame.origin.x + 35  , y: cellFrame.origin.y + 40, width: cell.TF_Workout.frame.width, height: 150)
            
//            if indexPath?.row == 3 {
//                
//                frame = CGRect(x: cell.frame.origin.x + 55  , y: cellFrame.origin.y - 130, width: cell.btnPopupNumber.frame.width, height: 150)
//            }
//            
            let vc = DropdownViewController()
            
            //            for clinics
            if indexPath?.row == 0{
                vc.currentType = .Age
                vc.narcIDArray = ["0-2","3-5","6-8","9-11","11-13","13-15","15-17",">17"]
            }
                
                
            else if indexPath?.row == 1{
                vc.currentType = .Weight
                vc.narcIDArray = ["0-10 lbs","11-20 lbs","21-30 lbs","31-40 lbs","41-50 lbs","51-60 lbs","61-70 lbs","71-80 lbs","81-90 lbs"
                    ,"91-100 lbs","101-110 lbs","111-120 lbs",">120 lbs"]
                
            }
                
//            else if indexPath?.row == 2{
//                vc.currentType = .Clinic
//                var tempArr = [String]()
//                for i in model.clinicArr {
//                    tempArr.append(i.name)
//                }
//                vc.narcIDArray = tempArr
//            }
//
//                //            for Vets
//
//            else if indexPath?.row == 3{
//                vc.currentType = .Vet
//                var tempArr = [String]()
//                for i in model.VetsArr {
//                    tempArr.append(i.name)
//                }
//                vc.narcIDArray = tempArr
//            }
            
            
            //            if indexPath!.row == 0 {
            //                vc.narcIDArray = ["Tier 1 15 %"]
            //
            //            }
            //
            //            else if indexPath!.row == 1 {
            //                 vc.narcIDArray = ["Tier 2 20 %"]
            //            }
            //
            //            else if indexPath!.row == 2{
            //                 vc.narcIDArray = ["Tier 3 25 %"]
            //            }
            //
            //            else if indexPath!.row == 2{
            //                 vc.narcIDArray = ["Tier 4 30 %"]
            //            }
            
            
            
            //            vc.view.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
            self.view.addSubview(vc.view)
            //            self.view.bringSubviewToFront(ViewCalPopup)
            addChild(vc)
            //               uiviewHalfTxtFld.addSubview(vc.view)
            
            vc.view.alpha = 1
            vc.delegate = self
            vc.view.frame = frame
            
            // changedd
            vc.view.layer.cornerRadius = 5
            vc.view.layer.shadowOffset = CGSize(width: 2, height: 5)
            vc.view.layer.shadowRadius = 5
            vc.view.layer.shadowOpacity = 0.5
            vc.view.layer.shadowColor = UIColor.black.cgColor
            //               vc.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            UIView.animate(withDuration: 0.3) {
                vc.view.alpha = 1
            }
            
            dropDownViewController = vc
            
        } else {
            
            self.removeListFromParent()
            
        }
        
    }
    
    func removeListFromParent()  {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.dropDownViewController?.view.alpha = 0
        }, completion: { (complete) in
            //               self.uiviewHalfTxtFld.isHidden = true
            self.dropDownViewController?.removeFromParent()
            self.dropDownViewController?.view.removeFromSuperview()
            self.dropDownViewController = nil
        })
    }
    
}
