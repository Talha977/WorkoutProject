////
////  TableViewController.swift
////
//// Copyright (c) 21/12/15. Ramotion Inc. (http://ramotion.com)
////
//// Permission is hereby granted, free of charge, to any person obtaining a copy
//// of this software and associated documentation files (the "Software"), to deal
//// in the Software without restriction, including without limitation the rights
//// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//// copies of the Software, and to permit persons to whom the Software is
//// furnished to do so, subject to the following conditions:
////
//// The above copyright notice and this permission notice shall be included in
//// all copies or substantial portions of the Software.
////
//// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//// THE SOFTWARE.
//
//import FoldingCell
//import UIKit
//import RealmSwift
//
//class TableViewController: UITableViewController {
//
//    enum Const {
//        static let closeCellHeight: CGFloat = 179
////        static let openCellHeight: CGFloat = 1000
//        static let openCellHeight: CGFloat = 450
//
//        static let rowsCount = 10
//    }
//
//
//
//    var cellHeights: [CGFloat] = []
//
//    var daysArr = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
//
//    // MARK: Life Cycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setup()
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//
//        resetValues()
////        BottomViewHeight.constant = 550
//    }
//
//    // MARK: Helpers
//
//    func resetValues() {
//
//           WorkoutModel.shared.exerciseMon.removeAll()
//           WorkoutModel.shared.exerciseTue.removeAll()
//           WorkoutModel.shared.exerciseWed.removeAll()
//           WorkoutModel.shared.exerciseThu.removeAll()
//           WorkoutModel.shared.exerciseFri.removeAll()
//           WorkoutModel.shared.exerciseSat.removeAll()
//           WorkoutModel.shared.exerciseSun.removeAll()
//           WorkoutModel.shared.isUpdated = false
//
//
//    }
//    private func setup() {
//        cellHeights = Array(repeating: Const.closeCellHeight, count: Const.rowsCount)
//        tableView.estimatedRowHeight = Const.closeCellHeight
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.backgroundColor = .lightGray
//        if #available(iOS 10.0, *) {
//            tableView.refreshControl = UIRefreshControl()
//            tableView.refreshControl?.addTarget(self, action: #selector(refreshHandler), for: .valueChanged)
//        }
//    }
//
//    // MARK: Actions
//    @objc func refreshHandler() {
//
//        let deadlineTime = DispatchTime.now() + .seconds(1)
//        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: { [weak self] in
//            if #available(iOS 10.0, *) {
//                self?.tableView.refreshControl?.endRefreshing()
//            }
//            self?.tableView.reloadData()
//        })
//    }
//}
//
//// MARK: - TableView
//
//extension TableViewController {
//
//    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
//        return 7
//    }
//
//    override func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        guard case let cell as DemoCellTableViewCell = cell else {
//            return
//        }
//
//        cell.backgroundColor = .clear
//        cell.lblDayUnFolded.text = daysArr[indexPath.row]
//        cell.btnAdd.tag = indexPath.row
//        cell.btnUpdate.tag = indexPath.row
//        cell.btnClear.tag = indexPath.row
//        cell.btnClear.addTarget(self, action: #selector(clearWorkouts(sender:)), for: .touchUpInside)
//        cell.btnAdd.addTarget(self, action: #selector(switchController), for: .touchUpInside)
//        cell.btnUpdate.addTarget(self, action: #selector(viewWorkouts), for: .touchUpInside)
//        if cellHeights[indexPath.row] == Const.closeCellHeight {
//            cell.unfold(false, animated: false, completion: nil)
//        } else {
//            cell.unfold(true, animated: false, completion: nil)
//        }
//
//        //        cell.number = indexPath.row
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "FoldingCell", for: indexPath) as! DemoCellTableViewCell
//        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
//        cell.lblDayFolded.text = daysArr[indexPath.row]
//        cell.durationsForExpandedState = durations
//        cell.durationsForCollapsedState = durations
//        return cell
//    }
//
//    override func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return cellHeights[indexPath.row]
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
//
//        if cell.isAnimating() {
//            return
//        }
//
//        var duration = 0.0
//        let cellIsCollapsed = cellHeights[indexPath.row] == Const.closeCellHeight
//        if cellIsCollapsed {
//            cellHeights[indexPath.row] = Const.openCellHeight
//            cell.unfold(true, animated: true, completion: nil)
//            duration = 0.5
//
//
//        } else {
//            cellHeights[indexPath.row] = Const.closeCellHeight
//            cell.unfold(false, animated: true, completion: nil)
//            duration = 0.8
//        }
//
//        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
//            tableView.beginUpdates()
//            tableView.endUpdates()
//
//            // fix https://github.com/Ramotion/folding-cell/issues/169
//            if cell.frame.maxY > tableView.frame.maxY {
//                tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: true)
//            }
//        }, completion: nil)
//    }
//
//    @objc func switchController(sender:UIButton) {
//
//        let nextVC = self.storyboard?.instantiateViewController(identifier: "AddWorkout") as! AddWorkoutViewController
//        nextVC.selDay = daysArr[sender.tag]
//        WorkoutModel.shared.selDay = daysArr[sender.tag]
//        self.navigationController?.pushViewController(nextVC, animated: true)
//
//    }
//
//    @objc func viewWorkouts(sender:UIButton) {
//
//        WorkoutModel.shared.selDay = daysArr[sender.tag]
//        let nextVC = self.storyboard?.instantiateViewController(identifier: "viewExercises") as! ViewExercisesVC
//        self.navigationController?.pushViewController(nextVC, animated: true)
//
//
//    }
//
//    @objc func clearWorkouts(sender:UIButton) {
//
//        deleteWorkout(day: daysArr[sender.tag])
//
//    }
//
//    func deleteWorkout(day:String) {
//        let realm = try! Realm()
//
//        for tempExercise in realm.objects(Exercise.self)
//        {
//
//            if tempExercise.Day == day {
//                try! realm.write {
//                    realm.delete(tempExercise)
//                }
//            }
//            print(realm.objects(Exercise.self))
//        }
//    }
//}
//
