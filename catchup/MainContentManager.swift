//
//  MainContentManager.swift
//  catchup
//
//  Created by PJW on 09/01/2020.
//  Copyright © 2020 PJW. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class MainContentManager {
    
    lazy var naverKeyword: [(keyword: String, url: String)] = {
        //        var list = Array.init(repeating: "", count: 20)
        var list = [(String, String)]()
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
    
    lazy var twitterTrends: [[(title: String, url: String, isColor: Bool, colorIdx: Int)]] = {
        var list = [[(String, String, Bool, Int)]]()
        return list
    }()
    
    var remoteConfig: RemoteConfig!
    
    let url_prefix = "https://scorpii.shop/korean/"
    
    // functions regarding API
    // 네이버 실시간 검색어 호출 함수
    func getNaverKeyword(completion: (() -> Void)? = nil) {
        
        let url = url_prefix + "naverKeyword"
        let call = Alamofire.request(url)
        
        call.responseJSON { response in
            guard let html = response.result.value as? NSDictionary else { return }
            let status = html["status"] as! String
            if status == "success" {
                let items = html["data"] as! NSArray
                let url_pre = "https://search.naver.com/search.naver?sm=top_hty&fbm=1&ie=utf8&query="

                for item in items {
                    let data = item as! NSDictionary
                    let title = data["title"]
                    let url = url_pre + (title as! String)
                    self.naverKeyword.append((title as! String, url))
                }
                completion?()
            }
        }
    }
    
    // 네이버 메인 뉴스 호츨 함수
    func getNaverMainNews(completion: (() -> Void)? = nil) {
        
        let url = url_prefix + "naverMainNews"
        let call = Alamofire.request(url)
        
        call.responseJSON { response in
            guard let html = response.result.value as? NSDictionary else { return }
            let status = html["status"] as! String
            if status == "success" {
                let items = html["data"] as! NSArray

                var i: Int = 0
                for item in items {
                    i = i + 1
                    let data = item as! NSDictionary
                    let title = data["title"]
                    let url = data["link"]
                    self.naverMainNews.append((title as! String, url as! String, i))
                }
                completion?()
            }
        }
    }
    
    // 네이버 연예 뉴스 호츨 함수
    func getNaverEnterNews(completion: (() -> Void)? = nil) {
        
        let url = url_prefix + "naverEnterNews"
        let call = Alamofire.request(url)
        
        call.responseJSON { response in
            guard let html = response.result.value as? NSDictionary else { return }
            let status = html["status"] as! String
            if status == "success" {
                let items = html["data"] as! NSArray

                var i: Int = 0
                for item in items {
                    i = i + 1
                    let data = item as! NSDictionary
                    let title = data["title"]
                    let url = data["link"]
                    self.naverEnterNews.append((title as! String, url as! String, i))
                }
                completion?()
            }
        }
    }
    
    // 네이버 스포츠 뉴스 호츨 함수
    func getNaverSportsNews(completion: (() -> Void)? = nil) {
        
        let url = url_prefix + "naverSportsNews"
        let call = Alamofire.request(url)
        
        call.responseJSON { response in
            guard let html = response.result.value as? NSDictionary else { return }
            let status = html["status"] as! String
            if status == "success" {
                let items = html["data"] as! NSArray

                var i: Int = 0
                for item in items {
                    i = i + 1
                    let data = item as! NSDictionary
                    let title = data["title"]
                    let url = data["link"]
                    self.naverSportsNews.append((title as! String, url as! String, i))
                }
                completion?()
            }
        }
    }
    
    // 트위터 트렌드 호츨 함수
    func getTwitterTrends(completion: (() -> Void)? = nil) {
        
        let url = url_prefix + "twitter"
        let call = Alamofire.request(url)
        
        call.responseJSON { response in
            guard let html = response.result.value as? NSDictionary else { return }
            let status = html["status"] as! String
            if status == "success" {
                let items = html["data"] as! NSArray
                
                for item in items {
                    var trendList: [(title: String, url: String, isColor: Bool, colorIdx: Int)] = []
                    let trends = item as! NSArray
                    for trend in trends {
                        let data = trend as! NSDictionary
                        let title = data["name"]
                        let url = data["url"]
                        let isColor = data["color"]
                        let colorIdx = data["colorIdx"]
                        trendList.append((title: title as! String, url: url as! String, isColor: isColor as! Bool, colorIdx: colorIdx as! Int))
                    }
                    trendList.shuffle()
                    self.twitterTrends.append(trendList)
                }
                completion?()
            }
        }
    }
    
}
