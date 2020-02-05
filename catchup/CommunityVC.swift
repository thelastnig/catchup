//
//  CommunityVC.swift
//  catchup
//
//  Created by PJW on 09/01/2020.
//  Copyright © 2020 PJW. All rights reserved.
//

import UIKit
import Kanna
import SafariServices

public enum CommunityType: Int {
    case ruliweb
    case nate
    case ilbe
    case ppomppu
    case clien
    case instiz
    case cook
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
        case .ppomppu:
            return "Ppomppu"
        case .nate:
            return "Nate"
        case .count:
            return ""
        }
    }
    
    func getCommunityKeyName() -> String {
        switch self {
        case .cook:
            return "cook"
        case .ilbe:
            return "ilbe"
        case .instiz:
            return "instiz"
        case .ruliweb:
            return "ruliweb"
        case .clien:
            return "clien"
        case .namu:
            return "namu"
        case .ppomppu:
            return "ppomppu"
        case .nate:
            return "nate"
        case .count:
            return ""
        }
    }
}

class CommunityVC: UITableViewController {
    
    lazy var cookContents: [(title: String, url: String, idx: Int)] = {
        var list = [(String, String, Int)]()
        return list
    }()
    
    lazy var bullpenContents: [(title: String, url: String, idx: Int)] = {
        var list = [(String, String, Int)]()
        return list
    }()
    
    lazy var ilbeContents: [(title: String, url: String, idx: Int)] = {
        var list = [(String, String, Int)]()
        return list
    }()
    
    lazy var instizContents: [(title: String, url: String, idx: Int)] = {
        var list = [(String, String, Int)]()
        return list
    }()
    
    lazy var ruliwebContents: [(title: String, url: String, idx: Int)] = {
        var list = [(String, String, Int)]()
        return list
    }()
    
    lazy var clienContents: [(title: String, url: String, idx: Int)] = {
        var list = [(String, String, Int)]()
        return list
    }()
    
    lazy var namuContents: [(title: String, url: String, idx: Int)] = {
        var list = [(String, String, Int)]()
        return list
    }()
    
    lazy var ppomppuContents: [(title: String, url: String, idx: Int)] = {
        var list = [(String, String, Int)]()
        return list
    }()
    
