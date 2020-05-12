//
//  MainVC.swift
//  catchup
//
//  Created by PJW on 2019/12/09.
//  Copyright © 2019 PJW. All rights reserved.
//

import UIKit
import Kanna
import Alamofire
import SnapKit
import Firebase
import SafariServices
import GoogleMobileAds

public enum NaverType: Int {
    case upperInfo
    case lowerInfo
    case naverKeyword
    case twitter
    case naverMainNews
    case naverEnterNews
    case naverSportNews
    // enum의 count를 위한 case - 항상 제일 마지막에 위치해야 함
    case count
    
    func getNaverName() -> String {
        switch self {
        case .upperInfo:
            return ""
        case .lowerInfo:
            return ""
        case .naverKeyword:
            return "실시간 검색어"
        case .twitter:
            return ""
        case .naverMainNews:
            return "주요 뉴스"
        case .naverEnterNews:
            return "연예 뉴스"
        case .naverSportNews:
            return "스포츠 뉴스"
        case .count:
            return ""
        }
    }
}

class MainVC: UITableViewController {
    
    var keywordLabel01Num: UILabel!
    var keywordLabel01Title: UILabel!
    var keywordLabel02Num: UILabel!
    var keywordLabel02Title: UILabel!
    var keywordLabel03Num: UILabel!
    var keywordLabel03Title: UILabel!
    var keywordLabel04Num: UILabel!
    var keywordLabel04Title: UILabel!
    var keywordLabel05Num: UILabel!
    var keywordLabel05Title: UILabel!
    var keywordLabel06Num: UILabel!
    var keywordLabel06Title: UILabel!
    var keywordLabel07Num: UILabel!
    var keywordLabel07Title: UILabel!
    var keywordLabel08Num: UILabel!
    var keywordLabel08Title: UILabel!
    var keywordLabel09Num: UILabel!
    var keywordLabel09Title: UILabel!
    var keywordLabel10Num: UILabel!
    var keywordLabel10Title: UILabel!
    
    var keywordLabel01_2Num: UILabel!
    var keywordLabel01_2Title: UILabel!
    var keywordLabel02_2Num: UILabel!
    var keywordLabel02_2Title: UILabel!
    var keywordLabel03_2Num: UILabel!
    var keywordLabel03_2Title: UILabel!
    var keywordLabel04_2Num: UILabel!
    var keywordLabel04_2Title: UILabel!
    var keywordLabel05_2Num: UILabel!
    var keywordLabel05_2Title: UILabel!
    var keywordLabel06_2Num: UILabel!
    var keywordLabel06_2Title: UILabel!
    var keywordLabel07_2Num: UILabel!
    var keywordLabel07_2Title: UILabel!
    var keywordLabel08_2Num: UILabel!
    var keywordLabel08_2Title: UILabel!
    var keywordLabel09_2Num: UILabel!
    var keywordLabel09_2Title: UILabel!
    var keywordLabel10_2Num: UILabel!
    var keywordLabel10_2Title: UILabel!
    
    var keywordLabelsTitle: Array<UILabel> = []
    var keywordLabelsNum: Array<UILabel> = []
    
    lazy var naverKeyword: [(keyword: String, url: String)] = {
        var list = Array.init(repeating: ("", "https://www.naver.com"), count: 20)
        return list
    }()
    
    lazy var naverMainNews: [(title: String, url: String, idx: Int)] = {
        var list = [(String, String, Int)]()
        return list
    }()
    
    lazy var naverEnterNews: [(title: String, url: String, idx: Int)] = {
        var list = [(String, String, Int)]()
        return list
    }()
    
    lazy var naverSportsNews: [(title: String, url: String, idx: Int)] = {
        var list = [(String, String, Int)]()
        return list
    }()
    
    // 구글 애드몹 배너 객체 선언
    var bannerView: GADBannerView!
    
    let twitterList = [[(title: "하객룩", colorIdx: 0), (title: "바캉스립", colorIdx: 1), (title: "파우치", colorIdx: 0)], [(title: "귀여운", colorIdx: 2), (title: "지속력갑", colorIdx: 0), (title: "세젤템", colorIdx: 3)], [(title: "여름휴가", colorIdx: 0), (title: "우울할때", colorIdx: 4), (title: "쿨톤인생립", colorIdx: 0)], [(title: "데일리립스틱", colorIdx: 0), (title: "립픽서", colorIdx: 0)], [(title: "에뛰드하우스신상", colorIdx: 5), (title: "입생로랑", colorIdx: 0)]]
    
    // twitter color list
    var twitterColorListR = Constants.twitterColorListRed
    var twitterColorListG = Constants.twitterColorListGreen
    var twitterColorListB = Constants.twitterColorListBlue
    
    // twitter color view
    var twitterColorRView: UIView!
    var twitterColorGView: UIView!
    var twitterColorBView: UIView!
    
    // twitter color button
    var twitterColorRBtn: UIButton!
    var twitterColorGBtn: UIButton!
    var twitterColorBBtn: UIButton!
    
    // twitter color 선택 정보 변수
    var twitterSelectedColor = 0
    
    // twitter button 크기 변수
    let twitterViewSize: CGFloat = 40
    let twitterInnerMargin: CGFloat = 4

    // twitter color slide
    var twitterColorSlide: UIView!
    var twitterButtonSlide: UIView!
    var twitterColorOpenBtn: UIButton!
    var twitterColorCloseBtn: UIButton!
    
    var isSlideShowing = false
    let slideHeightMargin: CGFloat = 25
    let slideTime = 0.3

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네트워크 연결 확인
        network.reachability.whenUnreachable = { reachability in
            self.checkNetwork()
        }
        
