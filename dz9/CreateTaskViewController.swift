//
//  CreateTaskViewController.swift
//  dz9
//
//  Created by Андрей Адельбергис on 26.10.2021.
//

import UIKit

protocol CreateTaskDelegate{
    func createTask(_ task:String)
}

class CreateTaskViewController: UIViewController {
    
    @IBOutlet weak var textTaskTextField: UITextField!
    
    var delegate: CreateTaskDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func createTask(_ sender: Any) {
        dismiss(animated: true,completion: nil)
        delegate?.createTask(textTaskTextField.text!)
    }
    
}