    lazy var nateContents: [(title: String, url: String, idx: Int)] = {
        var list = [(String, String, Int)]()
        return list
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네트워크 연결 확인
        network.reachability.whenUnreachable = { reachability in
            self.checkNetwork()
        }
        
        self.tableView.reloadData()
        
        // 당겨서 새로고침
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.tintColor = mainColor
        
        let attributes = [NSAttributedString.Key.foregroundColor: mainColor]
        self.refreshControl?.attributedTitle = NSAttributedString(string: "페이지 새로고침 중", attributes: attributes)
        
        self.refreshControl?.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
        
        // 테이블뷰의 셀 별 라인 제거
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        // self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return CommunityType.count.rawValue
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let ud = UserDefaults.standard
        let key = CommunityType.getCommunityKeyName(CommunityType(rawValue: section)!)()
        
        switch section {
        case CommunityType.cook.rawValue:
            if let switchValue = ud.value(forKey: key) {
                let value = switchValue as! Bool
                if value {
                    return self.cookContents.count
                } else {
                    return 0
                }
            } else {
                return self.cookContents.count
            }
        case CommunityType.ilbe.rawValue:
            if let switchValue = ud.value(forKey: key) {
                let value = switchValue as! Bool
                if value {
                    return self.ilbeContents.count
                } else {
                    return 0
                }
            } else {
                return self.ilbeContents.count
            }
        case CommunityType.instiz.rawValue:
            if let switchValue = ud.value(forKey: key) {
                let value = switchValue as! Bool
                if value {
                    return self.instizContents.count
                } else {
                    return 0
                }
            } else {
                return self.instizContents.count
            }
        case CommunityType.ruliweb.rawValue:
            if let switchValue = ud.value(forKey: key) {
                let value = switchValue as! Bool
                if value {
                    return self.ruliwebContents.count
                } else {
                    return 0
                }
            } else {
                return self.ruliwebContents.count
            }
        case CommunityType.clien.rawValue:
            if let switchValue = ud.value(forKey: key) {
                let value = switchValue as! Bool
                if value {
                    return self.clienContents.count
                } else {
                    return 0
                }
            } else {
                return self.clienContents.count
            }
        case CommunityType.namu.rawValue:
            if let switchValue = ud.value(forKey: key) {
                let value = switchValue as! Bool
                if value {
                    return self.namuContents.count
                } else {
                    return 0
                }
            } else {
                return self.namuContents.count
            }
        case CommunityType.ppomppu.rawValue:
            if let switchValue = ud.value(forKey: key) {
                let value = switchValue as! Bool
                if value {
                    return self.ppomppuContents.count
                } else {
                    return 0
                }
            } else {
                return self.ppomppuContents.count
            }
        case CommunityType.nate.rawValue:
            if let switchValue = ud.value(forKey: key) {
                let value = switchValue as! Bool
                if value {
                    return self.nateContents.count
                } else {
                    return 0
                }
            } else {
                return self.nateContents.count
            }
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var data: (title: String, url: String, idx: Int)!
        
        switch indexPath.section {
        case CommunityType.cook.rawValue:
            data = self.cookContents[indexPath.row]
        case CommunityType.ilbe.rawValue:
            data = self.ilbeContents[indexPath.row]
        case CommunityType.instiz.rawValue:
            data = self.instizContents[indexPath.row]
        case CommunityType.ruliweb.rawValue:
            data = self.ruliwebContents[indexPath.row]
        case CommunityType.clien.rawValue:
            data = self.clienContents[indexPath.row]
        case CommunityType.namu.rawValue:
            data = self.namuContents[indexPath.row]
        case CommunityType.ppomppu.rawValue:
            data = self.ppomppuContents[indexPath.row]
        case CommunityType.nate.rawValue:
            data = self.nateContents[indexPath.row]
        default:
            ()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "article_cell") as! ArticleCell
        cell.labelNum.font = UIFont.boldSystemFont(ofSize: 14)
        cell.labelNum.textColor = UIColor.brown
        cell.labelText.font = UIFont.systemFont(ofSize: 14)
        
        cell.contentView.backgroundColor = self.grayColor1
        
        cell.labelNum.text = String(indexPath.row + 1)
        cell.labelText.text = data.title
        
        let lineView = UIView()
        lineView.backgroundColor = self.grayColor2
        cell.containerView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(cell.containerView).offset(15)
            make.right.equalTo(cell.containerView).offset(-15)
            make.top.equalTo(cell.containerView)
            make.height.equalTo(1)
        }

        if data.idx != 1 {
            lineView.backgroundColor = self.grayColor2
        } else {
            lineView.backgroundColor = UIColor.white
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let ud = UserDefaults.standard
        let key = CommunityType.getCommunityKeyName(CommunityType(rawValue: section)!)()
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: Constants.sectionHeight))
        
        headerView.backgroundColor = self.grayColor1

