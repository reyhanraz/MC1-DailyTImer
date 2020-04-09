//
//  TaskList.swift
//  MC1-DailyTImer
//
//  Created by Muhamad Vicky on 07/04/20.
//  Copyright © 2020 Muhamad Vicky. All rights reserved.
//

import UIKit

class TaskList: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var editNameBtn: UIButton!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var taskTable: UITableView!
    
    var userName = ""
    
    let upcomingTasks = [
            Task(taskName: "Coding", taskDesc: "MC-1", estimatedTime: 25, timePerSession: 10, breakPerSession: 5, priority: "high"),
            Task(taskName: "Cuci", taskDesc: "Piring", estimatedTime: 60, timePerSession: 25, breakPerSession: 10, priority: "high")
    ]
    
    let completedTasks = [
            Task(taskName: "Belajar", taskDesc: "Inggris", estimatedTime: 70, timePerSession: 15, breakPerSession: 10, priority: "high")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTable.reloadData()
        
        taskTable.dataSource = self
        taskTable.delegate = self
        
        nameTxt.isEnabled = false
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.endEditing (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        // Untuk Meng-set Nama
        nameTxt.text = userName
    }
    
    @objc func endEditing (_ sender: UITapGestureRecognizer){
        nameTxt.isEnabled = false
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionName: String
        switch section {
            case 0:
                sectionName = NSLocalizedString("Your Upcoming Task", comment: "mySectionName")
            case 1:
                sectionName = NSLocalizedString("Your Completed Task", comment: "myOtherSectionName")
            default:
                sectionName = ""
        }
        return sectionName
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return upcomingTasks.count
        }
        return completedTasks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  70
    }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! taskTableViewCell
        
        let task = indexPath.section == 0 ? upcomingTasks[indexPath.row] : completedTasks[indexPath.row]
        
        cell.taskNameLb?.text = task.taskName
        cell.taskDescLb?.text = task.taskDesc
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("row \(indexPath)")
        //INI GA NGERTI KENAPA CELLNYA GA MAU NGE-SEGUE
        //Gue coba barusan cell nya belom bisa di klik -Reyhan
        //pas tabble di klik print nya ga keluar
        //nanti kalo tabble nya udah bisa di klik lu tinggal apus commend dibawah dua-duanya
        
//        let task  = upcomingTasks[index row nya nanti]
//        performSegue(withIdentifier: "toStartSession", sender: task)
    }
    
    @IBAction func editNameClicked(_ sender: Any) {
        nameTxt.isEnabled = true
        nameTxt.becomeFirstResponder()
    }
    
    @IBAction func ToAddTask(_ sender: Any) {
        self.performSegue(withIdentifier: "toAddTask", sender: nil)
    }
    
    @IBAction func ToStartSession(_ sender: Any) {
        
        let task  = upcomingTasks[0]
        self.performSegue(withIdentifier: "toStartSession", sender: task)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddTask"{
            
        }else if segue.identifier == "toStartSession"{
                if let destination = segue.destination as? Session{
                destination.initUI(task: sender as! Task)
            }
        }
    }
}

class taskTableViewCell: UITableViewCell {
      
    @IBOutlet weak var taskNameLb: UILabel!
    @IBOutlet weak var taskDescLb: UILabel!
    @IBOutlet weak var priorityImage: UIImageView!
    
}
