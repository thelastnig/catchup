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
        case .upperInfo:
            return ""
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
        case .upperInfo:
            return ""
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
        case .upperInfo:
            return ""
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
    
    // section 접기/펼치기를 위한 Dictionary 생성
    var toggleDict: Dictionary<Int, Bool> = [
        0: true, 1: true, 2: true, 3: true, 4: true,
        5: true, 6: true, 7: true, 8: true, 9: true
    ]
    
    let toggleLabelClian = UILabel()
    
    var toggleClian: Bool = false {
        didSet {
            if toggleClian {
                toggleLabelClian.text = "접기 ⋀"
                toggleLabelClian.textColor = self.grayColor6
            } else {
                toggleLabelClian.text = "더보기 ⋁"
                toggleLabelClian.textColor = self.mainColor
            }
        }
    }
    
    let toggleLabelFm = UILabel()
    
    var toggleFm: Bool = false {
        didSet {
            if toggleFm {
                toggleLabelFm.text = "접기 ⋀"
                toggleLabelFm.textColor = self.grayColor6
            } else {
                toggleLabelFm.text = "더보기 ⋁"
                toggleLabelFm.textColor = self.mainColor
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
        self.toggleLabelClian.text = "더보기 ⋁"
        self.toggleLabelClian.textAlignment = .center
        self.toggleLabelClian.textColor = self.mainColor
        self.toggleLabelClian.font = UIFont.init(name: Constants.mainFontBold, size: 12)
        self.toggleLabelClian.addCharacterSpacing(kernValue: 1.5)
        self.toggleLabelClian.isUserInteractionEnabled = true
        
        self.toggleLabelFm.text = "더보기 ⋁"
        self.toggleLabelFm.textAlignment = .center
        self.toggleLabelFm.textColor = self.mainColor
        self.toggleLabelFm.font = UIFont.init(name: Constants.mainFontBold, size: 12)
        self.toggleLabelFm.addCharacterSpacing(kernValue: 1.5)
        self.toggleLabelFm.isUserInteractionEnabled = true
        
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
                if self.toggleClian {
                    return self.clienContents.count
                } else {
                    return self.clienContents.count / 2
                }
            } else {
                return 1
            }
        case CommunityType.fm.rawValue:
            if toggleDict[CommunityType.fm.rawValue]! {
                if self.toggleFm {
                    return self.fmContents.count
                } else {
                    return self.fmContents.count / 2
                }
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
                cell.labelNum.font = UIFont.init(name: Constants.mainFontBold, size: 13)
                cell.labelNum.textColor = self.grayColor5
                cell.labelText.font = UIFont.init(name: Constants.mainFont, size: 13)
                cell.labelText.textColor = self.grayColor9
                
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
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        if self.toggleDict[section]! {
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
        if self.toggleDict[section]! {
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
        let windowIcon = self.toggleDict[section]! ? UIImage(named: "iconMinimize") : UIImage(named: "iconRestore")
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
        toggleLabelHeader.text = self.toggleDict[section]! ? "숨기기" : "펼치기"
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
            circle.textColor = self.orangeColor7
            subTitle.text = CommunityType.getCommunityName(.cook)().uppercased()
            
            // UITapGestureRecognizer 설정
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
            let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
            toggleBtn.addGestureRecognizer(tapGesture)
            toggleLabelHeader.addGestureRecognizer(tapGesture2)
            
            // title label 생성 및 설정
            if self.toggleDict[CommunityType.cook.rawValue]! {            let title = UILabel()
                title.font = UIFont.init(name: Constants.mainFontBold, size: 17)
                title.textColor = self.grayColor7
                title.textAlignment = .left
                title.text = CommunityType.getCommunityKoreanName(.cook)()
                title.addCharacterSpacing(kernValue: 1.5)
                headerUpperView.addSubview(title)
                title.snp.makeConstraints { (make) in
                    make.left.equalTo(headerUpperView).offset(20)
                    make.bottom.equalTo(headerUpperView).offset(-(10 + (Constants.sectionMargin) * 2))
                }
            }
        case CommunityType.ilbe.rawValue:
            circle.textColor = self.yellowColor7
            subTitle.text = CommunityType.getCommunityName(.ilbe)().uppercased()
            
            // UITapGestureRecognizer 설정
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
            let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
            toggleBtn.addGestureRecognizer(tapGesture)
            toggleLabelHeader.addGestureRecognizer(tapGesture2)
            
            // title label 생성 및 설정
            if self.toggleDict[CommunityType.ilbe.rawValue]! {            let title = UILabel()
                title.font = UIFont.init(name: Constants.mainFontBold, size: 17)
                title.textColor = self.grayColor7
                title.textAlignment = .left
                title.text = CommunityType.getCommunityKoreanName(.ilbe)()
                title.addCharacterSpacing(kernValue: 1.5)
                headerUpperView.addSubview(title)
                title.snp.makeConstraints { (make) in
                    make.left.equalTo(headerUpperView).offset(20)
                    make.bottom.equalTo(headerUpperView).offset(-(10 + (Constants.sectionMargin) * 2))
                }
            }
        case CommunityType.instiz.rawValue:
            circle.textColor = self.cyanColor7
            subTitle.text = CommunityType.getCommunityName(.instiz)().uppercased()
            
            // UITapGestureRecognizer 설정
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
            let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
            toggleBtn.addGestureRecognizer(tapGesture)
            toggleLabelHeader.addGestureRecognizer(tapGesture2)
            
            // title label 생성 및 설정
            if self.toggleDict[CommunityType.instiz.rawValue]! {          let title = UILabel()
                title.font = UIFont.init(name: Constants.mainFontBold, size: 17)
                title.textColor = self.grayColor7
                title.textAlignment = .left
                title.text = CommunityType.getCommunityKoreanName(.instiz)()
                title.addCharacterSpacing(kernValue: 1.5)
                headerUpperView.addSubview(title)
                title.snp.makeConstraints { (make) in
                    make.left.equalTo(headerUpperView).offset(20)
                    make.bottom.equalTo(headerUpperView).offset(-(10 + (Constants.sectionMargin) * 2))
                }
            }
        case CommunityType.ruliweb.rawValue:
            circle.textColor = self.subColor
            subTitle.text = CommunityType.getCommunityName(.ruliweb)().uppercased()
            
            // UITapGestureRecognizer 설정
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
            let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
            toggleBtn.addGestureRecognizer(tapGesture)
            toggleLabelHeader.addGestureRecognizer(tapGesture2)
            
            // title label 생성 및 설정
            if self.toggleDict[CommunityType.ruliweb.rawValue]! {         let title = UILabel()
                title.font = UIFont.init(name: Constants.mainFontBold, size: 17)
                title.textColor = self.grayColor7
                title.textAlignment = .left
                title.text = CommunityType.getCommunityKoreanName(.ruliweb)()
                title.addCharacterSpacing(kernValue: 1.5)
                headerUpperView.addSubview(title)
                title.snp.makeConstraints { (make) in
                    make.left.equalTo(headerUpperView).offset(20)
                    make.bottom.equalTo(headerUpperView).offset(-(10 + (Constants.sectionMargin) * 2))
                }
            }
        case CommunityType.clien.rawValue:
            circle.textColor = self.grapeColor7
            subTitle.text = CommunityType.getCommunityName(.clien)().uppercased()
            
            // UITapGestureRecognizer 설정
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
            let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
            toggleBtn.addGestureRecognizer(tapGesture)
            toggleLabelHeader.addGestureRecognizer(tapGesture2)
            
            // title label 생성 및 설정
            if self.toggleDict[CommunityType.clien.rawValue]! {           let title = UILabel()
                title.font = UIFont.init(name: Constants.mainFontBold, size: 17)
                title.textColor = self.grayColor7
                title.textAlignment = .left
                title.text = CommunityType.getCommunityKoreanName(.clien)()
                title.addCharacterSpacing(kernValue: 1.5)
                headerUpperView.addSubview(title)
                title.snp.makeConstraints { (make) in
                    make.left.equalTo(headerUpperView).offset(20)
                    make.bottom.equalTo(headerUpperView).offset(-(10 + (Constants.sectionMargin) * 2))
                }
            }
        case CommunityType.namu.rawValue:
            circle.textColor = self.limeColor7
            subTitle.text = CommunityType.getCommunityName(.namu)().uppercased()
            
            // UITapGestureRecognizer 설정
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
            let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
            toggleBtn.addGestureRecognizer(tapGesture)
            toggleLabelHeader.addGestureRecognizer(tapGesture2)
            
            // title label 생성 및 설정
            if self.toggleDict[CommunityType.namu.rawValue]! {            let title = UILabel()
                title.font = UIFont.init(name: Constants.mainFontBold, size: 17)
                title.textColor = self.grayColor7
                title.textAlignment = .left
                title.text = CommunityType.getCommunityKoreanName(.namu)()
                title.addCharacterSpacing(kernValue: 1.5)
                headerUpperView.addSubview(title)
                title.snp.makeConstraints { (make) in
                    make.left.equalTo(headerUpperView).offset(20)
                    make.bottom.equalTo(headerUpperView).offset(-(10 + (Constants.sectionMargin) * 2))
                }
            }
        case CommunityType.ppomppu.rawValue:
            circle.textColor = self.greenColor7
            subTitle.text = CommunityType.getCommunityName(.ppomppu)().uppercased()
            
            // UITapGestureRecognizer 설정
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
            let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
            toggleBtn.addGestureRecognizer(tapGesture)
            toggleLabelHeader.addGestureRecognizer(tapGesture2)
            
            // title label 생성 및 설정
            if self.toggleDict[CommunityType.ppomppu.rawValue]! {         let title = UILabel()
                title.font = UIFont.init(name: Constants.mainFontBold, size: 17)
                title.textColor = self.grayColor7
                title.textAlignment = .left
                title.text = CommunityType.getCommunityKoreanName(.ppomppu)()
                title.addCharacterSpacing(kernValue: 1.5)
                headerUpperView.addSubview(title)
                title.snp.makeConstraints { (make) in
                    make.left.equalTo(headerUpperView).offset(20)
                    make.bottom.equalTo(headerUpperView).offset(-(10 + (Constants.sectionMargin) * 2))
                }
            }
        case CommunityType.nate.rawValue:
            circle.textColor = self.pinkColor7
            subTitle.text = CommunityType.getCommunityName(.nate)().uppercased()
            
            // UITapGestureRecognizer 설정
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
            let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
            toggleBtn.addGestureRecognizer(tapGesture)
            toggleLabelHeader.addGestureRecognizer(tapGesture2)
            
            // title label 생성 및 설정
            if self.toggleDict[CommunityType.nate.rawValue]! {            let title = UILabel()
                title.font = UIFont.init(name: Constants.mainFontBold, size: 17)
                title.textColor = self.grayColor7
                title.textAlignment = .left
                title.text = CommunityType.getCommunityKoreanName(.nate)()
                title.addCharacterSpacing(kernValue: 1.5)
                headerUpperView.addSubview(title)
                title.snp.makeConstraints { (make) in
                    make.left.equalTo(headerUpperView).offset(20)
                    make.bottom.equalTo(headerUpperView).offset(-(10 + (Constants.sectionMargin) * 2))
                }
            }
        case CommunityType.fm.rawValue:
            circle.textColor = self.violetColor7
            subTitle.text = CommunityType.getCommunityName(.fm)().uppercased()
            
            // UITapGestureRecognizer 설정
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
            let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
            toggleBtn.addGestureRecognizer(tapGesture)
            toggleLabelHeader.addGestureRecognizer(tapGesture2)
            
            // title label 생성 및 설정
            if self.toggleDict[CommunityType.fm.rawValue]! {            let title = UILabel()
                title.font = UIFont.init(name: Constants.mainFontBold, size: 17)
                title.textColor = self.grayColor7
                title.textAlignment = .left
                title.text = CommunityType.getCommunityKoreanName(.fm)()
                title.addCharacterSpacing(kernValue: 1.5)
                headerUpperView.addSubview(title)
                title.snp.makeConstraints { (make) in
                    make.left.equalTo(headerUpperView).offset(20)
                    make.bottom.equalTo(headerUpperView).offset(-(10 + (Constants.sectionMargin) * 2))
                }
            }
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
        if section == CommunityType.clien.rawValue && !self.clienContents.isEmpty && self.toggleDict[CommunityType.clien.rawValue]! {
            // 접기/펼치기를 위한 버튼 생성
            footer.frame.size.width = self.tableView.frame.width
            let toggleView = UIView()
            let margin: CGFloat = 10
            let width = footer.frame.size.width - (margin * 2)
            toggleView.frame = CGRect(x: margin, y: 0, width: width, height: Constants.cellToggleBtnHeight)
            toggleView.backgroundColor = UIColor.white

            let lineView = UIView()
            lineView.backgroundColor = self.grayColor2
            toggleView.addSubview(lineView)
            lineView.snp.makeConstraints { (make) in
                make.left.equalTo(toggleView).offset(15)
                make.right.equalTo(toggleView).offset(-15)
                make.top.equalTo(toggleView)
                make.height.equalTo(1)
            }
            lineView.backgroundColor = self.grayColor2
            
            toggleView.addSubview(self.toggleLabelClian)
            
            self.toggleLabelClian.snp.makeConstraints{ (make) in
                make.centerX.equalTo(toggleView)
                make.top.equalTo(toggleView).offset(7.5)
                make.width.equalTo(Constants.cellToggleBtnWidth)
                make.height.equalTo(Constants.cellToggleBtnHeight - 15)
            }
            self.toggleLabelClian.tag = section
            
            footer.addSubview(toggleView)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleCell(_:)))
            self.toggleLabelClian.addGestureRecognizer(tapGesture)
        } else if section == CommunityType.fm.rawValue && !self.fmContents.isEmpty && self.toggleDict[CommunityType.fm.rawValue]! {
            
            // 접기/펼치기를 위한 버튼 생성
            footer.frame.size.width = self.tableView.frame.width
            let toggleView = UIView()
            let margin: CGFloat = 10
            let width = footer.frame.size.width - (margin * 2)
            toggleView.frame = CGRect(x: margin, y: 0, width: width, height: Constants.cellToggleBtnHeight)
            toggleView.backgroundColor = UIColor.white

            let lineView = UIView()
            lineView.backgroundColor = self.grayColor2
            toggleView.addSubview(lineView)
            lineView.snp.makeConstraints { (make) in
                make.left.equalTo(toggleView).offset(15)
                make.right.equalTo(toggleView).offset(-15)
                make.top.equalTo(toggleView)
                make.height.equalTo(1)
            }
            lineView.backgroundColor = self.grayColor2
            
            toggleView.addSubview(self.toggleLabelFm)
            toggleLabelFm.snp.makeConstraints{ (make) in
                make.centerX.equalTo(toggleView)
                make.top.equalTo(toggleView).offset(7.5)
                make.width.equalTo(Constants.cellToggleBtnWidth)
                make.height.equalTo(Constants.cellToggleBtnHeight - 15)
            }
            
            self.toggleLabelFm.tag = section
            footer.addSubview(toggleView)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleCell(_:)))
            self.toggleLabelFm.addGestureRecognizer(tapGesture)
        } else {
           
        }
        footer.backgroundColor = self.grayColor1
        
        return footer
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionHeight: CGFloat = Constants.sectionHeight
        if section == CommunityType.upperInfo.rawValue {
            return CGFloat.leastNonzeroMagnitude
        } else {
            if self.toggleDict[section]! {
                return sectionHeight
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
            if toggleDict[section] == false {
                return CGFloat.leastNonzeroMagnitude
            } else {
                if section == CommunityType.clien.rawValue && !self.clienContents.isEmpty {
                    return sectionHeight + Constants.cellToggleBtnHeight
                } else if section == CommunityType.fm.rawValue && !self.fmContents.isEmpty {
                    return sectionHeight + Constants.cellToggleBtnHeight
                }
                else {
                    return sectionHeight
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == CommunityType.upperInfo.rawValue {
            return self.imgHeight
        } else {
            if toggleDict[indexPath.section] == false {
                return 0
            } else {
                return Constants.cellHeight
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
        
        if toggleDict[tag]! {
            toggleDict[tag] = false
        } else {
            toggleDict[tag] = true
        }

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
            }
        self.tableView.endUpdates()
    }
                
    // 구글 애드몹 배너 설정 메소드
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(bannerView)
//        self.view.bringSubviewToFront(bannerView)
        self.view.insertSubview(bannerView, at: self.view.subviews.count)
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
