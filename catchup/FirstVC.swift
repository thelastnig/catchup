//
//  FirstVC.swift
//  catchup
//
//  Created by PJW on 30/12/2019.
//  Copyright © 2019 PJW. All rights reserved.
//

import UIKit
import Kanna
import Alamofire
import SnapKit

class FirstVC: UIViewController {
    @IBOutlet var btnSideBar: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var keywordHeaderView: UIView!
    @IBOutlet var keywordView: UIView!
    
    var keywordContentView: UIView!
    
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
        
        /*  사이드 메뉴
        if let revealVC = self.revealViewController() {
            self.btnSideBar.target = revealVC
            self.btnSideBar.action = #selector(revealVC.revealToggle(_:))
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
        */
        
        // keywordHeaderView constraint 및 기타 설정
        keywordHeaderView.backgroundColor = UIColor.red
        
        // keywordContentView 설정
        self.keywordContentView = UIView()
        
        self.keywordContentView.backgroundColor = UIColor.white
        
        self.keywordView.addSubview(self.keywordContentView)
        
        self.keywordContentView.snp.makeConstraints { (make) in
            make.left.equalTo(self.keywordView).offset(10)
            make.right.equalTo(self.keywordView).offset(-10)
            make.top.equalTo(self.keywordView).offset(10)
            make.height.equalTo(self.keywordView.frame.height - 40)
            make.width.equalTo(self.keywordView.frame.width - 20)
        }
        
        // keywordLabel(label들을 담기 위한 container view) 생성 및 설정
        let keywordLabel01 = UIView()
        keywordLabel01.tag = 1
        self.setKeywordView(view: keywordLabel01)
        let keywordLabel02 = UIView()
        keywordLabel02.tag = 2
        self.setKeywordView(view: keywordLabel02)
        let keywordLabel03 = UIView()
        keywordLabel03.tag = 3
        self.setKeywordView(view: keywordLabel03)
        let keywordLabel04 = UIView()
        keywordLabel04.tag = 4
        self.setKeywordView(view: keywordLabel04)
        let keywordLabel05 = UIView()
        keywordLabel05.tag = 5
        self.setKeywordView(view: keywordLabel05)
        let keywordLabel06 = UIView()
        keywordLabel06.tag = 6
        self.setKeywordView(view: keywordLabel06)
        let keywordLabel07 = UIView()
        keywordLabel07.tag = 7
        self.setKeywordView(view: keywordLabel07)
        let keywordLabel08 = UIView()
        keywordLabel08.tag = 8
        self.setKeywordView(view: keywordLabel08)
        let keywordLabel09 = UIView()
        keywordLabel09.tag = 9
        self.setKeywordView(view: keywordLabel09)
        let keywordLabel10 = UIView()
        keywordLabel10.tag = 10
        self.setKeywordView(view: keywordLabel10)
        
        // 순번 및 검색어를 위한 label 생성 및 설정
        let keywordLabel01Num = UILabel()
        let keywordLabel01Title = UILabel()
        self.setKeywordLabels(keywordLabel01, keywordLabel01Num, keywordLabel01Title)
        
        let keywordLabel02Num = UILabel()
        let keywordLabel02Title = UILabel()
        self.setKeywordLabels(keywordLabel02, keywordLabel02Num, keywordLabel02Title)
        
        let keywordLabel03Num = UILabel()
        let keywordLabel03Title = UILabel()
        self.setKeywordLabels(keywordLabel03, keywordLabel03Num, keywordLabel03Title)
        
        let keywordLabel04Num = UILabel()
        let keywordLabel04Title = UILabel()
        self.setKeywordLabels(keywordLabel04, keywordLabel04Num, keywordLabel04Title)
        
        let keywordLabel05Num = UILabel()
        let keywordLabel05Title = UILabel()
        self.setKeywordLabels(keywordLabel05, keywordLabel05Num, keywordLabel05Title)
        
        let keywordLabel06Num = UILabel()
        let keywordLabel06Title = UILabel()
        self.setKeywordLabels(keywordLabel06, keywordLabel06Num, keywordLabel06Title)
        
        let keywordLabel07Num = UILabel()
        let keywordLabel07Title = UILabel()
        self.setKeywordLabels(keywordLabel07, keywordLabel07Num, keywordLabel07Title)
        
        let keywordLabel08Num = UILabel()
        let keywordLabel08Title = UILabel()
        self.setKeywordLabels(keywordLabel08, keywordLabel08Num, keywordLabel08Title)
        
        let keywordLabel09Num = UILabel()
        let keywordLabel09Title = UILabel()
        self.setKeywordLabels(keywordLabel09, keywordLabel09Num, keywordLabel09Title)
        
        let keywordLabel10Num = UILabel()
        let keywordLabel10Title = UILabel()
        self.setKeywordLabels(keywordLabel10, keywordLabel10Num, keywordLabel10Title)
        
