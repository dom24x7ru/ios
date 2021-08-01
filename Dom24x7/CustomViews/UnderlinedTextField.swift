//
//  UnderlinedTextField.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 04.04.2021.
//

import UIKit
import MaterialComponents

class UnderlinedTextField: UIView, UITextFieldDelegate {
    
    public var contentView: UIView!
    @IBOutlet public var textField: MDCUnderlinedTextField!
    
    public var isFilled: Bool {
        return textField.text!.count == maxTextLength || maxTextLength == Int.max
    }
    
    public var maxTextLength: Int = Int.max {
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
        textField.setNormalLabelColor(.systemGray, for: .normal)
        textField.setFloatingLabelColor(.systemGray, for: .normal)
        textField.setFloatingLabelColor(.accentColor, for: .editing)
        textField.setLeadingAssistiveLabelColor(.systemRed, for: .normal)
        textField.setTrailingAssistiveLabelColor(.systemGray, for: .normal)
        textField.setTrailingAssistiveLabelColor(.systemGray, for: .editing)
        textField.setUnderlineColor(.systemGray, for: .normal)
        textField.setUnderlineColor(.accentColor, for: .editing)
        
        textField.delegate = self
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
            textField.setTrailingAssistiveLabelColor(.systemRed, for: .normal)
            textField.setUnderlineColor(.systemRed, for: .normal)
        }
    }
    
    @IBAction private func textFieldEditingChanged(_ _: UITextField) {
        if maxTextLength != Int.max {
            textField.trailingAssistiveLabel.text = String(textField.text!.count) + "/" + String(maxTextLength)
        }
    }
    
    // MARK: Custom APIs
    
    public func hideError() {
        textField.leadingAssistiveLabel.text = String()
        
        textField.setTrailingAssistiveLabelColor(.systemGray, for: .normal)
        textField.setUnderlineColor(.systemGray, for: .normal)
    }
    
    public func showError(message: String) {
        textField.leadingAssistiveLabel.text = message
        
        textField.setTrailingAssistiveLabelColor(.systemRed, for: .normal)
        textField.setUnderlineColor(.systemRed, for: .normal)
    }
    
    public func setPrefixText(_ text: String) {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 17)
        label.text = text
        label.textAlignment = .center
        label.textColor = .systemGray
        textField.leadingView = label
        textField.leadingViewMode = .always
        
        label.sizeToFit()
    }
    
}
