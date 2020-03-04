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
    case fm
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
        case .fm:
            return "FM Korea"
        case .count:
            return ""
        }
    }
    
    func getCommunityKoreanName() -> String {
        switch self {
        case .cook:
            return "82cook"
        case .ilbe:
            return "일간베스트"
        case .instiz:
            return "인스티즈"
        case .ruliweb:
            return "루리웹"
        case .clien:
            return "클리앙"
        case .namu:
            return "나무위키"
        case .ppomppu:
            return "뽐뿌"
        case .nate:
            return "네이트"
        case .fm:
            return "FM Korea"
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
        case .fm:
            return "fm"
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
    
    lazy var fmContents: [(title: String, url: String, idx: Int)] = {
        var list = [(String, String, Int)]()
        return list
    }()
    
    // section 접기/펼치기를 위한 Dictionary 선언
    var toggleDict: Dictionary<Int, Bool> = [
        0: true, 1: true, 2: true, 3: true, 4: true,
        5: true, 6: true, 7: true, 8: true
    ]

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
        
    }
    
    override func viewWillLayoutSubviews() {
        // custom header, tabbar의 높이만큼 rootview 위치 및 높이 조정
        let screen = UIScreen.main.bounds
        let margin = Constants.csTabbarHeight + self.upperHeight
        self.view.frame.origin.y = margin
        self.view.frame.size.height = screen.size.height - margin
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return CommunityType.count.rawValue
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        switch section {
        case CommunityType.ruliweb.rawValue:
            if toggleDict[CommunityType.ruliweb.rawValue]! {
                return self.ruliwebContents.count
            } else {
                return 1
            }
        case CommunityType.nate.rawValue:
            if toggleDict[CommunityType.nate.rawValue]! {
                return self.nateContents.count
            } else {
                return 1
            }
        case CommunityType.ilbe.rawValue:
            if toggleDict[CommunityType.ilbe.rawValue]! {
                return self.ilbeContents.count
            } else {
                return 1
            }
        case CommunityType.ppomppu.rawValue:
            if toggleDict[CommunityType.ppomppu.rawValue]! {
                return self.ppomppuContents.count
            } else {
                return 1
            }
        case CommunityType.clien.rawValue:
            if toggleDict[CommunityType.clien.rawValue]! {
                return self.clienContents.count
            } else {
                return 1
            }
        case CommunityType.fm.rawValue:
            if toggleDict[CommunityType.fm.rawValue]! {
                return self.fmContents.count
            } else {
                return 1
            }
        case CommunityType.instiz.rawValue:
            if toggleDict[CommunityType.instiz.rawValue]! {
                return self.instizContents.count
            } else {
                return 1
            }
        case CommunityType.cook.rawValue:
            if toggleDict[CommunityType.cook.rawValue]! {
                return self.cookContents.count
            } else {
                return 1
            }
        case CommunityType.namu.rawValue:
            if toggleDict[CommunityType.namu.rawValue]! {
                return self.namuContents.count
            } else {
                return 1
            }
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var data: (title: String, url: String, idx: Int)!
        
        switch indexPath.section {
        case CommunityType.ruliweb.rawValue:
            data = self.ruliwebContents[indexPath.row]
        case CommunityType.nate.rawValue:
            data = self.nateContents[indexPath.row]
        case CommunityType.ilbe.rawValue:
            data = self.ilbeContents[indexPath.row]
        case CommunityType.ppomppu.rawValue:
            data = self.ppomppuContents[indexPath.row]
        case CommunityType.clien.rawValue:
            data = self.clienContents[indexPath.row]
        case CommunityType.fm.rawValue:
            data = self.fmContents[indexPath.row]
        case CommunityType.instiz.rawValue:
            data = self.instizContents[indexPath.row]
        case CommunityType.cook.rawValue:
            data = self.cookContents[indexPath.row]
        case CommunityType.namu.rawValue:
            data = self.namuContents[indexPath.row]
        default:
            ()
        }
        
        if self.toggleDict[indexPath.section] == false {
            return UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "article_cell") as! ArticleCell
            cell.labelNum.font = UIFont.init(name: "AppleSDGothicNeo-Bold", size: 14)
            cell.labelNum.textColor = self.brownColor
            cell.labelText.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 14)
            
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
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: Constants.sectionHeight))
        
        headerView.backgroundColor = self.grayColor1
        
        // header의 상위 margin view 설정
        let headerUpperMarginView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: Constants.sectionMargin))
        headerUpperMarginView.backgroundColor = self.grayColor1
        
        // header의 main view 설정
        let headerUpperView = UIView(frame: CGRect(x: Constants.sectionMargin, y: Constants.sectionMargin, width: self.view.frame.width - (Constants.sectionMargin * 2), height: Constants.sectionHeight - (Constants.sectionMargin * 2)))
        
        headerUpperView.backgroundColor = UIColor.white
        
        let circle = UILabel()
        circle.font = UIFont.systemFont(ofSize: 10)
        circle.text = "●"
        
        let subTitle = UILabel()
        subTitle.textColor = self.grayColor5
        subTitle.font = UIFont.init(name: "AppleSDGothicNeo-Bold", size: 12)
        subTitle.textAlignment = .left
        
        let title = UILabel()
        title.font = UIFont.init(name: "AppleSDGothicNeo-Bold", size: 17)
        title.textColor = self.grayColor7
        title.textAlignment = .left
        
        // 접기/펼치기 버튼 생성 및 설정
        let toggleBtn = UILabel()
        toggleBtn.isUserInteractionEnabled = true
        toggleBtn.text = "TG"
        toggleBtn.tag = section
        toggleBtn.frame.size = CGSize(width: 30, height: 30)
        headerUpperView.addSubview(toggleBtn)
        toggleBtn.snp.makeConstraints{ (make) in
            make.right.equalTo(headerUpperView).offset(-10)
            make.top.equalTo(headerUpperView).offset(10)
        }
        
        switch section {
        case CommunityType.cook.rawValue:
            circle.textColor = self.orangeColor7
            subTitle.text = CommunityType.getCommunityName(.cook)().uppercased()
            title.text = CommunityType.getCommunityKoreanName(.cook)()

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
            toggleBtn.addGestureRecognizer(tapGesture)
        case CommunityType.ilbe.rawValue:
            circle.textColor = self.yellowColor7
            subTitle.text = CommunityType.getCommunityName(.ilbe)().uppercased()
            title.text = CommunityType.getCommunityKoreanName(.ilbe)()

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
            toggleBtn.addGestureRecognizer(tapGesture)
        case CommunityType.instiz.rawValue:
            circle.textColor = self.cyanColor7
            subTitle.text = CommunityType.getCommunityName(.instiz)().uppercased()
            title.text = CommunityType.getCommunityKoreanName(.instiz)()

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
            toggleBtn.addGestureRecognizer(tapGesture)
        case CommunityType.ruliweb.rawValue:
            circle.textColor = self.subColor
            subTitle.text = CommunityType.getCommunityName(.ruliweb)().uppercased()
            title.text = CommunityType.getCommunityKoreanName(.ruliweb)()

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
            toggleBtn.addGestureRecognizer(tapGesture)
        case CommunityType.clien.rawValue:
            circle.textColor = self.grapeColor7
            subTitle.text = CommunityType.getCommunityName(.clien)().uppercased()
            title.text = CommunityType.getCommunityKoreanName(.clien)()

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
            toggleBtn.addGestureRecognizer(tapGesture)
        case CommunityType.namu.rawValue:
            circle.textColor = self.limeColor7
            subTitle.text = CommunityType.getCommunityName(.namu)().uppercased()
            title.text = CommunityType.getCommunityKoreanName(.namu)()

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
            toggleBtn.addGestureRecognizer(tapGesture)
        case CommunityType.ppomppu.rawValue:
            circle.textColor = self.greenColor7
            subTitle.text = CommunityType.getCommunityName(.ppomppu)().uppercased()
            title.text = CommunityType.getCommunityKoreanName(.ppomppu)()

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
            toggleBtn.addGestureRecognizer(tapGesture)
        case CommunityType.nate.rawValue:
            circle.textColor = self.pinkColor7
            subTitle.text = CommunityType.getCommunityName(.nate)().uppercased()
            title.text = CommunityType.getCommunityKoreanName(.nate)()

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
            toggleBtn.addGestureRecognizer(tapGesture)
        case CommunityType.fm.rawValue:
            circle.textColor = self.violetColor7
            subTitle.text = CommunityType.getCommunityName(.fm)().uppercased()
            title.text = CommunityType.getCommunityKoreanName(.fm)()

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
            toggleBtn.addGestureRecognizer(tapGesture)
        default:
            ()
        }
        
        // title, subTitle view에 letter-spaing 설정
        title.addCharacterSpacing(kernValue: 1.5)
        subTitle.addCharacterSpacing(kernValue: 1.5)
        
        headerUpperView.addSubview(circle)
        headerUpperView.addSubview(subTitle)
        headerUpperView.addSubview(title)
        headerView.addSubview(headerUpperMarginView)
        headerView.addSubview(headerUpperView)
        
        circle.snp.makeConstraints { (make) in
            make.left.equalTo(headerUpperView).offset(20)
            make.top.equalTo(headerUpperView).offset(10)
        }
        
        subTitle.snp.makeConstraints { (make) in
            make.left.equalTo(circle.snp.right).offset(10)
            make.top.equalTo(headerUpperView).offset(10)
        }
        
        title.snp.makeConstraints { (make) in
            make.left.equalTo(headerUpperView).offset(20)
            make.bottom.equalTo(headerUpperView).offset(-10)
        }
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = self.grayColor1
        
        return footer
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionHeight: CGFloat = Constants.sectionHeight
        return sectionHeight
        
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let sectionHeight: CGFloat = Constants.sectionFooterMargin
        if toggleDict[section] == false {
            return CGFloat.leastNonzeroMagnitude
        } else {
            return sectionHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if toggleDict[indexPath.section] == false {
            return 0
        } else {
            return Constants.cellHeight
        }
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
        case CommunityType.fm.rawValue:
            url = self.fmContents[indexPath.row].url
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
        webContentManager.getFmContents {
            self.fmContents = webContentManager.fmContents
            self.tableView.reloadData()
        }
    }
    
    @objc func pullToRefresh(_ sender: Any) {
        self.getContents()
        
        self.dispatchDelay(delay: Constants.delayTime) {
            // 당겨서 새로고침 종료
           self.refreshControl?.endRefreshing()
        }
    }
    
    @objc func toggleSection(_ sender: UITapGestureRecognizer) {
        let tag = (sender.view?.tag)!
        
        if toggleDict[tag]! {
            toggleDict[tag] = false
        } else {
            toggleDict[tag] = true
        }

        self.tableView.reloadSections(NSIndexSet(index: tag) as IndexSet, with: UITableView.RowAnimation.automatic)
        
    }

}
