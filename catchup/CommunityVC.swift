//
//  CommunityVC.swift
//  catchup
//
//  Created by PJW on 09/01/2020.
//  Copyright © 2020 PJW. All rights reserved.
//

import UIKit

enum CommunityType: Int {
    case cook
    case ilbe
    case instiz
    case ruliweb
    case clien
    case namu
    // enum의 count를 위한 case - 항상 제일 마지막에 위치해야 함
    case count
    
    func getCommunityName() -> String {
        switch self {
        case .cook:
            return "82cook"
        case .ilbe:
            return "Ilbe"
        case .instiz:
            return "Instiz"
        case .ruliweb:
            return "Ruliweb"
        case .clien:
            return "Clien"
        case .namu:
            return "Namu"
        case .count:
            return ""
        }
    }
}

class CommunityVC: UITableViewController {
    
    lazy var cookContents: [(title: String, url: String)] = {
        var list = [(String, String)]()
        return list
    }()
    
    lazy var bullpenContents: [(title: String, url: String)] = {
        var list = [(String, String)]()
        return list
    }()
    
    lazy var ilbeContents: [(title: String, url: String)] = {
        var list = [(String, String)]()
        return list
    }()
    
    lazy var instizContents: [(title: String, url: String)] = {
        var list = [(String, String)]()
        return list
    }()
    
    lazy var ruliwebContents: [(title: String, url: String)] = {
        var list = [(String, String)]()
        return list
    }()
    
    lazy var clienContents: [(title: String, url: String)] = {
        var list = [(String, String)]()
        return list
    }()
    
    lazy var namuContents: [(title: String, url: String)] = {
        var list = [(String, String)]()
        return list
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webContentManager = CommunityContentManager()
        webContentManager.getCookContents {
            self.cookContents = webContentManager.cookContents
            self.tableView.reloadData()
        }
        /*
        webContentManager.getBullpenContents {
            self.bullpenContents = webContentManager.bullpenContents
            self.tableView.reloadData()
        }
        */
        webContentManager.getIlbeContents {
            self.ilbeContents = webContentManager.ilbeContents
            self.tableView.reloadData()
        }
        webContentManager.getInstizContents {
            self.instizContents = webContentManager.instizContents
            self.tableView.reloadData()
        }
        webContentManager.getRuliwebContents {
            self.ruliwebContents = webContentManager.ruliwebContents
            self.tableView.reloadData()
        }
        webContentManager.getClienContents {
            self.clienContents = webContentManager.clienContents
            self.tableView.reloadData()
        }
        webContentManager.getNamuContents {
            self.namuContents = webContentManager.namuContents
            self.tableView.reloadData()
        }
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return CommunityType.count.rawValue
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case CommunityType.cook.rawValue:
            return self.cookContents.count
        case CommunityType.ilbe.rawValue:
            return self.ilbeContents.count
        case CommunityType.instiz.rawValue:
            return self.instizContents.count
        case CommunityType.ruliweb.rawValue:
            return self.ruliwebContents.count
        case CommunityType.clien.rawValue:
            return self.clienContents.count
        case CommunityType.namu.rawValue:
            return self.namuContents.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "article_cell") as! ArticleCell
        cell.labelNum.font = UIFont.boldSystemFont(ofSize: 14)
        cell.labelNum.textColor = UIColor.brown
        cell.labelText.font = UIFont.systemFont(ofSize: 14)
        
        switch indexPath.section {
        case CommunityType.cook.rawValue:
            let data = self.cookContents[indexPath.row]
            cell.labelNum.text = String(indexPath.row + 1)
            cell.labelText.text = data.title
        case CommunityType.ilbe.rawValue:
            let data = self.ilbeContents[indexPath.row]
            cell.labelNum.text = String(indexPath.row + 1)
            cell.labelText.text = data.title
        case CommunityType.instiz.rawValue:
            let data = self.instizContents[indexPath.row]
            cell.labelNum.text = String(indexPath.row + 1)
            cell.labelText.text = data.title
        case CommunityType.ruliweb.rawValue:
            let data = self.ruliwebContents[indexPath.row]
            cell.labelNum.text = String(indexPath.row + 1)
            cell.labelText.text = data.title
        case CommunityType.clien.rawValue:
            let data = self.clienContents[indexPath.row]
            cell.labelNum.text = String(indexPath.row + 1)
            cell.labelText.text = data.title
        case CommunityType.namu.rawValue:
            let data = self.namuContents[indexPath.row]
            cell.labelNum.text = String(indexPath.row + 1)
            cell.labelText.text = data.title
        default:
            ()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = self.mainColor
        
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 17)
        title.textColor = UIColor.white
        title.textAlignment = .left
        
        switch section {
        case CommunityType.cook.rawValue:
            title.text = CommunityType.getCommunityName(.cook)()
        case CommunityType.ilbe.rawValue:
            title.text = CommunityType.getCommunityName(.ilbe)()
        case CommunityType.instiz.rawValue:
            title.text = CommunityType.getCommunityName(.instiz)()
        case CommunityType.ruliweb.rawValue:
            title.text = CommunityType.getCommunityName(.ruliweb)()
        case CommunityType.clien.rawValue:
            title.text = CommunityType.getCommunityName(.clien)()
        case CommunityType.namu.rawValue:
            title.text = CommunityType.getCommunityName(.namu)()
        default:
            ()
        }
        headerView.addSubview(title)
        
        title.snp.makeConstraints { (make) in
            make.left.equalTo(headerView).offset(20)
            make.bottom.equalTo(headerView).offset(-10)
        }
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let contentVC = self.storyboard?.instantiateViewController(identifier: "contentVC") as! ContentVC
        
        switch indexPath.section {
        case CommunityType.cook.rawValue:
            contentVC.url = self.cookContents[indexPath.row].url
            self.navigationController?.pushViewController(contentVC, animated: true)
        case CommunityType.ilbe.rawValue:
            contentVC.url = self.ilbeContents[indexPath.row].url
            self.navigationController?.pushViewController(contentVC, animated: true)
        case CommunityType.instiz.rawValue:
            contentVC.url = self.instizContents[indexPath.row].url
            self.navigationController?.pushViewController(contentVC, animated: true)
        case CommunityType.ruliweb.rawValue:
            contentVC.url = self.ruliwebContents[indexPath.row].url
            self.navigationController?.pushViewController(contentVC, animated: true)
        case CommunityType.clien.rawValue:
            contentVC.url = self.clienContents[indexPath.row].url
            self.navigationController?.pushViewController(contentVC, animated: true)
        case CommunityType.namu.rawValue:
            contentVC.url = self.namuContents[indexPath.row].url
            print(self.namuContents[indexPath.row].url)
            self.navigationController?.pushViewController(contentVC, animated: true)
        default:
            ()
        }
    }

}
