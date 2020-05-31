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
import GoogleMobileAds

public enum CommunityType: Int {
    case upperInfo
    case ruliweb
    case nate
    case bullpen
    case ppomppu
    case clien
    case fm
    case theqoo
    case instiz
    case cook
    case namu
    // enum의 count를 위한 case - 항상 제일 마지막에 위치해야 함
    case count
    
    func getCommunityName() -> String {
        switch self {
        case .upperInfo:
            return ""
        case .cook:
            return "82cook"
        case .bullpen:
            return "Bullpen"
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
        case .theqoo:
            return "Theqoo"
        case .count:
            return ""
        }
    }
    
    func getCommunityKoreanName() -> String {
        switch self {
        case .upperInfo:
            return ""
        case .cook:
            return "82cook"
        case .bullpen:
            return "불펜"
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
        case .theqoo:
            return "더쿠"
        case .count:
            return ""
        }
    }
    
    func getCommunityKeyName() -> String {
        switch self {
        case .upperInfo:
            return ""
        case .cook:
            return "cook"
        case .bullpen:
            return "bullpen"
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
        case .theqoo:
            return "theqoo"
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
    
    lazy var theqooContents: [(title: String, url: String, idx: Int)] = {
        var list = [(String, String, Int)]()
        return list
    }()
    
    // section 접기/펼치기를 위한 Dictionary 생성
    var toggleDict: Dictionary<String, Bool> = [
        "0": true, "1": true, "2": true, "3": true, "4": true,
        "5": true, "6": true, "7": true, "8": true, "9": true,
        "10": true
    ]
    
    let toggleLabelClian = UILabel()
    
    var toggleClian: Bool = false {
        didSet {
            if toggleClian {
                toggleLabelClian.text = "close ⋀"
            } else {
                toggleLabelClian.text = "more ⋁"
            }
        }
    }
    
    let toggleLabelFm = UILabel()
    
    var toggleFm: Bool = false {
        didSet {
            if toggleFm {
                toggleLabelFm.text = "close ⋀"
            } else {
                toggleLabelFm.text = "more ⋁"
            }
        }
    }
    
    let toggleLabelTheqoo = UILabel()
    
    var toggleTheqoo: Bool = false {
        didSet {
            if toggleTheqoo {
                toggleLabelTheqoo.text = "close ⋀"
            } else {
                toggleLabelTheqoo.text = "more ⋁"
            }
        }
    }
    
    // 구글 애드몹 배너 객체 선언
    var bannerView: GADBannerView!
    
    // 이미지 cell의 높이
    let imgHeight: CGFloat = 150

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
        
        // toggleLabel 설정
        self.setMoreLabel(label: self.toggleLabelClian)
        self.setMoreLabel(label: self.toggleLabelFm)
        self.setMoreLabel(label: self.toggleLabelTheqoo)
        
        // toggle 정보 불러오기
        let ud = UserDefaults.standard
        if let udData = ud.dictionary(forKey: "communityToggle") {
            toggleDict = udData as! Dictionary<String, Bool>
        } else {
            ud.set(toggleDict, forKey: "communityToggle")
            ud.synchronize()
        }
        
        // 구글 애드몹 달기
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        self.addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewWillLayoutSubviews() {
        // custom header, tabbar의 높이만큼 rootview 위치 및 높이 조정
        let screen = UIScreen.main.bounds
        let margin = Constants.csTabbarHeight + self.upperHeight
        self.view.frame.origin.y = margin
        self.view.frame.size.height = screen.size.height - margin
        self.view.bringSubviewToFront(self.bannerView)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return CommunityType.count.rawValue
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        switch section {
        case CommunityType.upperInfo.rawValue:
            return 1
        case CommunityType.ruliweb.rawValue:
            if toggleDict[String(CommunityType.ruliweb.rawValue)]! {
                if self.ruliwebContents.count == 0 {
                    return 1
                } else {
                    return self.ruliwebContents.count
                }
            } else {
                return 1
            }
        case CommunityType.nate.rawValue:
            if toggleDict[String(CommunityType.nate.rawValue)]! {
                if self.nateContents.count == 0 {
                    return 1
                } else {
                    return self.nateContents.count
                }
            } else {
                return 1
            }
        case CommunityType.bullpen.rawValue:
            if toggleDict[String(CommunityType.bullpen.rawValue)]! {
                if self.bullpenContents.count == 0 {
                    return 1
                } else {
                    return self.bullpenContents.count
                }
            } else {
                return 1
            }
        case CommunityType.ppomppu.rawValue:
            if toggleDict[String(CommunityType.ppomppu.rawValue)]! {
                if self.ppomppuContents.count == 0 {
                    return 1
                } else {
                    return self.ppomppuContents.count
                }
            } else {
                return 1
            }
        case CommunityType.clien.rawValue:
            if toggleDict[String(CommunityType.clien.rawValue)]! {
                if self.clienContents.count == 0 {
                    return 1
                } else {
                    if self.toggleClian {
                        return self.clienContents.count
                    } else {
                        return self.clienContents.count / 2
                    }
                }
            } else {
                return 1
            }
        case CommunityType.fm.rawValue:
            if toggleDict[String(CommunityType.fm.rawValue)]! {
                if self.fmContents.count == 0 {
                    return 1
                } else {
                    if self.toggleFm {
                        return self.fmContents.count
                    } else {
                        return self.fmContents.count / 2
                    }
                }
            } else {
                return 1
            }
        case CommunityType.theqoo.rawValue:
            if toggleDict[String(CommunityType.theqoo.rawValue)]! {
                if self.theqooContents.count == 0 {
                    return 1
                } else {
                    if self.toggleTheqoo {
                        return self.theqooContents.count
                    } else {
                        return self.theqooContents.count / 2
                    }
                }
            } else {
                return 1
            }
        case CommunityType.instiz.rawValue:
            if toggleDict[String(CommunityType.instiz.rawValue)]! {
                if self.instizContents.count == 0 {
                    return 1
                } else {
                    return self.instizContents.count
                }
            } else {
                return 1
            }
        case CommunityType.cook.rawValue:
            if toggleDict[String(CommunityType.cook.rawValue)]! {
                if self.cookContents.count == 0{
                    return 1
                } else {
                    return self.cookContents.count
                }
            } else {
                return 1
            }
        case CommunityType.namu.rawValue:
            if toggleDict[String(CommunityType.namu.rawValue)]! {
                if self.namuContents.count == 0 {
                    return 1
                } else {
                    return self.namuContents.count
                }
            } else {
                return 1
            }
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var data: (title: String, url: String, idx: Int)!
        
        if indexPath.section == CommunityType.upperInfo.rawValue {
            let cell = UITableViewCell()
            
            let height = Constants.imgHeight
            
            // cell 설정
            cell.contentView.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: height)
            
            let imgView = UIImageView()
            let mainLabel = UILabel()
            let subLabel = UILabel()

            let communityImage = self.resizeImage(image: UIImage(named: "community_b")!, toTheSize: CGSize(width: self.view.frame.width, height: height))
            
            imgView.frame = CGRect(x: 0, y: 0, width: cell.contentView.frame.width, height: height)
            imgView.image = communityImage
            imgView.contentMode = .scaleAspectFill
            cell.contentView.addSubview(imgView)

            mainLabel.font = UIFont.init(name: Constants.mainFontBold, size: 24)
            mainLabel.textColor = UIColor.white
            mainLabel.text = "커뮤니티 인기글"
            cell.contentView.addSubview(mainLabel)
            mainLabel.snp.makeConstraints{(make) in
                make.left.equalTo(cell.contentView).offset(20)
                make.bottom.equalTo(cell.contentView).offset(-40)
            }
            
            subLabel.font = UIFont.init(name: Constants.mainFont, size: 14)
            subLabel.textColor = UIColor.white
            subLabel.text = "커뮤티니 실시간 인기글 모음"
            cell.contentView.addSubview(subLabel)
            subLabel.snp.makeConstraints{(make) in
                make.left.equalTo(cell.contentView).offset(20)
                make.bottom.equalTo(cell.contentView).offset(-15)
            }
            
            return cell
        } else {
            if self.toggleDict[String(indexPath.section)] == false {
                return UITableViewCell()
            } else {
                switch indexPath.section {
                case CommunityType.ruliweb.rawValue:
                    if self.ruliwebContents.count == 0 { return UITableViewCell() }
                    data = self.ruliwebContents[indexPath.row]
                case CommunityType.nate.rawValue:
                    if self.nateContents.count == 0 { return UITableViewCell() }
                    data = self.nateContents[indexPath.row]
                case CommunityType.bullpen.rawValue:
                    if self.bullpenContents.count == 0 { return UITableViewCell() }
                    data = self.bullpenContents[indexPath.row]
                case CommunityType.ppomppu.rawValue:
                    if self.ppomppuContents.count == 0 { return UITableViewCell() }
                    data = self.ppomppuContents[indexPath.row]
                case CommunityType.clien.rawValue:
                    if self.clienContents.count == 0 { return UITableViewCell() }
                    data = self.clienContents[indexPath.row]
                case CommunityType.fm.rawValue:
                    if self.fmContents.count == 0 { return UITableViewCell() }
                    data = self.fmContents[indexPath.row]
                case CommunityType.theqoo.rawValue:
                    if self.theqooContents.count == 0 { return UITableViewCell() }
                    data = self.theqooContents[indexPath.row]
                case CommunityType.instiz.rawValue:
                    if self.instizContents.count == 0 { return UITableViewCell() }
                    data = self.instizContents[indexPath.row]
                case CommunityType.cook.rawValue:
                    if self.cookContents.count == 0 { return UITableViewCell() }
                    data = self.cookContents[indexPath.row]
                case CommunityType.namu.rawValue:
                    if self.namuContents.count == 0 { return UITableViewCell() }
                    data = self.namuContents[indexPath.row]
                default:
                    ()
                }
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "article_cell") as! ArticleCell
                cell.labelNum.font = UIFont.init(name: Constants.mainFontBold, size: 13)
                cell.labelNum.textColor = self.grayColor5
                cell.labelText.font = UIFont.init(name: Constants.mainFont, size: 13)
                cell.labelText.textColor = self.grayColor8
                
                cell.contentView.backgroundColor = self.grayColor1
                
                cell.labelNum.text = String(indexPath.row + 1)
                cell.labelText.text = data.title

                return cell
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        if self.toggleDict[String(section)]! {
            headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: Constants.sectionHeight)
        } else {
            headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: (Constants.sectionHeight / 2))
        }
        
        headerView.backgroundColor = self.grayColor1
        
        // header의 상위 margin view 설정
        let headerUpperMarginView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: Constants.sectionMargin))
        headerUpperMarginView.backgroundColor = self.grayColor1
        
