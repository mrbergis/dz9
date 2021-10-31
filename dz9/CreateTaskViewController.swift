//
//  CreateTaskViewController.swift
//  dz9
//
//  Created by Андрей Адельбергис on 26.10.2021.
//

import UIKit

protocol CreateTaskDelegate{
    func createTask(_ task:String)
    func changeTask(currentTask: Int,changeText: String)
}

class CreateTaskViewController: UIViewController {
    
    @IBOutlet weak var textTaskTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var changeButton: UIButton!
    
    var create = true
    var currentTask: Int?
    var currentText: String?
    
    var delegate: CreateTaskDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if create {
            changeButton.isHidden = true
            createButton.isHidden = false
        }else{
            changeButton.isHidden = false
            createButton.isHidden = true
            textTaskTextField.text = currentText
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func createTask(_ sender: UIButton) {
        dismiss(animated: true,completion: nil)
        if sender.tag == 1 {
            delegate?.createTask(textTaskTextField.text!)
        } else if sender.tag == 2 {
            delegate?.changeTask(currentTask: currentTask!, changeText: textTaskTextField.text!)
        }
       
    }
    
}