        let headerUpperView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: Constants.sectionHeight - Constants.sectionMargin))
        
        headerUpperView.backgroundColor = self.mainColor
        
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 17)
        title.textColor = UIColor.white
        title.textAlignment = .left
        
        switch section {
        case CommunityType.cook.rawValue:
            if let switchValue = ud.value(forKey: key) {
                let value = switchValue as! Bool
                if value {
                    title.text = CommunityType.getCommunityName(.cook)()
                } else {
                    title.text = ""
                }
            } else {
                title.text = CommunityType.getCommunityName(.cook)()
            }
        case CommunityType.ilbe.rawValue:
            if let switchValue = ud.value(forKey: key) {
                let value = switchValue as! Bool
                if value {
                    title.text = CommunityType.getCommunityName(.ilbe)()
                } else {
                    title.text = ""
                }
            } else {
                title.text = CommunityType.getCommunityName(.ilbe)()
            }
        case CommunityType.instiz.rawValue:
            if let switchValue = ud.value(forKey: key) {
                let value = switchValue as! Bool
                if value {
                    title.text = CommunityType.getCommunityName(.instiz)()
                } else {
                    title.text = ""
                }
            } else {
                title.text = CommunityType.getCommunityName(.instiz)()
            }
        case CommunityType.ruliweb.rawValue:
            if let switchValue = ud.value(forKey: key) {
                let value = switchValue as! Bool
                if value {
                    title.text = CommunityType.getCommunityName(.ruliweb)()
                } else {
                    title.text = ""
                }
            } else {
                title.text = CommunityType.getCommunityName(.ruliweb)()
            }
        case CommunityType.clien.rawValue:
            if let switchValue = ud.value(forKey: key) {
                let value = switchValue as! Bool
                if value {
                    title.text = CommunityType.getCommunityName(.clien)()
                } else {
                    title.text = ""
                }
            } else {
                title.text = CommunityType.getCommunityName(.clien)()
            }
        case CommunityType.namu.rawValue:
            if let switchValue = ud.value(forKey: key) {
                let value = switchValue as! Bool
                if value {
                    title.text = CommunityType.getCommunityName(.namu)()
                } else {
                    title.text = ""
                }
            } else {
                title.text = CommunityType.getCommunityName(.namu)()
            }
        case CommunityType.ppomppu.rawValue:
            if let switchValue = ud.value(forKey: key) {
                let value = switchValue as! Bool
                if value {
                    title.text = CommunityType.getCommunityName(.ppomppu)()
                } else {
                    title.text = ""
                }
            } else {
                title.text = CommunityType.getCommunityName(.ppomppu)()
            }
        case CommunityType.nate.rawValue:
            if let switchValue = ud.value(forKey: key) {
                let value = switchValue as! Bool
                if value {
                    title.text = CommunityType.getCommunityName(.nate)()
                } else {
                    title.text = ""
                }
            } else {
                title.text = CommunityType.getCommunityName(.nate)()
            }
        default:
            ()
        }
        headerUpperView.addSubview(title)
        
        title.snp.makeConstraints { (make) in
            make.left.equalTo(headerUpperView).offset(20)
            make.bottom.equalTo(headerUpperView).offset(-10)
        }
        
        headerView.addSubview(headerUpperView)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = self.grayColor1
        
        return footer
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionHeight: CGFloat = Constants.sectionHeight
        let ud = UserDefaults.standard
        let key = CommunityType.getCommunityKeyName(CommunityType(rawValue: section)!)()
        switch section {
        case CommunityType.cook.rawValue:
            if let switchValue = ud.value(forKey: key) {
                let value = switchValue as! Bool
                if value {
                    return sectionHeight
                } else {
                    return CGFloat.leastNormalMagnitude
                }
            } else {
                return sectionHeight
            }
        case CommunityType.ilbe.rawValue:
            if let switchValue = ud.value(forKey: key) {
                let value = switchValue as! Bool
                if value {
                    return sectionHeight
                } else {
                    return CGFloat.leastNormalMagnitude
                }
            } else {
                return sectionHeight
            }
        case CommunityType.instiz.rawValue:
            if let switchValue = ud.value(forKey: key) {
                let value = switchValue as! Bool
                if value {
                    return sectionHeight
                } else {
                    return CGFloat.leastNormalMagnitude
                }
            } else {
                return sectionHeight
            }
        case CommunityType.ruliweb.rawValue:
            if let switchValue = ud.value(forKey: key) {
                let value = switchValue as! Bool
                if value {
                    return sectionHeight
                } else {
                    return CGFloat.leastNormalMagnitude
                }
            } else {
                return sectionHeight
            }
        case CommunityType.clien.rawValue:
            if let switchValue = ud.value(forKey: key) {
                let value = switchValue as! Bool
                if value {
                    return sectionHeight
                } else {
                    return CGFloat.leastNormalMagnitude
                }
            } else {
                return sectionHeight
            }
        case CommunityType.namu.rawValue:
            if let switchValue = ud.value(forKey: key) {
                let value = switchValue as! Bool
                if value {
                    return sectionHeight
                } else {
                    return CGFloat.leastNormalMagnitude
                }
            } else {
                return sectionHeight
            }
        case CommunityType.ppomppu.rawValue:
            if let switchValue = ud.value(forKey: key) {
                let value = switchValue as! Bool
                if value {
                    return sectionHeight
                } else {
                    return CGFloat.leastNormalMagnitude
                }
            } else {
                return sectionHeight
            }
        case CommunityType.nate.rawValue:
            if let switchValue = ud.value(forKey: key) {
                let value = switchValue as! Bool
                if value {
                    return sectionHeight
                } else {
                    return CGFloat.leastNormalMagnitude
                }
            } else {
                return sectionHeight
            }
        default:
            return sectionHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let sectionHeight: CGFloat = Constants.sectionMargin
        let ud = UserDefaults.standard
        let key = CommunityType.getCommunityKeyName(CommunityType(rawValue: section)!)()
        switch section {
        case CommunityType.cook.rawValue:
            if let switchValue = ud.value(forKey: key) {
                let value = switchValue as! Bool
                if value {
                    return sectionHeight
                } else {
                    return CGFloat.leastNormalMagnitude
                }
            } else {
                return sectionHeight
            }
        case CommunityType.ilbe.rawValue:
            if let switchValue = ud.value(forKey: key) {
                let value = switchValue as! Bool
                if value {
                    return sectionHeight
                } else {
                    return CGFloat.leastNormalMagnitude
                }
            } else {
                return sectionHeight
            }
        case CommunityType.instiz.rawValue:
            if let switchValue = ud.value(forKey: key) {
                let value = switchValue as! Bool
                if value {
                    return sectionHeight
                } else {
                    return CGFloat.leastNormalMagnitude
                }
            } else {
                return sectionHeight
            }
        case CommunityType.ruliweb.rawValue:
            if let switchValue = ud.value(forKey: key) {
                let value = switchValue as! Bool
                if value {
                    return sectionHeight
                } else {
                    return CGFloat.leastNormalMagnitude
                }
            } else {
                return sectionHeight
            }
        case CommunityType.clien.rawValue:
            if let switchValue = ud.value(forKey: key) {
                let value = switchValue as! Bool
                if value {
                    return sectionHeight
                } else {
                    return CGFloat.leastNormalMagnitude
                }
            } else {
                return sectionHeight
            }
        case CommunityType.namu.rawValue:
            if let switchValue = ud.value(forKey: key) {
                let value = switchValue as! Bool
                if value {
                    return sectionHeight
                } else {
                    return CGFloat.leastNormalMagnitude
                }
            } else {
                return sectionHeight
            }
        case CommunityType.ppomppu.rawValue:
            if let switchValue = ud.value(forKey: key) {
                let value = switchValue as! Bool
                if value {
                    return sectionHeight
                } else {
                    return CGFloat.leastNormalMagnitude
                }
            } else {
                return sectionHeight
            }
        case CommunityType.nate.rawValue:
            if let switchValue = ud.value(forKey: key) {
                let value = switchValue as! Bool
                if value {
                    return sectionHeight
                } else {
                    return CGFloat.leastNormalMagnitude
                }
            } else {
                return sectionHeight
            }
        default:
            return sectionHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var url = "https://www.google.com"
        
        switch indexPath.section {
        case CommunityType.cook.rawValue:
            url = self.cookContents[indexPath.row].url
        case CommunityType.ilbe.rawValue:
            url = self.ilbeContents[indexPath.row].url
        case CommunityType.instiz.rawValue:
            url = self.instizContents[indexPath.row].url
        case CommunityType.ruliweb.rawValue:
            url = self.ruliwebContents[indexPath.row].url
        case CommunityType.clien.rawValue:
            url = self.clienContents[indexPath.row].url
        case CommunityType.namu.rawValue:
            url = self.namuContents[indexPath.row].url
        case CommunityType.ppomppu.rawValue:
            url = self.ppomppuContents[indexPath.row].url
        case CommunityType.nate.rawValue:
            url = self.nateContents[indexPath.row].url
        default:
            ()
        }
        // safariViewController 생성 및 설정
        let config = SFSafariViewController.Configuration()
        config.barCollapsingEnabled = false
        let safariViewController = SFSafariViewController(url: URL(string: url)!, configuration: config)
        safariViewController.dismissButtonStyle = .close
        
        self.navigationController?.present(safariViewController, animated: true, completion: nil)
    }
    
    func getContents(){
        
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
        webContentManager.getPpomppuContents {
            self.ppomppuContents = webContentManager.ppomppuContents
            self.tableView.reloadData()
        }
        webContentManager.getNateContents {
            self.nateContents = webContentManager.nateContents
            self.tableView.reloadData()
        }
    }
    
    @objc func pullToRefresh(_ sender: Any) {
        self.getContents()
        
        // 당겨서 새로고침 종료
        self.refreshControl?.endRefreshing()
    }

}
