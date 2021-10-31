//
//  ToDoViewController.swift
//  dz9
//
//  Created by Андрей Адельбергис on 26.10.2021.
//

import UIKit

class ToDoViewController: UIViewController {

    var realmDatabase = true
    var tasksRealm : [ItemRealm] = []
    var tasksDataCore: [ItemCoreData] = []
    var currentTask = 0
    var currentText = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if realmDatabase{
            tasksRealm = RealmDatabase.shared.loadTasks()
        } else {
            tasksDataCore = CoreDataDatabase.shared.loadTasks()
        }
        tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CreateTaskViewController, segue.identifier == "ShowCreateTask"{
            if (sender as? UIButton) == nil{
                //vc.textTaskTextField =
                vc.currentTask = currentTask
                vc.currentText = currentText
                vc.create = false
            }else{
                vc.create = true
            }
            vc.delegate = self
            
        }
    }
    
}

extension ToDoViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realmDatabase ? tasksRealm.count : tasksDataCore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell") as! ToDoTableViewCell
        cell.taskTextLabel.text = realmDatabase ? tasksRealm[indexPath.row].task : tasksDataCore[indexPath.row].task
        if realmDatabase{
            cell.backgroundColor = tasksRealm[indexPath.row].taskComplete ? UIColor.green : UIColor.white
        } else {
            cell.backgroundColor = tasksDataCore[indexPath.row].taskComplete ? UIColor.green : UIColor.white
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tasks.remove(at: indexPath.row)
        if realmDatabase{
            RealmDatabase.shared.updateTask(currentTask: indexPath.row, changeText: tasksRealm[indexPath.row].task, changeComplete: !tasksRealm[indexPath.row].taskComplete)
            tasksRealm = RealmDatabase.shared.loadTasks()
        } else {
            CoreDataDatabase.shared.updateTask(currentTask: indexPath.row, changeText: tasksDataCore[indexPath.row].task!, changeComplete: !tasksDataCore[indexPath.row].taskComplete)
            tasksDataCore = CoreDataDatabase.shared.loadTasks()
        }

        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, complete in
                self.realmDatabase ? RealmDatabase.shared.deleteTask(currentTask: indexPath.row) : CoreDataDatabase.shared.deleteTask(currentTask: indexPath.row)
                if self.realmDatabase{
                    self.tasksRealm = RealmDatabase.shared.loadTasks()
                } else {
                    self.tasksDataCore = CoreDataDatabase.shared.loadTasks()
                }
                self.tableView.reloadData()
                    
        }
        let editingAction = UIContextualAction(style: .destructive, title: "Изменить") { _, _, complete in
            
            print("Нажато")
            self.currentTask = indexPath.row
            self.currentText = (self.realmDatabase ? self.tasksRealm[indexPath.row].task : self.tasksDataCore[indexPath.row].task)!
            self.performSegue(withIdentifier: "ShowCreateTask", sender: self)
        }
                
                deleteAction.backgroundColor = .red
                editingAction.backgroundColor = .gray
                let configuration = UISwipeActionsConfiguration(actions: [deleteAction,editingAction])
                configuration.performsFirstActionWithFullSwipe = true
                return configuration
    }
    
    
}

extension ToDoViewController: CreateTaskDelegate{
    func createTask(_ task: String) {
        realmDatabase ? RealmDatabase.shared.saveTask(task: task) : CoreDataDatabase.shared.saveTask(task: task)
        //tasks.append(task)
        if self.realmDatabase{
            self.tasksRealm = RealmDatabase.shared.loadTasks()
        } else {
            self.tasksDataCore = CoreDataDatabase.shared.loadTasks()
        }
        tableView.reloadData()
    }
    func changeTask(currentTask: Int,changeText: String) {
        if realmDatabase{
            RealmDatabase.shared.updateTask(currentTask: currentTask, changeText: changeText, changeComplete: false)
            self.tasksRealm = RealmDatabase.shared.loadTasks()
        } else {
            CoreDataDatabase.shared.updateTask(currentTask: currentTask, changeText: changeText, changeComplete: false)
            self.tasksDataCore = CoreDataDatabase.shared.loadTasks()
        }
        tableView.reloadData()
    }
    
    
}
