//
//  ViewController.swift
//  dz9
//
//  Created by Андрей Адельбергис on 26.10.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ToDoViewController, segue.identifier == "ShowA"{
            vc.realmDatabase = true
        } else if let vc = segue.destination as? ToDoViewController, segue.identifier == "ShowB"{
            vc.realmDatabase = false
        }
    }

}

