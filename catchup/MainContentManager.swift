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
    
    lazy var naverKeyword: [String] = {
        var list = Array.init(repeating: "", count: 20)
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

                for item in items {
                    let data = item as! NSDictionary
                    let title = data["title"]
                    self.naverKeyword.append(title as! String)
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
    
}
