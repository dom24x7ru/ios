//
//  SignInViewController.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 01.04.2021.
//

import UIKit
import MaterialComponents

class SignInViewController: UIViewController {
    
    @IBOutlet var phoneNumberField: TextFieldWithCounter!
    @IBOutlet var signInButton: MDCRaisedButton!
    @IBOutlet var separatorLabel: UILabel!
    @IBOutlet var registerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeComponents()
    }
    
    // MARK: View Callbacks
    
    @IBAction func signInButtonClick(_ sender: MDCRaisedButton) {
        view.endEditing(true)
        
        if phoneNumberField.isFilled {
            let phoneNumber = phoneNumberField.text
            
            Preferences.savePhoneNumber(phoneNumber)
            SocketHandler.signIn(phoneNumber: phoneNumber) { result in
                switch result {
                case .failure(let error):
                    self.handleFailure(message: (error as! ErrorObject).message)
                case .success(_):
                    self.handleSuccess()
                }
            }
        } else {
            phoneNumberField.showError(message: Localization.invalidFormat)
        }
    }
    
    // MARK: Touches
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: Custom functions
        
    private func handleFailure(message: String) {
        phoneNumberField.showError(message: message)
    }
    
    private func handleSuccess() {
        present(UIStoryboard.getViewController("ConfirmSmsCodeController", in: "SignIn"), animated: true, completion: nil)
    }

    private func initializeComponents() {
        phoneNumberField.maxTextLength = 10
        phoneNumberField.textField.keyboardType = .numberPad
        phoneNumberField.textField.placeholder = Localization.yourPhoneNumber
        separatorLabel.text = "– " + Localization.or + " –"

        phoneNumberField.setPrefixText("+7")
        signInButton.setTitle(Localization.signIn, for: .normal)
        registerButton.setTitle(Localization.register, for: .normal)
    }
    
}
