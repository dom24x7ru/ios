//
//  ProfileViewController.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 01.08.2021.
//

import UIKit
import MaterialComponents

class ProfileViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var scrollViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet var contentView: UIView!
    @IBOutlet var surnameField: UnderlinedTextField!
    @IBOutlet var nameField: UnderlinedTextField!
    @IBOutlet var midnameField: UnderlinedTextField!
    @IBOutlet var flatNumberField: UnderlinedTextField!
    @IBOutlet var telegramField: UnderlinedTextField!
    @IBOutlet var privacySettingsLabel: UILabel!
    @IBOutlet var nameDisplayLabel: UILabel!
    @IBOutlet var nameDisplaySelector: UIPickerView!
    @IBOutlet var contactsDisplayLabel: UILabel!
    @IBOutlet var showPhoneNumberLabel: UILabel!
    @IBOutlet var showTelegramAccountLabel: UILabel!
    @IBOutlet var showPhoneNumberSwitch: UISwitch!
    @IBOutlet var showTelegramAccountSwitch: UISwitch!
    @IBOutlet var saveButton: MDCRaisedButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameDisplaySelector.dataSource = self
        nameDisplaySelector.delegate = self
        
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchClick)))
        initializeComponents()
        setProfileData()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: Keyboard
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        let keyboardSize = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect

        scrollViewBottomConstraint.constant = keyboardSize.height
    }

    @objc func keyboardWillHide(_ notification: NSNotification) {
        scrollViewBottomConstraint.constant = 0
    }

    // MARK: Picker View
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Localization.nameDisplayOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Localization.nameDisplayOptions[row]
    }
    
    // MARK: View Callbacks
    
    @IBAction func saveButtonClick(_ sender: MDCRaisedButton) {
        view.endEditing(true)
        
        if flatNumberField.text.isEmpty {
            flatNumberField.showError(message: Localization.invalidFormat)
            return
        }
        
        ClientData.user.data.person!.surname = surnameField.textField.text
        ClientData.user.data.person!.name = nameField.textField.text
        ClientData.user.data.person!.midname = midnameField.textField.text
        ClientData.user.data.resident!.flat.number = Int(flatNumberField.textField.text!)!
        ClientData.user.data.person!.telegram = telegramField.textField.text
        ClientData.user.data.person!.access.mobile.level = showPhoneNumberSwitch.isOn ? "all" : "friends"
        ClientData.user.data.person!.access.telegram.level = showTelegramAccountSwitch.isOn ? "all" : "friends"
        
        switch nameDisplaySelector.selectedRow(inComponent: 0) {
        case 0:
            ClientData.user.data.person!.access.name.format = "nothing"
            ClientData.user.data.person!.access.name.level = "nothing"
        case 1:
            ClientData.user.data.person!.access.name.format = "name"
            ClientData.user.data.person!.access.name.level = "all"
        default:
            ClientData.user.data.person!.access.name.format = "all"
            ClientData.user.data.person!.access.name.level = "all"
        }
        
        SocketHandler.saveProfile(ClientData.user.data) { result in
            switch result {
            case .failure(let error):
                self.handleFailure(message: (error as! ErrorObject).message)
            case .success(_):
                self.handleSuccess()
            }
        }
    }
    
    // MARK: Touches
    
    @objc func touchClick(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // MARK: Custom functions
        
    private func handleFailure(message: String) {
        let messageObject = MDCSnackbarMessage()
        let messageManager = MDCSnackbarManager()
    
        messageObject.text = Localization.error + ". " + message
        messageManager.snackbarMessageViewBackgroundColor = .redDarken2
        
        messageManager.setBottomOffset(view.safeAreaInsets.bottom)
        messageManager.show(messageObject)
    }
    
    private func handleSuccess() {
        let messageObject = MDCSnackbarMessage()
        let messageManager = MDCSnackbarManager()
    
        messageObject.text = Localization.successfullySaved
        messageManager.snackbarMessageViewBackgroundColor = .greenDarken2
        
        messageManager.setBottomOffset(view.safeAreaInsets.bottom)
        messageManager.show(messageObject)
    }
    
    private func initializeComponents() {
        title = Localization.profile
        surnameField.textField.label.text = Localization.surname
        nameField.textField.label.text = Localization.name
        midnameField.textField.label.text = Localization.midname
        flatNumberField.textField.label.text = Localization.flatNumber
        flatNumberField.textField.keyboardType = .numberPad
        telegramField.textField.label.text = Localization.telegramAccount
        privacySettingsLabel.text = Localization.privacySettings
        nameDisplayLabel.text = Localization.nameDisplay
        contactsDisplayLabel.text = Localization.contactsDisplay
        showPhoneNumberLabel.text = Localization.showPhoneNumber
        showTelegramAccountLabel.text = Localization.showTelegramAccount
    
        telegramField.setPrefixText("@")
        saveButton.setTitle(Localization.save, for: .normal)
    }
    
    private func setProfileData() {
        surnameField.textField.text = ClientData.user.data.person!.surname
        nameField.textField.text = ClientData.user.data.person!.name
        midnameField.textField.text = ClientData.user.data.person!.midname
        flatNumberField.textField.isEnabled = false
        flatNumberField.textField.text = String(ClientData.user.data.resident!.flat.number)
        telegramField.textField.text = ClientData.user.data.person!.telegram
        showPhoneNumberSwitch.isOn = ClientData.user.data.person!.access.mobile.level == "all"
        showTelegramAccountSwitch.isOn = ClientData.user.data.person!.access.telegram.level == "all"
        
        let nameFormat = ClientData.user.data.person!.access.name.format
        
        nameDisplaySelector.selectRow(nameFormat == "all" ? 2 : (nameFormat == "name" ? 1 : 0), inComponent: 0, animated: true)
    }
    
}