        // 폰트 이름 찾기 위한 임시 프로세스
//        for familyName in UIFont.familyNames {
//            print("========\(familyName)===========")
//            for fontName in UIFont.fontNames(forFamilyName: familyName) {
//                 print(fontName)
//            }
//        }
        
        // 순번 및 검색어를 위한 label 생성
        self.keywordLabel01Num = UILabel()
        self.keywordLabel01Title = UILabel()
        self.keywordLabel02Num = UILabel()
        self.keywordLabel02Title = UILabel()
        self.keywordLabel03Num = UILabel()
        self.keywordLabel03Title = UILabel()
        self.keywordLabel04Num = UILabel()
        self.keywordLabel04Title = UILabel()
        self.keywordLabel05Num = UILabel()
        self.keywordLabel05Title = UILabel()
        self.keywordLabel06Num = UILabel()
        self.keywordLabel06Title = UILabel()
        self.keywordLabel07Num = UILabel()
        self.keywordLabel07Title = UILabel()
        self.keywordLabel08Num = UILabel()
        self.keywordLabel08Title = UILabel()
        self.keywordLabel09Num = UILabel()
        self.keywordLabel09Title = UILabel()
        self.keywordLabel10Num = UILabel()
        self.keywordLabel10Title = UILabel()
        
        self.keywordLabel01_2Num = UILabel()
        self.keywordLabel01_2Title = UILabel()
        self.keywordLabel02_2Num = UILabel()
        self.keywordLabel02_2Title = UILabel()
        self.keywordLabel03_2Num = UILabel()
        self.keywordLabel03_2Title = UILabel()
        self.keywordLabel04_2Num = UILabel()
        self.keywordLabel04_2Title = UILabel()
        self.keywordLabel05_2Num = UILabel()
        self.keywordLabel05_2Title = UILabel()
        self.keywordLabel06_2Num = UILabel()
        self.keywordLabel06_2Title = UILabel()
        self.keywordLabel07_2Num = UILabel()
        self.keywordLabel07_2Title = UILabel()
        self.keywordLabel08_2Num = UILabel()
        self.keywordLabel08_2Title = UILabel()
        self.keywordLabel09_2Num = UILabel()
        self.keywordLabel09_2Title = UILabel()
        self.keywordLabel10_2Num = UILabel()
        self.keywordLabel10_2Title = UILabel()
        
        self.keywordLabelsTitle = [
            self.keywordLabel01Title, self.keywordLabel02Title,
            self.keywordLabel03Title, self.keywordLabel04Title,
            self.keywordLabel05Title, self.keywordLabel06Title,
            self.keywordLabel07Title, self.keywordLabel08Title,
            self.keywordLabel09Title, self.keywordLabel10Title,
            self.keywordLabel01_2Title, self.keywordLabel02_2Title,
            self.keywordLabel03_2Title, self.keywordLabel04_2Title,
            self.keywordLabel05_2Title, self.keywordLabel06_2Title,
            self.keywordLabel07_2Title, self.keywordLabel08_2Title,
            self.keywordLabel09_2Title, self.keywordLabel10_2Title,
        ]
        
        self.keywordLabelsNum = [
            self.keywordLabel01Num, self.keywordLabel02Num,
            self.keywordLabel03Num, self.keywordLabel04Num,
            self.keywordLabel05Num, self.keywordLabel06Num,
            self.keywordLabel07Num, self.keywordLabel08Num,
            self.keywordLabel09Num, self.keywordLabel10Num,
            self.keywordLabel01_2Num, self.keywordLabel02_2Num,
            self.keywordLabel03_2Num, self.keywordLabel04_2Num,
            self.keywordLabel05_2Num, self.keywordLabel06_2Num,
            self.keywordLabel07_2Num, self.keywordLabel08_2Num,
            self.keywordLabel09_2Num, self.keywordLabel10_2Num,
        ]
        
        self.getContents()
        
        // 당겨서 새로고침
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.tintColor = mainColor
        
        let attributes = [NSAttributedString.Key.foregroundColor: mainColor]
        self.refreshControl?.attributedTitle = NSAttributedString(string: "페이지 새로고침 중", attributes: attributes)
        
        self.refreshControl?.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
        
        // 테이블뷰의 셀 별 라인 제거
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        // twitter color view, button 생성 및 설정
        self.twitterColorRView = UIView()
        self.twitterColorGView = UIView()
        self.twitterColorBView = UIView()
        self.twitterColorRBtn = UIButton(type: .custom)
        self.twitterColorGBtn = UIButton(type: .custom)
        self.twitterColorBBtn = UIButton(type: .custom)
        
        self.setTwitterColorBtn(view: self.twitterColorRView, btn: self.twitterColorRBtn, color1: self.twitterColorListR[0], color2: self.twitterColorListR[1], tag: 0)
        self.setTwitterColorBtn(view: self.twitterColorGView, btn: self.twitterColorGBtn, color1: self.twitterColorListG[1], color2: self.twitterColorListG[4], tag: 1)
        self.setTwitterColorBtn(view: self.twitterColorBView, btn: self.twitterColorBBtn, color1: self.twitterColorListB[0], color2: self.twitterColorListB[3], tag: 2)
        
        // twitter color slide 생성 및 초기화
        self.twitterColorSlide = UIView()
        self.twitterButtonSlide = UIView()
        
        self.twitterColorSlide.backgroundColor = UIColor.white
        self.twitterButtonSlide.backgroundColor = UIColor.white
        
        self.twitterColorOpenBtn = UIButton(type: .custom)
        self.twitterColorCloseBtn = UIButton(type: .custom)

