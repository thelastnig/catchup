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
        
        self.getNaverKeyword()
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
            return self.naverKeyword.count
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
            let data = self.naverKeyword[indexPath.row]
            cell.numberLabel.text = String(indexPath.row + 1)
            cell.titleLabel.text = data
            cell.titleLabel.textAlignment = .left
            return cell
        } else if indexPath.section == 1  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "article_cell")
            let data = self.naverMainNews[indexPath.row]
            cell?.textLabel?.text = data.title
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 16)
            return cell!
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "article_cell")
            let data = self.naverEnterNews[indexPath.row]
            cell?.textLabel?.text = data.title
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 16)
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "article_cell")
            let data = self.naverSportsNews[indexPath.row]
            cell?.textLabel?.text = data.title
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 16)
            return cell!
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
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "title"
    }
    
    /*
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let head = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 20))
        head.backgroundColor = UIColor.gray
        return head
    }
    */
    
    // functions regarding API
    func getNaverKeyword() {
        
        let url = "https://datalab.naver.com/keyword/realtimeList.naver?where=main"
        let call = Alamofire.request(url)
        
        call.responseString { response in
            guard let html = response.result.value else { return }
            if let doc = try? Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
                let items = doc.xpath("//div[@class='ranking_box']/ul/li")
                
                var index = 0
                for item in items {
                    if index >= 10 {
                        return
                    }
                    if let title = item.at_xpath("div/span/span[@class='item_title']")?.text {
                        self.naverKeyword.append(title)
                    }
                    index = index + 1
                }
                self.tableView.reloadData()
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