        // API 받아오기
        self.getNaverKeyword {
            keywordLabel01Num.text = String(keywordLabel01.tag)
            keywordLabel01Title.text = self.naverKeyword[keywordLabel01.tag - 1]
            keywordLabel02Num.text = String(keywordLabel02.tag)
            keywordLabel02Title.text = self.naverKeyword[keywordLabel02.tag - 1]
            keywordLabel03Num.text = String(keywordLabel03.tag)
            keywordLabel03Title.text = self.naverKeyword[keywordLabel03.tag - 1]
            keywordLabel04Num.text = String(keywordLabel04.tag)
            keywordLabel04Title.text = self.naverKeyword[keywordLabel04.tag - 1]
            keywordLabel05Num.text = String(keywordLabel05.tag)
            keywordLabel05Title.text = self.naverKeyword[keywordLabel05.tag - 1]
            keywordLabel06Num.text = String(keywordLabel06.tag)
            keywordLabel06Title.text = self.naverKeyword[keywordLabel06.tag - 1]
            keywordLabel07Num.text = String(keywordLabel07.tag)
            keywordLabel07Title.text = self.naverKeyword[keywordLabel07.tag - 1]
            keywordLabel08Num.text = String(keywordLabel08.tag)
            keywordLabel08Title.text = self.naverKeyword[keywordLabel08.tag - 1]
            keywordLabel09Num.text = String(keywordLabel09.tag)
            keywordLabel09Title.text = self.naverKeyword[keywordLabel09.tag - 1]
            keywordLabel10Num.text = String(keywordLabel10.tag)
            keywordLabel10Title.text = self.naverKeyword[keywordLabel10.tag - 1]
        }
        self.getNaverMainNews()
        self.getNaverEnterNews()
        self.getNaverSportsNews()
        
    }
    /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
    */
    
    // NAVER keyword view setting function
    func setKeywordView(view: UIView) {
        let keywordViewHeight = (self.keywordView.frame.height - 40) / 5
        let keywordViewWidth = (self.keywordView.frame.width - 20) / 2
        view.frame.size.width = keywordViewWidth
        view.frame.size.height = keywordViewHeight
        if view.tag < 6 {
            view.frame.origin.x = 0
            view.frame.origin.y = CGFloat(view.tag - 1) * keywordViewHeight
        } else {
            view.frame.origin.x = keywordViewWidth
            view.frame.origin.y = CGFloat(view.tag - 6) * keywordViewHeight
        }
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.blue.cgColor
        self.keywordContentView.addSubview(view)
    }
    
    func setKeywordLabels(_ superView: UIView, _ numLabel: UILabel, _ titleLabel: UILabel) {
        
        let leftOffset: CGFloat = 10
        let rightOffset: CGFloat = 10
        let numLabelWidth: CGFloat = 20
        
        /*
        numLabel.frame = CGRect(x: 0, y: 0, width: numLabelWidth, height: superView.frame.height)
        */
        numLabel.textAlignment = .left
        numLabel.textColor = UIColor.brown
        numLabel.font = UIFont.boldSystemFont(ofSize: 12)
        numLabel.layer.borderColor = UIColor.green.cgColor
        numLabel.layer.borderWidth = 1
        
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.layer.borderColor = UIColor.red.cgColor
        titleLabel.layer.borderWidth = 1
        
        superView.addSubview(numLabel)
        superView.addSubview(titleLabel)
        
        numLabel.snp.makeConstraints { (make) in
            make.left.equalTo(superView).offset(leftOffset)
            make.height.equalTo(superView.frame.height)
            make.width.equalTo(numLabelWidth)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(numLabel.snp.right).offset(rightOffset)
            make.right.equalTo(superView)
            make.height.equalTo(superView.frame.height)
        }
    }
    
    // functions regarding API
    func getNaverKeyword(completion: (() -> Void)? = nil) {
        
        let url = "https://datalab.naver.com/keyword/realtimeList.naver?where=main"
        let call = Alamofire.request(url)
        print(url)
        
        call.responseString { response in
            guard let html = response.result.value else { return }
            if let doc = try? Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
                let items = doc.xpath("//div[@class='ranking_box']/ul/li")
                
                var index = 0
                for item in items {
                    if index >= 10 {
                        break
                    }
                    if let title = item.at_xpath("div/span/span[@class='item_title']")?.text {
                        self.naverKeyword.append(title)
                    }
                    index = index + 1
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
                    let title = item.text?.trimmingCharacters(in: .whitespacesAndNewlines)
                    let url = item.at_xpath("a")?["href"]!
                    self.naverEnterNews.append((title!, "https://m.entertain.naver.com" + url!))
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func getNaverSportsNews() {
        
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
    }
}
