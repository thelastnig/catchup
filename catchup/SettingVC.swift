//
//  SettingVC.swift
//  catchup
//
//  Created by PJW on 10/01/2020.
//  Copyright © 2020 PJW. All rights reserved.
//

import UIKit

class SettingVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return NaverType.count.rawValue
        case 1:
            return CommunityType.count.rawValue
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "setting_cell") as! SettingCell
        cell.labelTitle.font = UIFont.systemFont(ofSize: 14)
        
        let ud = UserDefaults.standard
        
        if indexPath.section == 0 {
            cell.labelTitle.text = NaverType.getNaverName(NaverType(rawValue: indexPath.row)!)()
            // 구분을 위해 indexPath.row에 10을 더해줌
            // (나중에 enum의 rawValue로 사용 시 10을 빼주면 됨)
            cell.switchOnOff.tag = 10 + indexPath.row
        } else {
            cell.labelTitle.text = CommunityType.getCommunityName(CommunityType(rawValue: indexPath.row)!)()
            // 구분을 위해 indexPath.row에 20을 더해줌
            // (나중에 enum의 rawValue로 사용 시 20을 빼주면 됨)
            cell.switchOnOff.tag = 20 + indexPath.row
            
            // switch value 설정 영역
            let key = CommunityType.getCommunityKeyName(CommunityType(rawValue: indexPath.row)!)()
            if let switchValue = ud.value(forKey: key) {
                cell.switchOnOff.isOn = switchValue as! Bool
            } else {
                cell.switchOnOff.isOn = true
            }
        }
        return cell
    }



}