        self.twitterColorOpenBtn.setTitle("OPEN", for: .normal)
        self.twitterColorCloseBtn.setTitle("CLOSE", for: .normal)
        self.twitterColorOpenBtn.setTitleColor(UIColor.black, for: .normal)
        self.twitterColorCloseBtn.setTitleColor(UIColor.black, for: .normal)
        self.twitterColorOpenBtn.addTarget(self, action: #selector(clickColorOpen(_:)), for: .touchUpInside)
        self.twitterColorCloseBtn.addTarget(self, action: #selector(clickColorClose(_:)), for: .touchUpInside)
        
        // 구글 애드몹 달기
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        self.addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    // 앱이 foreground에 왔을 때 실행할 코드 입력
    override func viewWillAppear(_ animated: Bool){
        
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification
        , object: nil)
//        print("main height will appear: \(self.view.frame.size.height)")
//        self.keywordStar.rotate()
    }
    
    override func viewWillLayoutSubviews() {
        // custom header, tabbar의 높이만큼 rootview 위치 및 높이 조정
        let screen = UIScreen.main.bounds
        let margin = Constants.csTabbarHeight + self.upperHeight
        self.view.frame.origin.y = margin
        self.view.frame.size.height = screen.size.height - margin
    }
    
    @objc func willEnterForeground() {
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return NaverType.count.rawValue
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case NaverType.upperInfo.rawValue:
            return 1
        case NaverType.lowerInfo.rawValue:
            return 1
        case NaverType.naverKeyword.rawValue:
            return 1
        case NaverType.twitter.rawValue:
            return 5
        case NaverType.naverMainNews.rawValue:
            return self.naverMainNews.count
        case NaverType.naverEnterNews.rawValue:
            return self.naverEnterNews.count
        case NaverType.naverSportNews.rawValue:
            return self.naverSportsNews.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == NaverType.upperInfo.rawValue {
            let cell = UITableViewCell()
            
            let height = Constants.imgHeight
            
            // cell 설정
            cell.contentView.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: height)
            
            let imgView = UIImageView()
            let mainLabel = UILabel()
            let subLabel = UILabel()

            let mainImage = self.resizeImage(image: UIImage(named: "main_b")!, toTheSize: CGSize(width: self.view.frame.width, height: height))
            
            imgView.frame = CGRect(x: 0, y: 0, width: cell.contentView.frame.width, height: height)
            imgView.image = mainImage
            imgView.contentMode = .scaleAspectFill
            cell.contentView.addSubview(imgView)

            mainLabel.font = UIFont.init(name: Constants.mainFontBold, size: 24)
            mainLabel.textColor = UIColor.white
            mainLabel.text = "실시간 검색어/뉴스"
            cell.contentView.addSubview(mainLabel)
            mainLabel.snp.makeConstraints{(make) in
                make.left.equalTo(cell.contentView).offset(20)
                make.bottom.equalTo(cell.contentView).offset(-40)
            }
            
            subLabel.font = UIFont.init(name: Constants.mainFont, size: 14)
            subLabel.textColor = UIColor.white
            subLabel.text = "#키워드 #뉴스 #연예 #스포츠"
            cell.contentView.addSubview(subLabel)
            subLabel.snp.makeConstraints{(make) in
                make.left.equalTo(cell.contentView).offset(20)
                make.bottom.equalTo(cell.contentView).offset(-15)
            }
            
            return cell
            
        } else if indexPath.section == NaverType.lowerInfo.rawValue {
            let cell = UITableViewCell()

            // InfoCell 초기화
            let infoView = UIView()
            let infoLabel = UILabel()
            let container = UIView()
            let leftView = UIView()
            let centerView = UIView()
            let centerNView = UIView()
            let rightView = UIView()
            let leftImageView = UIImageView()
            let centerImageView = UIImageView()
            let centerNImageView = UIImageView()
            let rightImageView = UIImageView()
            let leftLabel = UILabel()
            let centerLabel = UILabel()
            let centerNLabel = UILabel()
            let rightLabel = UILabel()

            let outerMargin: CGFloat = 10
            let imageSize: CGFloat = 40

            let viewWidth = (self.tableView.frame.width - (outerMargin * 2)) / 4
            let viewHeight = Constants.infoHeight

            // view 기본 설정
            infoView.frame = CGRect(x: outerMargin, y: 0, width: self.tableView.frame.width - (outerMargin * 2), height: Constants.infoUpperHeight)
            container.frame = CGRect(x: outerMargin, y: Constants.infoUpperHeight, width: self.tableView.frame.width - (outerMargin * 2), height: viewHeight)
            leftView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
            centerView.frame = CGRect(x: viewWidth, y: 0, width: viewWidth, height: viewHeight)
            centerNView.frame = CGRect(x: (viewWidth * 2), y: 0, width: viewWidth, height: viewHeight)
            rightView.frame = CGRect(x: (viewWidth * 3), y: 0, width: viewWidth, height: viewHeight)

            // container view에 아래 설정
            container.layer.addBorder([.top], color: self.grayColor4, width: 2)
            container.layer.addBorder([.bottom], color: self.grayColor4, width: 1)

            // icon 이미지 설정
            let weatherImage = self.resizeImage(image: UIImage(named: "iconWeather")!, toTheSize: CGSize(width: imageSize, height: imageSize))

            // info 라벨 설정
            infoLabel.font = UIFont.init(name: Constants.mainFontBold, size: 18)
            infoLabel.textColor = self.grayColor7
            infoLabel.textAlignment = .left
            infoLabel.text = "무료 운세"

            // 아이콘 라벨 설정
            leftLabel.font = UIFont.init(name: Constants.mainFont, size: 12)
            centerLabel.font = UIFont.init(name: Constants.mainFont, size: 12)
            centerNLabel.font = UIFont.init(name: Constants.mainFont, size: 12)
            rightLabel.font = UIFont.init(name: Constants.mainFont, size: 12)

            leftLabel.textColor = self.grayColor6
            centerLabel.textColor = self.grayColor6
            centerNLabel.textColor = self.grayColor6
            rightLabel.textColor = self.grayColor6

            leftLabel.textAlignment = .center
            centerLabel.textAlignment = .center
            centerNLabel.textAlignment = .center
            rightLabel.textAlignment = .center

            leftLabel.text = "별자리운세"
            centerLabel.text = "띠별운세"
            centerNLabel.text = "타로"
            rightLabel.text = "기타"

            // 아이콘 이미지 설정
            leftImageView.image = weatherImage
            centerImageView.image = weatherImage
            centerNImageView.image = weatherImage
            rightImageView.image = weatherImage
            leftImageView.contentMode = .scaleAspectFit
            centerImageView.contentMode = .scaleAspectFit
            centerNImageView.contentMode = .scaleAspectFit
            rightImageView.contentMode = .scaleAspectFit

            leftView.addSubview(leftImageView)
            centerView.addSubview(centerImageView)
            centerNView.addSubview(centerNImageView)
            rightView.addSubview(rightImageView)
            leftView.addSubview(leftLabel)
            centerView.addSubview(centerLabel)
            centerNView.addSubview(centerNLabel)
            rightView.addSubview(rightLabel)

            infoView.addSubview(infoLabel)
            container.addSubview(leftView)
            container.addSubview(centerView)
            container.addSubview(centerNView)
            container.addSubview(rightView)

            cell.contentView.addSubview(infoView)
            cell.contentView.addSubview(container)

            // info 라벨 위치 설정
            infoLabel.snp.makeConstraints { (make) in
                make.top.equalTo(infoView)
                make.left.equalTo(infoView).offset(5)
            }

            // 이미지 위치 설정
            leftImageView.snp.makeConstraints { (make) in
                make.centerX.equalTo(leftView)
                make.top.equalTo(leftView).offset(20)
                make.width.equalTo(imageSize)
                make.height.equalTo(imageSize)
            }
            centerImageView.snp.makeConstraints { (make) in
                make.centerX.equalTo(centerView)
                make.top.equalTo(centerView).offset(20)
                make.width.equalTo(imageSize)
                make.height.equalTo(imageSize)
            }
            centerNImageView.snp.makeConstraints { (make) in
                make.centerX.equalTo(centerNView)
                make.top.equalTo(centerNView).offset(20)
                make.width.equalTo(imageSize)
                make.height.equalTo(imageSize)
            }
            rightImageView.snp.makeConstraints { (make) in
                make.centerX.equalTo(rightView)
                make.top.equalTo(rightView).offset(20)
                make.width.equalTo(imageSize)
                make.height.equalTo(imageSize)
            }

            // 라벨 위치 설정
            leftLabel.snp.makeConstraints { (make) in
                make.centerX.equalTo(leftView)
                make.top.equalTo(leftImageView.snp.bottom).offset(5)
            }
            centerLabel.snp.makeConstraints { (make) in
                make.centerX.equalTo(centerView)
                make.top.equalTo(centerImageView.snp.bottom).offset(5)
            }
            centerNLabel.snp.makeConstraints { (make) in
                make.centerX.equalTo(centerNView)
                make.top.equalTo(centerNImageView.snp.bottom).offset(5)
            }
            rightLabel.snp.makeConstraints { (make) in
                make.centerX.equalTo(rightView)
                make.top.equalTo(rightImageView.snp.bottom).offset(5)
            }
            
            return cell
            
        } else if indexPath.section == NaverType.twitter.rawValue {
            let cell = UITableViewCell()
            
            // 각 행의 데이터
            let dataList = self.twitterList[indexPath.row]
            
            // 라벨 간 margin 값
            let innerMargin: CGFloat = 20
            
            let textContainer = UIView()
            
            // 라벨 생성 및 초기화
            let textLabel1 = UILabelPadding()
            let textLabel2 = UILabelPadding()
            let textLabel3 = UILabelPadding()
            
            // 라벨 배열에 담기
            let textLabelList:  Array<UILabelPadding> = [textLabel1, textLabel2, textLabel3]
            
            var twitterColorList: Array<UIColor>
            
            switch self.twitterSelectedColor {
                case 0:
                    twitterColorList = self.twitterColorListR
                case 1:
                    twitterColorList = self.twitterColorListG
                case 2:
                    twitterColorList = self.twitterColorListB
                default:
                    twitterColorList = self.twitterColorListR
            }
            
            textLabel1.text = ""
            textLabel2.text = ""
            textLabel3.text = ""
            
            var textContainerWidth: CGFloat = 0
            
            for idx in 0..<dataList.count {
                
                textLabelList[idx].text = "#\(dataList[idx].title)"
                textLabelList[idx].contentMode = .center
                textLabelList[idx].font = UIFont.init(name: Constants.mainFont, size: 13)
                
                if dataList[idx].colorIdx > 0 {
                    textLabelList[idx].textColor = UIColor.white
                    textLabelList[idx].backgroundColor = twitterColorList[dataList[idx].colorIdx - 1]
                } else {
                    textLabelList[idx].textColor = self.grayColor7
                    textLabelList[idx].layer.borderWidth = 1
                    textLabelList[idx].layer.borderColor = self.grayColor4.cgColor
                }
                
                textContainerWidth += textLabelList[idx].intrinsicContentSize.width
                    textContainer.addSubview(textLabelList[idx])
                
                textLabelList[idx].layer.cornerRadius = textLabelList[idx].intrinsicContentSize.height / 2
                textLabelList[idx].layer.masksToBounds = true
                textContainer.addSubview(textLabelList[idx])
            }
            
            cell.contentView.addSubview(textContainer)
            textContainer.snp.makeConstraints{ (make) in
                make.center.equalTo(cell.contentView)
                if dataList.count == 2 {
                    make.width.equalTo(textContainerWidth + innerMargin)
                } else if dataList.count == 3 {
                    make.width.equalTo(textContainerWidth + (innerMargin * 2))
                }
                make.height.equalTo(Constants.cellHeight)
            }
            
            for idx in 0..<dataList.count  {
                textLabelList[idx].snp.makeConstraints{ (make) in
                    make.centerY.equalTo(cell.contentView)
                    
                    if idx == 0 {
                        make.left.equalTo(textContainer.snp.left)
                    } else if dataList.count == 2 && idx == 1  {
                        make.right.equalTo(textContainer.snp.right)
                    } else if dataList.count == 3 && idx == 1  {
                        make.left.equalTo(textLabelList[0].snp.right).offset(innerMargin)
                    } else if dataList.count == 3 && idx == 2 {
                        make.left.equalTo(textLabelList[1].snp.right).offset(innerMargin)
                    }
                }
            }
 
            return cell
            
        } else if indexPath.section == NaverType.naverKeyword.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "keyword_cell") as! KeywordCell
            
