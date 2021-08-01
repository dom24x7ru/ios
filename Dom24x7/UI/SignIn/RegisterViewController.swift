//
//  RegisterViewController.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 03.04.2021.
//

import UIKit
import MaterialComponents

class RegisterViewController: UIViewController {
    
    @IBOutlet var phoneNumberField: TextFieldWithCounter!
    @IBOutlet var phoneNumberConfirmField: TextFieldWithCounter!
    @IBOutlet var inviteCodeField: TextFieldWithCounter!
    @IBOutlet var registerButton: MDCRaisedButton!
    @IBOutlet var separatorLabel: UILabel!
    @IBOutlet var signInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeComponents()
    }
    
    // MARK: View Callbacks
    
    @IBAction func registerButtonClick(_ sender: MDCRaisedButton) {
        view.endEditing(true)
        
        if phoneNumberField.isFilled {
            if phoneNumberConfirmField.isFilled {
                if phoneNumberField.text == phoneNumberConfirmField.text {
                    if inviteCodeField.isFilled {
                        let phoneNumber = phoneNumberField.text
                        let inviteCode = inviteCodeField.text
                        
                        Preferences.savePhoneNumber(phoneNumber)
                        SocketHandler.register(phoneNumber: phoneNumber, invite: inviteCode) { result in
                            switch result {
                            case .failure(let error):
                                self.handleFailure(message: (error as! ErrorObject).message)
                            case .success(_):
                                self.handleSuccess()
                            }
                        }
                    } else {
                        inviteCodeField.showError(message: Localization.invalidFormat)
                    }
                } else {
                    phoneNumberField.showError(message: Localization.phoneNumbersMustBeIdentical)
                    phoneNumberConfirmField.showError(message: Localization.phoneNumbersMustBeIdentical)
                }
            } else {
                phoneNumberConfirmField.showError(message: Localization.invalidFormat)
            }
        } else {
            phoneNumberField.showError(message: Localization.invalidFormat)
        }
    }
    
    @IBAction func signInButtonClick(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Touche callbacks
    
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
        phoneNumberField.onTextFieldDidBeginEditing = {
            self.phoneNumberConfirmField.hideError()
        }
        
        phoneNumberConfirmField.maxTextLength = 10
        phoneNumberConfirmField.textField.keyboardType = .numberPad
        phoneNumberConfirmField.textField.placeholder = Localization.retypeYourPhoneNumber
        phoneNumberConfirmField.onTextFieldDidBeginEditing = {
            self.phoneNumberField.hideError()
        }
        
        inviteCodeField.maxTextLength = 6
        inviteCodeField.textField.keyboardType = .numberPad
        inviteCodeField.textField.placeholder = Localization.enterInviteCode
        separatorLabel.text = "– " + Localization.or + " –"

        phoneNumberField.setPrefixText("+7")
        phoneNumberConfirmField.setPrefixText("+7")
        registerButton.setTitle(Localization.register, for: .normal)
        signInButton.setTitle(Localization.signIn, for: .normal)
    }
    
}
