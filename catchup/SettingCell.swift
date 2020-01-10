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
        key = CommunityType.getCommunityKeyName(CommunityType(rawValue: (tagValue - 20))!)()
        
        ud.set(sender.isOn, forKey: key)
        ud.synchronize()
    }
}