            // contentview 설정
            cell.contentView.backgroundColor = UIColor.white
            cell.contentView.frame.size.height = Constants.keywordAreaHeight
            
            // scrollview 설정
            let scrollViewWidth = self.tableView.frame.width - 20
            cell.scrollView.showsHorizontalScrollIndicator = false
            cell.scrollView.showsVerticalScrollIndicator = false
            
            cell.scrollView.isPagingEnabled = true
            cell.scrollView.frame.size.width = scrollViewWidth
            cell.scrollView.contentSize = CGSize(width: CGFloat(cell.pageSize) * scrollViewWidth, height: cell.contentView.frame.height - 20)
            cell.scrollView.frame.origin = CGPoint(x: 10, y: 0)
            cell.scrollView.frame.size = CGSize(width: scrollViewWidth, height: cell.contentView.frame.height - 20)
            
            cell.scrollView.layer.borderColor = self.grayColor4.cgColor
            cell.scrollView.layer.borderWidth = 1
            
            // pageControll 설정
            cell.pageControll.numberOfPages = 2
            cell.pageControll.currentPage = 0
            cell.pageControll.isUserInteractionEnabled = false
            cell.pageControll.pageIndicatorTintColor = self.grayColor4
            cell.pageControll.currentPageIndicatorTintColor = self.grayColor6
            cell.pageControll.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            
            // keywordContentView 설정
            let pageWidth = self.tableView.frame.width - 20
            let pageHeight = cell.contentView.frame.height - 20

