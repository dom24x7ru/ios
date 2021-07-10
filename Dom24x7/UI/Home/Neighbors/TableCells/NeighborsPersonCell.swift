//
//  NeighborsPersonCell.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 09.07.2021.
//

import UIKit

class NeighborsPersonCell: UITableViewCell {
    
    private var mobile: String?
    private var telegram: String?
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var mobileButton: UIButton!
    @IBOutlet var telegramButton: UIButton!
    @IBOutlet var sendMessageButton: UIButton!

    
    @IBAction func mobileButtonClick(_ sender: UIButton) {
        if mobile != nil {
            // nothing for a while
        }
    }
    
    @IBAction func telegramButtonClick(_ sender: UIButton) {
        if telegram != nil {
            UIApplication.shared.open(URL(string: "https://t.me/" + telegram!)!, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func sendMessageButtonClick(_ sender: UIButton) {
        // TODO
    }
    
    public func setName(_ name: String?, surname: String?, midname: String?) {
        if name == nil {
            nameLabel.text = Localization.unknown
        } else if surname == nil {
            nameLabel.text = name
        } else {
            nameLabel.text = surname! + " " + name! + " " + midname!
        }
    }
    
    public func setMobile(_ mobile: String?) {
        self.mobile = mobile
        
        mobileButton.setTitle(mobile ?? Localization.unknown, for: .normal)
    }
    
    public func setTelegram(_ telegram: String?) {
        self.telegram = telegram
        telegramButton.isUserInteractionEnabled = telegram != nil
        
        telegramButton.setTitle(telegram ?? Localization.unknown, for: .normal)
        telegramButton.setTitleColor(telegram == nil ? .systemGray : .accentColor, for: .normal)
    }
    
}
