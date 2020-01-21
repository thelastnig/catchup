//
//  SettingCell.swift
//  catchup
//
//  Created by PJW on 10/01/2020.
//  Copyright © 2020 PJW. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var switchOnOff: UISwitch!
    
    var delegate: SettingVC?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func switchChangeAction(_ sender: UISwitch) {
        let ud = UserDefaults.standard
        let tagValue = sender.tag
        let key: String!
        
        if tagValue < 20 {
            return
        }
        
        let numberOfOff = ud.integer(forKey: "numberOfOff")
        
        if sender.isOn == false && numberOfOff == 3 {
            sender.isOn = true
            self.delegate?.alert("커뮤니티 비활성화는 3개까지만 가능합니다.")
            return
        }
        
        key = CommunityType.getCommunityKeyName(CommunityType(rawValue: (tagValue - 20))!)()
        
        ud.set(sender.isOn, forKey: key)
        
        if sender.isOn == false {
            ud.set(numberOfOff + 1, forKey: "numberOfOff")
        } else {
            ud.set(numberOfOff - 1, forKey: "numberOfOff")
        }
        
        ud.synchronize()
    }
}