            cell.keywordContentView1.frame = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)

            cell.keywordContentView2.frame = CGRect(x: pageWidth, y: 0, width: pageWidth, height: pageHeight)

            cell.scrollView.addSubview(cell.keywordContentView1)
            cell.scrollView.addSubview(cell.keywordContentView2)
            cell.contentView.addSubview(cell.pageControll)
            cell.pageControll.snp.makeConstraints{ (make) in
                make.bottom.equalTo(cell.contentView).offset(14)
            }
            
            // keywordLabel 설정
            for idx in 0...19 {
                let tag = idx < 10 ? idx + 1 : idx - 9
                let superView = (idx < 10 ? cell.keywordContentView1 : cell.keywordContentView2)!
                
                cell.cellKeywordViews[idx].tag = tag
                cell.setKeywordView(view: cell.cellKeywordViews[idx], superView: superView)
            }
            
            // 순번 및 검색어를 위한 label 설정
            for idx in 0...19 {
                let labelNum = self.keywordLabelsNum[idx]
                let labelTitle = self.keywordLabelsTitle[idx]
                
                 // keyword 클릭 이벤트를 감지하는 recognizer 생성 및 설정
                let gesture = KeywordGestureRecognizer(target: self, action: #selector(clickKeyword(_:)))
                gesture.index = idx
                gesture.minimumPressDuration = 0.1
                labelTitle.isUserInteractionEnabled = true
                labelTitle.addGestureRecognizer(gesture)

                let tag = idx < 10 ? cell.cellKeywordViews[idx].tag : cell.cellKeywordViews[idx].tag + 10
                
                // label 속성 설정
                labelNum.textAlignment = .left
                labelNum.textColor = self.grayColor5
                labelNum.font = UIFont.init(name: Constants.mainFontBold, size: 12)

                labelTitle.textAlignment = .left
                labelTitle.font = idx == 0 ? UIFont.init(name: Constants.mainFont, size: 14) : UIFont.init(name: Constants.mainFont, size: 12)
                labelTitle.textColor = idx == 0 ? UIColor.black : self.grayColor9
                
                labelTitle.lineBreakMode = .byTruncatingTail
                
               cell.setKeywordLabels(cell.cellKeywordViews[idx], labelNum, labelTitle)
                
                labelNum.text = String(tag)
            }
            return cell
        } else {
            var data: (title: String, url: String, idx: Int)!
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "article_cell") as! ArticleCell
            cell.labelNum.font = UIFont.init(name: Constants.mainFontBold, size: 13)
            cell.labelNum.textColor = self.grayColor5
            
            cell.labelText.font = UIFont.init(name: Constants.mainFont, size: 13)
            cell.labelText.textColor = self.grayColor9
            cell.contentView.backgroundColor = UIColor.white
            
            switch indexPath.section {
            case NaverType.naverMainNews.rawValue:
                data = self.naverMainNews[indexPath.row]
            case NaverType.naverEnterNews.rawValue:
                data = self.naverEnterNews[indexPath.row]
            case NaverType.naverSportNews.rawValue:
                data = self.naverSportsNews[indexPath.row]
            default:
                ()
            }
        
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
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == NaverType.upperInfo.rawValue || indexPath.section == NaverType.lowerInfo.rawValue || indexPath.section == NaverType.twitter.rawValue {
            return nil
        } else {
            return indexPath
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var log = ""
        var url = "https://www.google.com"
        
        switch indexPath.section {
        case NaverType.naverKeyword.rawValue:
            return
        case NaverType.naverMainNews.rawValue:
            url = self.naverMainNews[indexPath.row].url
            log = NaverType.getNaverName(.naverMainNews)()
        case NaverType.naverEnterNews.rawValue:
            url = self.naverEnterNews[indexPath.row].url
            log = NaverType.getNaverName(.naverEnterNews)()
        case NaverType.naverSportNews.rawValue:
            url = self.naverSportsNews[indexPath.row].url
            log = NaverType.getNaverName(.naverSportNews)()
        default:
            ()
        }
        // safariViewController 생성 및 설정
        let config = SFSafariViewController.Configuration()
        config.barCollapsingEnabled = false
        let safariViewController = SFSafariViewController(url: URL(string: url)!, configuration: config)
        safariViewController.dismissButtonStyle = .close
        
        self.navigationController?.present(safariViewController, animated: true, completion: nil)
        
        Analytics.logEvent("article_click", parameters: ["section" : log])
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: Constants.sectionHeight))
        
        headerView.backgroundColor = UIColor.white
        
        // header의 상위 margin view 설정
        let headerUpperMarginView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: Constants.sectionMargin))
        headerUpperMarginView.backgroundColor = UIColor.white
        
        // header의 main view 설정
        let headerUpperView = UIView()
        
        if section == NaverType.naverKeyword.rawValue {headerUpperView.frame = CGRect(x: Constants.sectionMargin, y: Constants.sectionMargin, width: self.view.frame.width - (Constants.sectionMargin * 2), height: Constants.sectionHeight - Constants.sectionMargin - 35)
            
        } else {
            headerUpperView.frame = CGRect(x: Constants.sectionMargin, y: Constants.sectionMargin, width: self.view.frame.width - (Constants.sectionMargin * 2), height: Constants.sectionHeight - Constants.sectionMargin)
        }
        
        headerUpperView.backgroundColor = UIColor.white
        
