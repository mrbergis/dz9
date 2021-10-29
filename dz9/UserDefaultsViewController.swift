//
//  UserDefaultsViewController.swift
//  dz9
//
//  Created by Андрей Адельбергис on 26.10.2021.
//

import UIKit

class UserDefaultsViewController: UIViewController {

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        surnameTextField.delegate = self
        nameTextField.text = Persistacne.shared.userName
        surnameTextField.text = Persistacne.shared.surName
        // Do any additional setup after loading the view.
    }
    
}

extension UserDefaultsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        if textField.tag == 1{
            Persistacne.shared.userName = textField.text
        } else if textField.tag == 2 {
            Persistacne.shared.surName = textField.text
        }
        return true
    }
}