        // header의 main view 설정
        let headerUpperView = UIView()
        if self.toggleDict[String(section)]! {
            headerUpperView.frame = CGRect(x: Constants.sectionMargin, y: Constants.sectionMargin, width: self.view.frame.width - (Constants.sectionMargin * 2), height: Constants.sectionHeight)
        } else {
            headerUpperView.frame = CGRect(x: Constants.sectionMargin, y: Constants.sectionMargin, width: self.view.frame.width - (Constants.sectionMargin * 2), height: (Constants.sectionHeight - (Constants.sectionMargin * 2)) / 2)
        }
        
        headerUpperView.backgroundColor = UIColor.white
        
        let circle = UILabel()
        circle.font = UIFont.systemFont(ofSize: 10)
        circle.text = "●"
        
        let subTitle = UILabel()
        subTitle.textColor = self.grayColor5
        subTitle.font = UIFont.init(name: Constants.mainFontBold, size: 12)
        subTitle.textAlignment = .left
        
        // 접기/펼치기 버튼 생성 및 설정
        let toggleBtn = UIImageView()
        let windowIcon = self.toggleDict[String(section)]! ? UIImage(named: "iconMinimize") : UIImage(named: "iconRestore")
        let newWindowIcon = resizeImage(image: windowIcon!, toTheSize: CGSize(width: 20, height: 20))
        toggleBtn.isUserInteractionEnabled = true
        toggleBtn.image = newWindowIcon
        toggleBtn.contentMode = .scaleAspectFit
        toggleBtn.tag = section
        toggleBtn.frame.size = CGSize(width: 20, height: 20)
        headerUpperView.addSubview(toggleBtn)
        toggleBtn.snp.makeConstraints{ (make) in
            make.right.equalTo(headerUpperView).offset(-15)
            make.top.equalTo(headerUpperView).offset(7)
        }
        