//        headerUpperView.layer.borderColor = UIColor.green.cgColor
//        headerUpperView.layer.borderWidth = 1
        
        let subTitle = UILabel()
        subTitle.textColor = self.grayColor5
        subTitle.font = UIFont.init(name: Constants.mainFontBold, size: 12)
        subTitle.textAlignment = .left
        
        // keyword section을 위한 label
        let rightSubTitle = UILabel()
        
        let common = UILabel()
        common.font = UIFont.init(name: Constants.mainFontBold, size: 18)
        common.textColor = self.grayColor7
        common.textAlignment = .left
        common.text = "네이버"
        
        let title = UILabel()
        title.font = UIFont.init(name: Constants.mainFontBold, size: 18)
        title.textAlignment = .left
        title.textColor = self.grayColor7
        
        let headerImageView = UIImageView()
        let imageMargin: CGFloat = 5
        let imageSizeMargin: CGFloat = 12
        
        headerImageView.contentMode = .scaleAspectFill
        headerImageView.frame = CGRect(x: imageMargin * 2, y: 0, width: Constants.sectionHeight - (imageSizeMargin * 2), height: Constants.sectionHeight - (imageSizeMargin * 2))
        headerImageView.layer.cornerRadius = headerImageView.frame.height / 2
        headerImageView.clipsToBounds = true
        
        switch section {
        case NaverType.naverKeyword.rawValue:
            headerUpperView.backgroundColor = UIColor.clear
            title.text = NaverType.getNaverName(.naverKeyword)()
            
            rightSubTitle.font = UIFont.init(name: Constants.mainFontBold, size: 12)
            rightSubTitle.textColor = self.grayColor5
            
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "H시 m분 기준"
            let dateString = dateFormatter.string(from: date)
            rightSubTitle.text = dateString
        
        case NaverType.twitter.rawValue:
            title.text = "트위터 트렌드"
            
            self.twitterButtonSlide.frame = CGRect(x: 0, y: self.slideHeightMargin, width: self.view.frame.width - (Constants.sectionMargin * 2), height: Constants.sectionHeight - Constants.sectionMargin - self.slideHeightMargin)

            self.twitterColorSlide.frame = self.isSlideShowing ? CGRect(x: 0, y: self.slideHeightMargin, width: self.view.frame.width - (Constants.sectionMargin * 2), height: Constants.sectionHeight - Constants.sectionMargin - self.slideHeightMargin) : CGRect(x: self.view.frame.width - (Constants.sectionMargin * 2), y: self.slideHeightMargin, width: self.view.frame.width - (Constants.sectionMargin * 2), height: Constants.sectionHeight - Constants.sectionMargin - self.slideHeightMargin)
                
            self.twitterButtonSlide.addSubview(self.twitterColorOpenBtn)
            self.twitterColorSlide.addSubview(self.twitterColorCloseBtn)
            self.twitterColorSlide.addSubview(self.twitterColorRView)
            self.twitterColorSlide.addSubview(self.twitterColorGView)
            self.twitterColorSlide.addSubview(self.twitterColorBView)
            
//            self.twitterButtonSlide.layer.borderWidth = 1
//            self.twitterColorSlide.layer.borderWidth = 1
//            self.twitterButtonSlide.layer.borderColor = UIColor.red.cgColor
//            self.twitterColorSlide.layer.borderColor = UIColor.black.cgColor
            
        case NaverType.naverMainNews.rawValue:
            title.text = NaverType.getNaverName(.naverMainNews)()
            subTitle.text = "MAIN NEWS"
            
            headerImageView.image = UIImage(named: "iconNews")
        case NaverType.naverEnterNews.rawValue:
            title.text = NaverType.getNaverName(.naverEnterNews)()
            subTitle.text = "ENTERTAINMENT"
            
            headerImageView.image = UIImage(named: "iconEnter")
        case NaverType.naverSportNews.rawValue:
            title.text = NaverType.getNaverName(.naverSportNews)()
            subTitle.text = "SPORTS"
            
            headerImageView.image = UIImage(named: "iconSports")
        default:
            ()
        }
        
        // subTitle view에 letter-spaing 설정
        subTitle.addCharacterSpacing(kernValue: 1.5)
        
        if section == NaverType.naverKeyword.rawValue {
            headerUpperView.addSubview(common)
            headerUpperView.addSubview(rightSubTitle)
        } else if section == NaverType.twitter.rawValue {
            headerUpperView.addSubview(self.twitterButtonSlide)
            headerUpperView.addSubview(self.twitterColorSlide)
        } else {
            headerUpperView.addSubview(common)
            headerUpperView.addSubview(subTitle)
            headerUpperView.addSubview(headerImageView)
        }
        
        headerUpperView.addSubview(title)
        headerView.addSubview(headerUpperMarginView)
        headerView.addSubview(headerUpperView)
        
        if section == NaverType.naverKeyword.rawValue {
            common.snp.makeConstraints { (make) in
                make.left.equalTo(headerUpperView).offset(5)
                make.bottom.equalTo(headerUpperView).offset(-12)
            }
            title.snp.makeConstraints { (make) in
                make.left.equalTo(common.snp.right).offset(5)
                make.bottom.equalTo(headerUpperView).offset(-12)
            }
            rightSubTitle.snp.makeConstraints{ (make) in
                make.right.equalTo(headerUpperView).offset(-5)
                make.bottom.equalTo(headerUpperView).offset(-12)
            }
        } else if section == NaverType.twitter.rawValue {
            title.snp.makeConstraints { (make) in
                make.left.equalTo(headerUpperView).offset(5)
                make.top.equalTo(headerUpperView)
            }
            self.twitterColorOpenBtn.snp.makeConstraints { (make) in
                make.right.equalTo(self.twitterButtonSlide)
                make.top.equalTo(self.twitterButtonSlide)
                make.width.equalTo(100)
                make.height.equalTo(25)
            }
            self.twitterColorCloseBtn.snp.makeConstraints { (make) in
                make.left.equalTo(self.twitterColorSlide)
                make.top.equalTo(self.twitterColorSlide)
                make.width.equalTo(100)
                make.height.equalTo(25)
            }
            self.twitterColorBView.snp.makeConstraints{ (make) in
                make.top.equalTo(self.twitterColorSlide).offset(5)
                make.right.equalTo(self.twitterColorSlide)
                make.width.equalTo(self.twitterViewSize)
                make.height.equalTo(self.twitterViewSize)
            }
            self.twitterColorGView.snp.makeConstraints{ (make) in
                make.top.equalTo(self.twitterColorSlide).offset(5)
                make.right.equalTo(self.twitterColorBView.snp.left).offset(-5)
                make.width.equalTo(self.twitterViewSize)
                make.height.equalTo(self.twitterViewSize)
            }
            self.twitterColorRView.snp.makeConstraints{ (make) in
                make.top.equalTo(self.twitterColorSlide).offset(5)
                make.right.equalTo(self.twitterColorGView.snp.left).offset(-5)
                make.width.equalTo(self.twitterViewSize)
                make.height.equalTo(self.twitterViewSize)
            }
        } else {
            common.snp.makeConstraints { (make) in
                make.left.equalTo(headerUpperView).offset(imageMargin + Constants.sectionHeight)
                make.top.equalTo(headerUpperView).offset(15)
            }
            title.snp.makeConstraints { (make) in
                make.left.equalTo(common.snp.right).offset(5)
                make.top.equalTo(headerUpperView).offset(15)
            }
            subTitle.snp.makeConstraints { (make) in
                make.left.equalTo(headerUpperView).offset(imageMargin + Constants.sectionHeight)
                make.top.equalTo(common.snp.bottom).offset(2.5)
            }
        }
        
        if section == NaverType.upperInfo.rawValue || section == NaverType.lowerInfo.rawValue {
            return nil
        } else {
            return headerView
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        if section == NaverType.upperInfo.rawValue || section == NaverType.lowerInfo.rawValue || section == NaverType.naverKeyword.rawValue || section == NaverType.twitter.rawValue {
            footer.backgroundColor = UIColor.white
        } else {
            footer.backgroundColor = self.grayColor1
        }
        
        return footer
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == NaverType.upperInfo.rawValue || section == NaverType.lowerInfo.rawValue {
            return CGFloat.leastNonzeroMagnitude
        } else if section == NaverType.naverKeyword.rawValue {
            return Constants.sectionHeight - 35
        } else {
            return Constants.sectionHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == NaverType.naverKeyword.rawValue {
            return Constants.sectionFooterMargin * 3
        } else if section == NaverType.twitter.rawValue {
            return Constants.sectionFooterMargin * 4
        } else if section == NaverType.naverSportNews.rawValue {
            return Constants.sectionFooterMargin + Constants.cellHeight
        } else {
            return Constants.sectionFooterMargin * 2
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == NaverType.upperInfo.rawValue {
            return Constants.imgHeight
        } else if indexPath.section == NaverType.lowerInfo.rawValue {
            return Constants.infoHeight + Constants.infoUpperHeight
        } else if indexPath.section == NaverType.naverKeyword.rawValue  {
            return Constants.keywordAreaHeight
        } else {
            return Constants.cellHeight
        }
    }
    
    /*
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let head = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 20))
        head.backgroundColor = UIColor.gray
        return head
    }
    */
    
    func getContents() {
        let webContentManager = MainContentManager()
        
        webContentManager.getNaverKeyword {
            if !webContentManager.naverKeyword.isEmpty {
                self.naverKeyword = webContentManager.naverKeyword
            }
            for idx in 0...19 {
                self.keywordLabelsTitle[idx].text = self.naverKeyword[idx].keyword
            }
        }
        webContentManager.getNaverMainNews {
            self.naverMainNews = webContentManager.naverMainNews
            self.tableView.reloadData()
        }
        webContentManager.getNaverEnterNews {
            self.naverEnterNews = webContentManager.naverEnterNews
            self.tableView.reloadData()
        }
        webContentManager.getNaverSportsNews {
            self.naverSportsNews = webContentManager.naverSportsNews
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
    
    // keyword 클릭 시 작동하는 함수
    @objc func clickKeyword(_ gesture: KeywordGestureRecognizer) {
        if let index = gesture.index {
            // 터치 시 효과 구현
            let label = self.keywordLabelsTitle[index]
            if gesture.state == .began {
                label.backgroundColor = self.subColorlight
                // 터치 시 웹브라우저를 통한 검색 구현
                let url = self.naverKeyword[index].url
                let log = NaverType.getNaverName(.naverKeyword)()
                
                let urlEncoded = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                
                // safariViewController 생성 및 설정
                let config = SFSafariViewController.Configuration()
                config.barCollapsingEnabled = false
                let safariViewController = SFSafariViewController(url: URL(string: urlEncoded!)!, configuration: config)
                safariViewController.dismissButtonStyle = .close

                self.navigationController?.present(safariViewController, animated: true, completion: nil)

                Analytics.logEvent("keyword_click", parameters: ["section" : log])
            } else if gesture.state == .ended || gesture.state == .cancelled {
                label.backgroundColor = UIColor.white
            }
        }
    }
            
    // 구글 애드몹 배너 설정 메소드
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(bannerView)
//        self.view.bringSubviewToFront(bannerView)
        self.view.insertSubview(bannerView, aboveSubview: tableView)
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
    // twitter color 버튼 설정
    func setTwitterColorBtn (view: UIView, btn: UIButton, color1: UIColor, color2: UIColor, tag:Int) {
        view.tag = tag
        view.layer.borderWidth = 1
        if self.twitterSelectedColor == tag {
            view.layer.borderColor = self.grayColor4.cgColor
        } else {
            view.layer.borderColor = UIColor.white.cgColor
        }
        view.layer.cornerRadius = self.twitterViewSize / 2
        
        btn.tag = tag
        btn.frame = CGRect(x: self.twitterInnerMargin, y: self.twitterInnerMargin, width: self.twitterViewSize - (self.twitterInnerMargin * 2), height: self.twitterViewSize - (self.twitterInnerMargin * 2))
        btn.layer.cornerRadius = (self.twitterViewSize - (self.twitterInnerMargin * 2)) / 2
        btn.layer.masksToBounds = true
        btn.backgroundColor = color2
        
//        let gradient = CAGradientLayer()
//        gradient.frame = btn.bounds
//        gradient.startPoint = CGPoint(x: 0, y: 0)
//        gradient.endPoint = CGPoint(x: 1, y: 1)
//        gradient.colors = [color1.cgColor, color2.cgColor]
        
//        btn.layer.addSublayer(gradient)
        btn.addTarget(self, action: #selector(onTwitterColorBtnClick(_:)), for: .touchUpInside)

        view.addSubview(btn)
    }
    
    // twitter color button 클릭 시
    @objc func onTwitterColorBtnClick(_ sender: UIButton) {
        self.twitterSelectedColor = sender.tag
        self.twitterColorRView.layer.borderColor = UIColor.white.cgColor
        self.twitterColorGView.layer.borderColor = UIColor.white.cgColor
        self.twitterColorBView.layer.borderColor = UIColor.white.cgColor
        
        if sender.tag == 0 {
            self.twitterColorRView.layer.borderColor = self.grayColor4.cgColor
        } else if sender.tag == 1 {
            self.twitterColorGView.layer.borderColor = self.grayColor4.cgColor
        } else if sender.tag == 2 {
            self.twitterColorBView.layer.borderColor = self.grayColor4.cgColor
        }
        self.tableView.reloadData()
    }
    
    @objc func clickColorOpen(_ sender: UIButton) {
        print("open")
        self.isSlideShowing = true
        
        let options = UIView.AnimationOptions([.curveEaseInOut, .beginFromCurrentState])
        
        UIView.animate(
            withDuration: TimeInterval(self.slideTime),
            delay: TimeInterval(0),
            options: options,
            animations: {
                self.twitterColorSlide.frame = CGRect(x: 0, y: self.slideHeightMargin, width: self.view.frame.width - (Constants.sectionMargin * 2), height: Constants.sectionHeight - Constants.sectionMargin - self.slideHeightMargin)
            },
            completion: nil)
    }
    
    @objc func clickColorClose (_ sender: UIButton) {
        print("close")
        self.isSlideShowing = false
        
        let options = UIView.AnimationOptions([.curveEaseInOut, .beginFromCurrentState])
        
        UIView.animate(
            withDuration: TimeInterval(self.slideTime),
            delay: TimeInterval(0),
            options: options,
            animations: {
                self.twitterColorSlide.frame = CGRect(x: self.view.frame.width - (Constants.sectionMargin * 2), y: self.slideHeightMargin, width: self.view.frame.width - (Constants.sectionMargin * 2), height: Constants.sectionHeight - Constants.sectionMargin - self.slideHeightMargin)
            },
            completion: nil)
    }
}

class KeywordGestureRecognizer: UILongPressGestureRecognizer {
    var index: Int!
}
