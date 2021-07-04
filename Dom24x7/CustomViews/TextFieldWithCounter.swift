//
//  TextFieldWithCounter.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 04.04.2021.
//

import UIKit
import MaterialComponents

class TextFieldWithCounter: UIView, UITextFieldDelegate {
    
    public var contentView: UIView!
    @IBOutlet public var prefixLabel: UILabel!
    @IBOutlet public var textField: MDCUnderlinedTextField!
    @IBOutlet public var errorMessageLabel: UILabel!
    @IBOutlet public var lengthCounterLabel: UILabel!
    
    public var isFilled: Bool {
        return textField.text!.count == maxTextLength
    }
    
    public var maxTextLength: Int = Int.max {
        willSet {
            lengthCounterLabel.isHidden = newValue == Int.max
        }
        didSet {
            textFieldEditingChanged(textField)
        }
    }
    
    public var text: String {
        return textField.text!
    }
    
    public var onTextFieldDidBeginEditing: Runnable?
    public var onTextFieldDidEndEditing: Runnable?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        contentView = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView
        backgroundColor = .clear
        bounds = contentView.bounds
        
        addSubview(contentView)
        viewDidLoad()
    }
    
    private func viewDidLoad() {
        textField.setUnderlineColor(.darkGray, for: .normal)
        textField.setUnderlineColor(.accentColor, for: .editing)
        
        textField.delegate = self
        prefixLabel.text = String()
        errorMessageLabel.isHidden = true
        errorMessageLabel.text = String()
        errorMessageLabel.textColor = .red
    }
    
    // MARK: TextField Callbacks
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return textField.text!.count < maxTextLength || string.isEmpty
    }
    
    func textFieldDidBeginEditing(_ _: UITextField) {
        onTextFieldDidBeginEditing?()
        hideError()
    }
    
    func textFieldDidEndEditing(_ _: UITextField) {
        onTextFieldDidEndEditing?()
        
        if !isFilled {
            lengthCounterLabel.textColor = .red
            textField.setUnderlineColor(.red, for: .normal)
        }
    }
    
    @IBAction private func textFieldEditingChanged(_ sender: UITextField) {
        if !lengthCounterLabel.isHidden {
            lengthCounterLabel.text = String(textField.text!.count) + "/" + String(maxTextLength)
        }
    }
    
    // MARK: Custom APIs
    
    public func hideError() {
        errorMessageLabel.isHidden = true
        lengthCounterLabel.textColor = .darkGray
        
        textField.setUnderlineColor(.darkGray, for: .normal)
    }
    
    public func showError(message: String) {
        lengthCounterLabel.textColor = .red
        errorMessageLabel.text = message
        errorMessageLabel.isHidden = false
        
        textField.setUnderlineColor(.red, for: .normal)
    }
    
}
