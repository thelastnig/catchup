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
        
        self.getNaverKeyword {
            self.keywordLabel01Title.text = self.naverKeyword[0]
            self.keywordLabel02Title.text = self.naverKeyword[1]
            self.keywordLabel03Title.text = self.naverKeyword[2]
            self.keywordLabel04Title.text = self.naverKeyword[3]
            self.keywordLabel05Title.text = self.naverKeyword[4]
            self.keywordLabel06Title.text = self.naverKeyword[5]
            self.keywordLabel07Title.text = self.naverKeyword[6]
            self.keywordLabel08Title.text = self.naverKeyword[7]
            self.keywordLabel09Title.text = self.naverKeyword[8]
            self.keywordLabel10Title.text = self.naverKeyword[9]
            self.keywordLabel01_2Title.text = self.naverKeyword[10]
            self.keywordLabel02_2Title.text = self.naverKeyword[11]
            self.keywordLabel03_2Title.text = self.naverKeyword[12]
            self.keywordLabel04_2Title.text = self.naverKeyword[13]
            self.keywordLabel05_2Title.text = self.naverKeyword[14]
            self.keywordLabel06_2Title.text = self.naverKeyword[15]
            self.keywordLabel07_2Title.text = self.naverKeyword[16]
            self.keywordLabel08_2Title.text = self.naverKeyword[17]
            self.keywordLabel09_2Title.text = self.naverKeyword[18]
            self.keywordLabel10_2Title.text = self.naverKeyword[19]
        }
        self.getNaverMainNews()
        self.getNaverEnterNews()
        self.getNaverSportsNews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 1
        case 1:
            return self.naverMainNews.count
        case 2:
            return self.naverEnterNews.count
        case 3:
            return self.naverSportsNews.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "keyword_cell") as! KeywordCell
            
            // keywordLabel 설정
            cell.keywordLabel01.tag = 1
            cell.setKeywordView(view: cell.keywordLabel01, superView: cell.keywordContentView1)
            cell.keywordLabel02.tag = 2
            cell.setKeywordView(view: cell.keywordLabel02, superView: cell.keywordContentView1)
            cell.keywordLabel03.tag = 3
            cell.setKeywordView(view: cell.keywordLabel03, superView: cell.keywordContentView1)
            cell.keywordLabel04.tag = 4
            cell.setKeywordView(view: cell.keywordLabel04, superView: cell.keywordContentView1)
            cell.keywordLabel05.tag = 5
            cell.setKeywordView(view: cell.keywordLabel05, superView: cell.keywordContentView1)
            cell.keywordLabel06.tag = 6
            cell.setKeywordView(view: cell.keywordLabel06, superView: cell.keywordContentView1)
            cell.keywordLabel07.tag = 7
            cell.setKeywordView(view: cell.keywordLabel07, superView: cell.keywordContentView1)
            cell.keywordLabel08.tag = 8
            cell.setKeywordView(view: cell.keywordLabel08, superView: cell.keywordContentView1)
            cell.keywordLabel09.tag = 9
            cell.setKeywordView(view: cell.keywordLabel09, superView: cell.keywordContentView1)
            cell.keywordLabel10.tag = 10
            cell.setKeywordView(view: cell.keywordLabel10, superView: cell.keywordContentView1)
            
            cell.keywordLabel01_2.tag = 1
            cell.setKeywordView(view: cell.keywordLabel01_2, superView: cell.keywordContentView2)
            cell.keywordLabel02_2.tag = 2
            cell.setKeywordView(view: cell.keywordLabel02_2, superView: cell.keywordContentView2)
            cell.keywordLabel03_2.tag = 3
            cell.setKeywordView(view: cell.keywordLabel03_2, superView: cell.keywordContentView2)
            cell.keywordLabel04_2.tag = 4
            cell.setKeywordView(view: cell.keywordLabel04_2, superView: cell.keywordContentView2)
            cell.keywordLabel05_2.tag = 5
            cell.setKeywordView(view: cell.keywordLabel05_2, superView: cell.keywordContentView2)
            cell.keywordLabel06_2.tag = 6
            cell.setKeywordView(view: cell.keywordLabel06_2, superView: cell.keywordContentView2)
            cell.keywordLabel07_2.tag = 7
            cell.setKeywordView(view: cell.keywordLabel07_2, superView: cell.keywordContentView2)
            cell.keywordLabel08_2.tag = 8
            cell.setKeywordView(view: cell.keywordLabel08_2, superView: cell.keywordContentView2)
            cell.keywordLabel09_2.tag = 9
            cell.setKeywordView(view: cell.keywordLabel09_2, superView: cell.keywordContentView2)
            cell.keywordLabel10_2.tag = 10
            cell.setKeywordView(view: cell.keywordLabel10_2, superView: cell.keywordContentView2)
            
            // 순번 및 검색어를 위한 label 설정
            cell.setKeywordLabels(cell.keywordLabel01, self.keywordLabel01Num, self.keywordLabel01Title)
            self.keywordLabel01Num.text = String(cell.keywordLabel01.tag)
            cell.setKeywordLabels(cell.keywordLabel02, self.keywordLabel02Num, self.keywordLabel02Title)
            self.keywordLabel02Num.text = String(cell.keywordLabel02.tag)
            cell.setKeywordLabels(cell.keywordLabel03, self.keywordLabel03Num, self.keywordLabel03Title)
            self.keywordLabel03Num.text = String(cell.keywordLabel03.tag)
            cell.setKeywordLabels(cell.keywordLabel04, self.keywordLabel04Num, self.keywordLabel04Title)
            self.keywordLabel04Num.text = String(cell.keywordLabel04.tag)
            cell.setKeywordLabels(cell.keywordLabel05, self.keywordLabel05Num, self.keywordLabel05Title)
            self.keywordLabel05Num.text = String(cell.keywordLabel05.tag)
            cell.setKeywordLabels(cell.keywordLabel06, self.keywordLabel06Num, self.keywordLabel06Title)
            self.keywordLabel06Num.text = String(cell.keywordLabel06.tag)
            cell.setKeywordLabels(cell.keywordLabel07, self.keywordLabel07Num, self.keywordLabel07Title)
            self.keywordLabel07Num.text = String(cell.keywordLabel07.tag)
            cell.setKeywordLabels(cell.keywordLabel08, self.keywordLabel08Num, self.keywordLabel08Title)
            self.keywordLabel08Num.text = String(cell.keywordLabel08.tag)
            cell.setKeywordLabels(cell.keywordLabel09, self.keywordLabel09Num, self.keywordLabel09Title)
            self.keywordLabel09Num.text = String(cell.keywordLabel09.tag)
            cell.setKeywordLabels(cell.keywordLabel10, self.keywordLabel10Num, self.keywordLabel10Title)
            self.keywordLabel10Num.text = String(cell.keywordLabel10.tag)

            cell.setKeywordLabels(cell.keywordLabel01_2, self.keywordLabel01_2Num, self.keywordLabel01_2Title)
            self.keywordLabel01_2Num.text = String(cell.keywordLabel01_2.tag + 10)
            cell.setKeywordLabels(cell.keywordLabel02_2, self.keywordLabel02_2Num, self.keywordLabel02_2Title)
            self.keywordLabel02_2Num.text = String(cell.keywordLabel02_2.tag + 10)
            cell.setKeywordLabels(cell.keywordLabel03_2, self.keywordLabel03_2Num, self.keywordLabel03_2Title)
            self.keywordLabel03_2Num.text = String(cell.keywordLabel03_2.tag + 10)
            cell.setKeywordLabels(cell.keywordLabel04_2, self.keywordLabel04_2Num, self.keywordLabel04_2Title)
            self.keywordLabel04_2Num.text = String(cell.keywordLabel04_2.tag + 10)
            cell.setKeywordLabels(cell.keywordLabel05_2, self.keywordLabel05_2Num, self.keywordLabel05_2Title)
            self.keywordLabel05_2Num.text = String(cell.keywordLabel05_2.tag + 10)
            cell.setKeywordLabels(cell.keywordLabel06_2, self.keywordLabel06_2Num, self.keywordLabel06_2Title)
            self.keywordLabel06_2Num.text = String(cell.keywordLabel06_2.tag + 10)
            cell.setKeywordLabels(cell.keywordLabel07_2, self.keywordLabel07_2Num, self.keywordLabel07_2Title)
            self.keywordLabel07_2Num.text = String(cell.keywordLabel07_2.tag + 10)
            cell.setKeywordLabels(cell.keywordLabel08_2, self.keywordLabel08_2Num, self.keywordLabel08_2Title)
            self.keywordLabel08_2Num.text = String(cell.keywordLabel08_2.tag + 10)
            cell.setKeywordLabels(cell.keywordLabel09_2, self.keywordLabel09_2Num, self.keywordLabel09_2Title)
            self.keywordLabel09_2Num.text = String(cell.keywordLabel09_2.tag + 10)
            cell.setKeywordLabels(cell.keywordLabel10_2, self.keywordLabel10_2Num, self.keywordLabel10_2Title)
            self.keywordLabel10_2Num.text = String(cell.keywordLabel10_2.tag + 10)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "article_cell") as! ArticleCell
            cell.labelNum.font = UIFont.boldSystemFont(ofSize: 14)
            cell.labelNum.textColor = UIColor.brown
            cell.labelText.font = UIFont.systemFont(ofSize: 14)
            
            switch indexPath.section {
            case 1:
                let data = self.naverMainNews[indexPath.row]
                cell.labelNum.text = String(indexPath.row + 1)
                cell.labelText.text = data.title
            case 2:
                let data = self.naverEnterNews[indexPath.row]
                cell.labelNum.text = String(indexPath.row + 1)
                cell.labelText.text = data.title
            case 3:
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
        
        let contentVC = self.storyboard?.instantiateViewController(identifier: "contentVC") as! ContentVC
        
        switch indexPath.section {
        case 0:
            return
        case 1:
            contentVC.url = self.naverMainNews[indexPath.row].url
            self.navigationController?.pushViewController(contentVC, animated: true)
        case 2:
            contentVC.url = self.naverEnterNews[indexPath.row].url
            print(self.naverEnterNews[indexPath.row].url)
            self.navigationController?.pushViewController(contentVC, animated: true)
        case 3:
            contentVC.url = self.naverSportsNews[indexPath.row].url
            print(self.naverSportsNews[indexPath.row].url)
            self.navigationController?.pushViewController(contentVC, animated: true)
        default:
            ()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = self.mainColor
        
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 17)
        title.textColor = UIColor.white
        title.textAlignment = .left
        
        switch section {
        case 0:
            title.text = "네이버 실시간 검색어"
        case 1:
            title.text = "주요 뉴스"
        case 2:
            title.text = "연예 뉴스"
        case 3:
            title.text = "스포츠 뉴스"
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
        if indexPath.section == 0 {
            return 200
        } else {
            return 50
        }
    }
    
    /*
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let head = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 20))
        head.backgroundColor = UIColor.gray
        return head
    }
    */
    
   
    // functions regarding API
    func getNaverKeyword(completion: (() -> Void)? = nil) {
        
        /*
        let call = Alamofire.request(url)
        
        call.responseString { response in
            guard let html = response.result.value else { return }
            if let doc = try? Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
                let items = doc.xpath("//div[@class='ranking_box']/ul/li")
                
                var index = 0
                for item in items {
                    if let title = item.at_xpath("div/span/span[@class='item_title']")?.text {
                        self.naverKeyword.append(title)
                    }
                    index = index + 1
                }
                completion?()
            }
        }
        */
        
        let url = "http://catchup.cafe24app.com/korean/naverKeyword"
        let call = Alamofire.request(url)
        
        call.responseJSON { response in
            guard let html = response.result.value as? NSDictionary else { return }
            let status = html["status"] as! String
            if status == "success" {
                let items = html["data"] as! NSArray

                for item in items {
                    let data = item as! NSDictionary
                    let title = data["title"]
                    self.naverKeyword.append(title as! String)
                }
                completion?()
            }
        }
    }
    
    func getNaverMainNews() {
        
        let url = "https://news.naver.com/main/ranking/popularDay.nhn"
        let call = Alamofire.request(url)
        
        call.responseString { response in
            guard let html = response.result.value else { return }
            if let doc = try? Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
                let items = doc.xpath("//ul[@class='list_txt']/li")
                
                for item in items {
                    let title = item.at_xpath("a")?["title"]!
                    let url = item.at_xpath("a")?["href"]!
                    self.naverMainNews.append((title!, url!))
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func getNaverEnterNews() {
        
        let url = "https://entertain.naver.com/home"
        let call = Alamofire.request(url)
        
        call.responseString { response in
            guard let html = response.result.value else { return }
            if let doc = try? Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
                let items = doc.xpath("//div[@class='rank_lst']/ul/li")
                
                for item in items {
                    let title = item.at_xpath("a")?.text?.trimmingCharacters(in: .whitespacesAndNewlines)
                    let url = item.at_xpath("a")?["href"]!
                    self.naverEnterNews.append((title!, "https://m.entertain.naver.com" + url!))
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func getNaverSportsNews() {
        
        /*
        let url = "https://sports.news.naver.com/index.nhn"
        let call = Alamofire.request(url)
        
        call.responseString { response in
            guard let html = response.result.value else { return }
            if let doc = try? Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
                let items = doc.xpath("//ul[@id='mostViewedNewsList']/li")
                
                for item in items {
                    let title = item.at_xpath("a")?["title"]!
                    let url = item.at_xpath("a")?["href"]!
                    self.naverSportsNews.append((title!, "https://sports.news.naver.com" + url!))
                }
                self.tableView.reloadData()
            }
        }
         */
        
        let url = "http://catchup.cafe24app.com/korean/naverSportsNews"
        let call = Alamofire.request(url)
        
        call.responseJSON { response in
            guard let html = response.result.value as? NSDictionary else { return }
            let status = html["status"] as! String
            if status == "success" {
                let items = html["data"] as! NSArray

                for item in items {
                    let data = item as! NSDictionary
                    let title = data["title"]
                    let url = data["link"]
                    self.naverSportsNews.append((title as! String, "https://sports.news.naver.com" + (url as! String)))
                }
            }
        }
    }
    
    
}
