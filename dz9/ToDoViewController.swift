//
//  ToDoViewController.swift
//  dz9
//
//  Created by Андрей Адельбергис on 26.10.2021.
//

import UIKit

class ToDoViewController: UIViewController {

    var realmDatabase = true
    var tasks : [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasks = realmDatabase ? RealmDatabase.shared.loadTasks() : CoreDataDatabase.shared.loadTasks()
        tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CreateTaskViewController, segue.identifier == "ShowCreateTask"{
            vc.delegate = self
        }
    }
    
}

extension ToDoViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell") as! ToDoTableViewCell
        cell.taskTextLabel.text = tasks[indexPath.row]

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tasks.remove(at: indexPath.row)
        realmDatabase ? RealmDatabase.shared.deleteTask(currentTask: indexPath.row) : CoreDataDatabase.shared.deleteTask(currentTask: indexPath.row)
        tasks = realmDatabase ? RealmDatabase.shared.loadTasks() : CoreDataDatabase.shared.loadTasks()
        tableView.reloadData()
    }
    
    
}

extension ToDoViewController: CreateTaskDelegate{
    func createTask(_ task: String) {
        realmDatabase ? RealmDatabase.shared.saveTask(task: task) : CoreDataDatabase.shared.saveTask(task: task)
        //tasks.append(task)
        tasks = realmDatabase ? RealmDatabase.shared.loadTasks() : CoreDataDatabase.shared.loadTasks()
        tableView.reloadData()
    }
    
    
}
