//
//  ViewController.swift
//  PasswordPOC
//
//  Created by Natalia Sibaja on 5/8/19.
//  Copyright © 2019 Natalia Sibaja. All rights reserved.
//

import UIKit
import zxcvbn_ios

class ViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var passwordStrenghtMeeterView: DBPasswordStrengthMeterView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate = self
    }


}
extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let password = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) {
            
            // Update the meter view
            let userInputs = [firstNameTextField.text ?? "", lastNameTextField.text ?? ""]
            passwordStrenghtMeeterView.scorePassword(password, userInputs: userInputs)
            
            // Score the password
            let result = DBZxcvbn().passwordStrength(password, userInputs: userInputs)
            resultsLabel.text = "Entropy: \(result?.entropy ?? "")\n" +
                "Crack time (sec): \(result?.crackTime ?? "")\n" +
                "Crack time display: \(result?.crackTimeDisplay ?? "")\n" +
            "Score: \(result?.score ?? 0)\n"
        }
        
        return true
    }
}