        // toggleLabelHeader 설정
        let toggleLabelHeader = UILabel()
        toggleLabelHeader.text = self.toggleDict[String(section)]! ? "숨기기" : "펼치기"
        toggleLabelHeader.textColor = self.grayColor5
        toggleLabelHeader.contentMode = .right
        toggleLabelHeader.addCharacterSpacing(kernValue: 1.5)
        toggleLabelHeader.font = UIFont.init(name: Constants.mainFont, size: 12)
        toggleLabelHeader.isUserInteractionEnabled = true
        toggleLabelHeader.tag = section
        headerUpperView.addSubview(toggleLabelHeader)
        toggleLabelHeader.snp.makeConstraints{ (make) in
            make.right.equalTo(toggleBtn.snp.left).offset(-5)
            make.centerY.equalTo(toggleBtn.snp.centerY)
        }
        
        switch section {
        case CommunityType.cook.rawValue:
            self.setHeaderView(circle: circle, subTitle: subTitle, color: self.orangeColor7, textEn: CommunityType.getCommunityName(.cook)().uppercased(), textKo: CommunityType.getCommunityKoreanName(.cook)(), btn: toggleBtn, labelHeader: toggleLabelHeader, rawValue: String(CommunityType.cook.rawValue), superView: headerUpperView)
        case CommunityType.bullpen.rawValue:
            self.setHeaderView(circle: circle, subTitle: subTitle, color: self.yellowColor7, textEn: CommunityType.getCommunityName(.bullpen)().uppercased(), textKo: CommunityType.getCommunityKoreanName(.bullpen)(), btn: toggleBtn, labelHeader: toggleLabelHeader, rawValue: String(CommunityType.bullpen.rawValue), superView: headerUpperView)
        case CommunityType.instiz.rawValue:
            self.setHeaderView(circle: circle, subTitle: subTitle, color: self.cyanColor7, textEn: CommunityType.getCommunityName(.instiz)().uppercased(), textKo: CommunityType.getCommunityKoreanName(.instiz)(), btn: toggleBtn, labelHeader: toggleLabelHeader, rawValue: String(CommunityType.instiz.rawValue), superView: headerUpperView)
        case CommunityType.ruliweb.rawValue:
            self.setHeaderView(circle: circle, subTitle: subTitle, color: self.subColor, textEn: CommunityType.getCommunityName(.ruliweb)().uppercased(), textKo: CommunityType.getCommunityKoreanName(.ruliweb)(), btn: toggleBtn, labelHeader: toggleLabelHeader, rawValue: String(CommunityType.ruliweb.rawValue), superView: headerUpperView)
        case CommunityType.clien.rawValue:
            self.setHeaderView(circle: circle, subTitle: subTitle, color: self.grapeColor7, textEn: CommunityType.getCommunityName(.clien)().uppercased(), textKo: CommunityType.getCommunityKoreanName(.clien)(), btn: toggleBtn, labelHeader: toggleLabelHeader, rawValue: String(CommunityType.clien.rawValue), superView: headerUpperView)
        case CommunityType.namu.rawValue:
            self.setHeaderView(circle: circle, subTitle: subTitle, color: self.limeColor7, textEn: CommunityType.getCommunityName(.namu)().uppercased(), textKo: CommunityType.getCommunityKoreanName(.namu)(), btn: toggleBtn, labelHeader: toggleLabelHeader, rawValue: String(CommunityType.namu.rawValue), superView: headerUpperView)
        case CommunityType.ppomppu.rawValue:
            self.setHeaderView(circle: circle, subTitle: subTitle, color: self.greenColor7, textEn: CommunityType.getCommunityName(.ppomppu)().uppercased(), textKo: CommunityType.getCommunityKoreanName(.ppomppu)(), btn: toggleBtn, labelHeader: toggleLabelHeader, rawValue: String(CommunityType.ppomppu.rawValue), superView: headerUpperView)
        case CommunityType.nate.rawValue:
            self.setHeaderView(circle: circle, subTitle: subTitle, color: self.pinkColor7, textEn: CommunityType.getCommunityName(.nate)().uppercased(), textKo: CommunityType.getCommunityKoreanName(.nate)(), btn: toggleBtn, labelHeader: toggleLabelHeader, rawValue: String(CommunityType.nate.rawValue), superView: headerUpperView)
        case CommunityType.fm.rawValue:
            self.setHeaderView(circle: circle, subTitle: subTitle, color: self.violetColor7, textEn: CommunityType.getCommunityName(.fm)().uppercased(), textKo: CommunityType.getCommunityKoreanName(.fm)(), btn: toggleBtn, labelHeader: toggleLabelHeader, rawValue: String(CommunityType.fm.rawValue), superView: headerUpperView)
        case CommunityType.theqoo.rawValue:
            self.setHeaderView(circle: circle, subTitle: subTitle, color: self.violetColor7, textEn: CommunityType.getCommunityName(.theqoo)().uppercased(), textKo: CommunityType.getCommunityKoreanName(.theqoo)(), btn: toggleBtn, labelHeader: toggleLabelHeader, rawValue: String(CommunityType.theqoo.rawValue), superView: headerUpperView)
        default:
            ()
        }
        
