//
//  ConfirmSmsCodeViewController.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 10.04.2021.
//

import UIKit
import MaterialComponents

class ConfirmSmsCodeViewController: UIViewController {
    
    @IBOutlet var smsCodeField: TextFieldWithCounter!
    @IBOutlet var submitButton: MDCRaisedButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeComponents()
    }
    
    // MARK: View Callbacks
    
    @IBAction func submitButtonClick(_ sender: MDCRaisedButton) {
        view.endEditing(true)
        
        if smsCodeField.isFilled {
            let phoneNumber = Preferences.getPhoneNumber()
            let smsCode = smsCodeField.text

            SocketHandler.signIn(phoneNumber: phoneNumber, code: smsCode) { result in
                switch result {
                case .failure(let error):
                    self.handleFailure(message: (error as! ErrorObject).message)
                case .success(let userData):
                    Preferences.saveUserData(userData as! UserObject)
                    self.handleSuccess()
                }
            }
        } else {
            smsCodeField.showError(message: Localization.invalidFormat)
        }
    }
    
    // MARK: Touches
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    // MARK: Custom functions
    
    private func handleFailure(message: String) {
        smsCodeField.showError(message: message)
    }
    
    private func handleSuccess() {
        UIApplication.shared.keyWindow!.rootViewController = UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController()
    }
    
    private func initializeComponents() {
        smsCodeField.maxTextLength = 4
        smsCodeField.textField.keyboardType = .numberPad
        smsCodeField.textField.placeholder = Localization.smsCode
        smsCodeField.textField.textContentType = .oneTimeCode
        
        submitButton.setTitle(Localization.submit, for: .normal)
    }
    
}
