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

public enum NaverType: Int {
    case naverKeyword
    case naverMainNews
    case naverEnterNews
    case naverSportNews
    // enum의 count를 위한 case - 항상 제일 마지막에 위치해야 함
    case count
    
    func getNaverName() -> String {
        switch self {
        case .naverKeyword:
            return "네이버 실시간 검색어"
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
    
    lazy var naverKeyword: [String] = {
        var list = [String]()
        return list
    }()
    
    lazy var naverMainNews: [(title: String, url: String)] = {
        var list = [(String, String)]()
        return list
    }()
    
    lazy var naverEnterNews: [(title: String, url: String)] = {
        var list = [(String, String)]()
        return list
    }()
    
    lazy var naverSportsNews: [(title: String, url: String)] = {
        var list = [(String, String)]()
        return list
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 폰트 이름 찾기 위한 임시 프로세스
        /*
        for familyName in UIFont.familyNames {
            print("========\(familyName)===========")
            for fontName in UIFont.fontNames(forFamilyName: familyName) {
                 print(fontName)
            }
        }
        */
        
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
        
        let webContentManager = MainContentManager()
        
        webContentManager.getNaverKeyword {
            self.naverKeyword = webContentManager.naverKeyword
            
            for idx in 0...19 {
                self.keywordLabelsTitle[idx].text = self.naverKeyword[idx]
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        self.tabBarController?.tabBar.isHidden = false
    }

    // MARK: - Table view data source

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case NaverType.naverKeyword.rawValue:
            return 1
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
        
        if indexPath.section == NaverType.naverKeyword.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "keyword_cell") as! KeywordCell
            
            // scrollview 설정
            cell.scrollView.showsHorizontalScrollIndicator = false
            cell.scrollView.showsVerticalScrollIndicator = false
            
            cell.scrollView.isPagingEnabled = true
            cell.scrollView.frame.size.width = self.tableView.frame.width
            cell.scrollView.contentSize = CGSize(width: CGFloat(cell.pageSize) * self.tableView.frame.width, height: 0)
            
            // pageControll 설정
            cell.pageControll.snp.makeConstraints{ (make) in
                make.bottom.equalTo(cell.scrollView).offset(-5)
            }
            cell.pageControll.numberOfPages = 2
            cell.pageControll.currentPage = 0
            cell.pageControll.isUserInteractionEnabled = false
            cell.pageControll.pageIndicatorTintColor = UIColor(red:0.87, green:0.89, blue:0.90, alpha:1.0)
            cell.pageControll.currentPageIndicatorTintColor = UIColor(red:0.31, green:0.53, blue:0.27, alpha:1.0)
            cell.pageControll.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            
            // keywordContentView 설정
            let pageWidth = self.tableView.frame.width
            let pageHeight = cell.contentView.frame.height - 40

            cell.keywordContentView1.frame = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)

            cell.keywordContentView2.frame = CGRect(x: pageWidth, y: 0, width: pageWidth, height: pageHeight)

            cell.scrollView.addSubview(cell.keywordContentView1)
            cell.scrollView.addSubview(cell.keywordContentView2)
            cell.contentView.addSubview(cell.pageControll)
            
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
                let tag = idx < 10 ? cell.cellKeywordViews[idx].tag : cell.cellKeywordViews[idx].tag + 10
                cell.setKeywordLabels(cell.cellKeywordViews[idx], labelNum, labelTitle)
                labelNum.text = String(tag)
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "article_cell") as! ArticleCell
            cell.labelNum.font = UIFont.boldSystemFont(ofSize: 14)
            cell.labelNum.textColor = UIColor.brown
            cell.labelText.font = UIFont.systemFont(ofSize: 14)
            
            switch indexPath.section {
            case NaverType.naverMainNews.rawValue:
                let data = self.naverMainNews[indexPath.row]
                cell.labelNum.text = String(indexPath.row + 1)
                cell.labelText.text = data.title
            case NaverType.naverEnterNews.rawValue:
                let data = self.naverEnterNews[indexPath.row]
                cell.labelNum.text = String(indexPath.row + 1)
                cell.labelText.text = data.title
            case NaverType.naverSportNews.rawValue:
                let data = self.naverSportsNews[indexPath.row]
                cell.labelNum.text = String(indexPath.row + 1)
                cell.labelText.text = data.title
            default:
                ()
            }
            return cell
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
        let headerView = UIView()
        headerView.backgroundColor = self.mainColor
        
        let title = UILabel()
        let fontDec = UIFontDescriptor(name: "TTIGothicR", size: 18)
        fontDec.withSymbolicTraits(.traitBold)
        title.font = UIFont(descriptor: fontDec, size: 18)
        title.textColor = UIColor.white
        title.textAlignment = .left
        
        switch section {
        case NaverType.naverKeyword.rawValue:
            title.text = NaverType.getNaverName(.naverKeyword)()
        case NaverType.naverMainNews.rawValue:
            title.text = NaverType.getNaverName(.naverMainNews)()
        case NaverType.naverEnterNews.rawValue:
            title.text = NaverType.getNaverName(.naverEnterNews)()
        case NaverType.naverSportNews.rawValue:
            title.text = NaverType.getNaverName(.naverSportNews)()
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
        return Constants.sectionHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
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
    
}