        // subTitle view에 letter-spaing 설정
        subTitle.addCharacterSpacing(kernValue: 1.5)
        headerUpperView.addSubview(circle)
        headerUpperView.addSubview(subTitle)
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
        
        if section == CommunityType.upperInfo.rawValue {
            return nil
        } else {
            return headerView
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        if section == CommunityType.clien.rawValue && !self.clienContents.isEmpty && self.toggleDict[String(CommunityType.clien.rawValue)]! {
            // 접기/펼치기를 위한 버튼 생성
            footer.frame.size.width = self.tableView.frame.width
            let toggleView = UIView()
            let margin: CGFloat = 10
            let width = footer.frame.size.width - (margin * 2)
            toggleView.frame = CGRect(x: margin, y: 0, width: width, height: Constants.cellToggleBtnHeight)
            toggleView.backgroundColor = UIColor.white
            
            toggleView.addSubview(self.toggleLabelClian)
            
            self.toggleLabelClian.snp.makeConstraints{ (make) in
                make.centerX.equalTo(toggleView)
                make.centerY.equalTo(toggleView)
                make.width.equalTo(Constants.cellToggleBtnWidth)
                make.height.equalTo(Constants.cellToggleBtnHeight - 20)
            }
            self.toggleLabelClian.tag = section
            
            footer.addSubview(toggleView)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleCell(_:)))
            self.toggleLabelClian.addGestureRecognizer(tapGesture)
        } else if section == CommunityType.fm.rawValue && !self.fmContents.isEmpty && self.toggleDict[String(CommunityType.fm.rawValue)]! {
            
            // 접기/펼치기를 위한 버튼 생성
            footer.frame.size.width = self.tableView.frame.width
            let toggleView = UIView()
            let margin: CGFloat = 10
            let width = footer.frame.size.width - (margin * 2)
            toggleView.frame = CGRect(x: margin, y: 0, width: width, height: Constants.cellToggleBtnHeight)
            toggleView.backgroundColor = UIColor.white
            
            toggleView.addSubview(self.toggleLabelFm)
            toggleLabelFm.snp.makeConstraints{ (make) in
                make.centerX.equalTo(toggleView)
                make.centerY.equalTo(toggleView)
                make.width.equalTo(Constants.cellToggleBtnWidth)
                make.height.equalTo(Constants.cellToggleBtnHeight - 20)
            }
            
            self.toggleLabelFm.tag = section
            footer.addSubview(toggleView)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleCell(_:)))
            self.toggleLabelFm.addGestureRecognizer(tapGesture)
        } else if section == CommunityType.theqoo.rawValue && !self.theqooContents.isEmpty && self.toggleDict[String(CommunityType.theqoo.rawValue)]! {
            
            // 접기/펼치기를 위한 버튼 생성
            footer.frame.size.width = self.tableView.frame.width
            let toggleView = UIView()
            let margin: CGFloat = 10
            let width = footer.frame.size.width - (margin * 2)
            toggleView.frame = CGRect(x: margin, y: 0, width: width, height: Constants.cellToggleBtnHeight)
            toggleView.backgroundColor = UIColor.white
            
            toggleView.addSubview(self.toggleLabelTheqoo)
            toggleLabelTheqoo.snp.makeConstraints{ (make) in
                make.centerX.equalTo(toggleView)
                make.centerY.equalTo(toggleView)
                make.width.equalTo(Constants.cellToggleBtnWidth)
                make.height.equalTo(Constants.cellToggleBtnHeight - 20)
            }
            
            self.toggleLabelTheqoo.tag = section
            footer.addSubview(toggleView)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleCell(_:)))
            self.toggleLabelTheqoo.addGestureRecognizer(tapGesture)
        } else {
           
        }
        footer.backgroundColor = self.grayColor1
        
        return footer
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == CommunityType.upperInfo.rawValue {
            return CGFloat.leastNonzeroMagnitude
        } else {
            if self.toggleDict[String(section)]! {
                return Constants.sectionHeight
            } else {
                return Constants.sectionHeight / 2
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let sectionHeight: CGFloat = Constants.sectionFooterMargin
        if section == CommunityType.upperInfo.rawValue {
            return sectionHeight
        } else {
            if toggleDict[String(section)] == false {
                return CGFloat.leastNonzeroMagnitude
            } else {
                if section == CommunityType.clien.rawValue && !self.clienContents.isEmpty {
                    return sectionHeight + Constants.cellToggleBtnHeight
                } else if section == CommunityType.fm.rawValue && !self.fmContents.isEmpty {
                    return sectionHeight + Constants.cellToggleBtnHeight
                } else if section == CommunityType.theqoo.rawValue && !self.theqooContents.isEmpty {
                    return sectionHeight + Constants.cellToggleBtnHeight
                }
                else {
                    // 마지막 section에서 높이 추가
                    if section == CommunityType.namu.rawValue {
                        return sectionHeight + Constants.cellHeight
                    } else {
                        return sectionHeight
                    }
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == CommunityType.upperInfo.rawValue {
            return Constants.imgHeight

            
        } else {
            if toggleDict[String(indexPath.section)] == false {
                return 0
            } else {
                var dataCount = 0
                switch indexPath.section {
                case CommunityType.ruliweb.rawValue:
                    dataCount = self.ruliwebContents.count
                case CommunityType.nate.rawValue:
                    dataCount = self.nateContents.count
                case CommunityType.bullpen.rawValue:
                    dataCount = self.bullpenContents.count
                case CommunityType.ppomppu.rawValue:
                    dataCount = self.ppomppuContents.count
                case CommunityType.clien.rawValue:
                    dataCount = self.clienContents.count
                case CommunityType.fm.rawValue:
                    dataCount = self.fmContents.count
                case CommunityType.instiz.rawValue:
                    dataCount = self.instizContents.count
                case CommunityType.cook.rawValue:
                    dataCount = self.cookContents.count
                case CommunityType.namu.rawValue:
                    dataCount = self.namuContents.count
                case CommunityType.theqoo.rawValue:
                    dataCount = self.theqooContents.count
                default:
                    dataCount = 0
                }
                
                if dataCount == 0 {
                    return 0
                } else {
                    return Constants.cellHeight
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == CommunityType.upperInfo.rawValue {
            return nil
        } else {
            return indexPath
        }
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var url = "https://www.google.com"
        
        switch indexPath.section {
        case CommunityType.cook.rawValue:
            url = self.cookContents[indexPath.row].url
        case CommunityType.bullpen.rawValue:
            url = self.bullpenContents[indexPath.row].url
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
        case CommunityType.theqoo.rawValue:
            url = self.theqooContents[indexPath.row].url
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
        webContentManager.getBullpenContents {
            self.bullpenContents = webContentManager.bullpenContents
            self.tableView.reloadData()
        }
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
        webContentManager.getTheqooContents {
            self.theqooContents = webContentManager.theqooContents
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
    
    func reload() {
        let activityIndicator = ActivityIndicator(view: self.view, navigationController: self.navigationController, tabBarController: nil, upperHeight: self.upperHeight)
        activityIndicator.showActivityIndicator(text: "로딩 중")
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        self.getContents()
        self.dispatchDelay(delay: Constants.delayTime) {
            activityIndicator.stopActivityIndicator()
        }
    }
    
    @objc func toggleSection(_ sender: UITapGestureRecognizer) {
   
        let tag = (sender.view?.tag)!
        let ud = UserDefaults.standard
        var tempDict = ud.dictionary(forKey: "communityToggle") as! Dictionary<String, Bool>

        if toggleDict[String(tag)]! {
            toggleDict[String(tag)] = false
            tempDict[String(tag)] = false
            
        } else {
            toggleDict[String(tag)] = true
            tempDict[String(tag)] = true
        }
        ud.set(tempDict, forKey: "communityToggle")
        ud.synchronize()
        self.tableView.reloadSections(NSIndexSet(index: tag) as IndexSet, with: UITableView.RowAnimation.automatic)
    }
    
    @objc func toggleCell(_ sender: UITapGestureRecognizer) {
        let section = (sender.view?.tag)!
        var last = 20
        var half = 10
        if section == CommunityType.clien.rawValue {
            last = self.clienContents.count
            half = last / 2
            self.toggleClian = !(self.toggleClian)
        } else if section == CommunityType.fm.rawValue {
            last = self.fmContents.count
            half = last / 2
            self.toggleFm = !(self.toggleFm)
        } else if section == CommunityType.theqoo.rawValue {
            last = self.theqooContents.count
            half = last / 2
            self.toggleTheqoo = !(self.toggleTheqoo)
        }
        let indexPaths = (half..<last).map{
            i in return IndexPath(item: i, section: section)
        }

        self.tableView.beginUpdates()
            if section == CommunityType.clien.rawValue {
                if self.toggleClian {
                    self.tableView.insertRows(at: indexPaths, with: .automatic)
                } else {
                    self.tableView.deleteRows(at: indexPaths, with: .automatic)
                }
            } else if section == CommunityType.fm.rawValue {
                if self.toggleFm{
                    self.tableView.insertRows(at: indexPaths, with: .automatic)
                } else {
                    self.tableView.deleteRows(at: indexPaths, with: .automatic)
                }
            } else if section == CommunityType.theqoo.rawValue {
                if self.toggleTheqoo{
                    self.tableView.insertRows(at: indexPaths, with: .automatic)
                } else {
                    self.tableView.deleteRows(at: indexPaths, with: .automatic)
                }
            }
        self.tableView.endUpdates()
    }
    
    // more button 설정 함수
    func setMoreLabel(label: UILabel) {
        label.text = "more ⋁"
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont.init(name: Constants.mainFontBold, size: 13)
        label.isUserInteractionEnabled = true
        label.backgroundColor = self.grayColor9
        label.layer.cornerRadius = (Constants.cellToggleBtnHeight - 20) / 2
        label.layer.masksToBounds = true
//        label.addCharacterSpacing(kernValue: 1.5)
        
    }
    
    // header view 설정
    func setHeaderView(circle: UILabel, subTitle: UILabel, color: UIColor, textEn: String, textKo: String, btn: UIImageView, labelHeader: UILabel, rawValue: String, superView: UIView ) {
        circle.textColor = color
        subTitle.text = textEn
        
        // UITapGestureRecognizer 설정
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
        btn.addGestureRecognizer(tapGesture)
        labelHeader.addGestureRecognizer(tapGesture2)
        
        // title label 생성 및 설정
        if self.toggleDict[rawValue]! {
            let title = UILabel()
            title.font = UIFont.init(name: Constants.mainFontBold, size: 17)
            title.textColor = self.grayColor7
            title.textAlignment = .left
            title.text = textKo
            title.addCharacterSpacing(kernValue: 1.5)
            superView.addSubview(title)
            title.snp.makeConstraints { (make) in
                make.left.equalTo(superView).offset(20)
                make.bottom.equalTo(superView).offset(-(10 + (Constants.sectionMargin) * 2))
            }
        }
    }
                
    // 구글 애드몹 배너 설정 메소드
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.insertSubview(bannerView, aboveSubview: tableView)
        if #available(iOS 11.0, *) {
            self.view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: self.view.safeAreaLayoutGuide,
                                attribute: .bottom,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
        } else {
            self.view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
        }
     }
}
