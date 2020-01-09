//
//  CommunityContentManager.swift
//  catchup
//
//  Created by PJW on 09/01/2020.
//  Copyright © 2020 PJW. All rights reserved.
//

import UIKit
import Alamofire

class CommunityContentManager {
    
    lazy var cookContents: [(title: String, url: String)] = {
        var list = [(String, String)]()
        return list
    }()
    
    lazy var bullpenContents: [(title: String, url: String)] = {
        var list = [(String, String)]()
        return list
    }()
    
    lazy var ilbeContents: [(title: String, url: String)] = {
        var list = [(String, String)]()
        return list
    }()
    
    lazy var instizContents: [(title: String, url: String)] = {
        var list = [(String, String)]()
        return list
    }()
    
    lazy var ruliwebContents: [(title: String, url: String)] = {
        var list = [(String, String)]()
        return list
    }()
    
    lazy var clienContents: [(title: String, url: String)] = {
        var list = [(String, String)]()
        return list
    }()
    
    lazy var namuContents: [(title: String, url: String)] = {
        var list = [(String, String)]()
        return list
    }()
    
    let url_prefix = "https://scorpii.shop/korean/"
    
    // functions regarding API
    // 82cook 인기 게시물 호출 함수
    func getCookContents(completion: (() -> Void)? = nil) {
        
        let url = url_prefix + "82cook"
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
                    self.cookContents.append((title as! String, "https://www.82cook.com" + (url as! String)))
                }
                completion?()
            }
        }
    }
    
    // bullpen 인기 게시물 호출 함수
    func getBullpenContents(completion: (() -> Void)? = nil) {
        
        let url = url_prefix + "bullpen"
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
                    self.bullpenContents.append((title as! String, url as! String))
                }
                completion?()
            }
        }
    }
    
    // ilbe 인기 게시물 호출 함수
    func getIlbeContents(completion: (() -> Void)? = nil) {
        
        let url = url_prefix + "ilbe"
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
                    self.ilbeContents.append((title as! String, "https://www.ilbe.com" + (url as! String)))
                }
                completion?()
            }
        }
    }
    
    // instiz 인기 게시물 호출 함수
    func getInstizContents(completion: (() -> Void)? = nil) {
        
        let url = url_prefix + "instiz"
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
                    self.instizContents.append((title as! String, "https://www.instiz.net/" + (url as! String)))
                }
                completion?()
            }
        }
    }
    
    // ruliweb 인기 게시물 호출 함수
    func getRuliwebContents(completion: (() -> Void)? = nil) {
        
        let url = url_prefix + "ruliweb"
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
                    self.ruliwebContents.append((title as! String, url as! String))
                }
                completion?()
            }
        }
    }
    
    // clien 인기 게시물 호출 함수
    func getClienContents(completion: (() -> Void)? = nil) {
        
        let url = url_prefix + "clien"
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
                    self.clienContents.append((title as! String, "https://www.clien.net" + (url as! String)))
                }
                completion?()
            }
        }
    }
    
    // namu 인기 게시물 호출 함수
    func getNamuContents(completion: (() -> Void)? = nil) {
        
        let url = url_prefix + "namu"
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
                    self.namuContents.append((title as! String, "https://www.namu.live" + (url as! String)))
                }
                completion?()
            }
        }
    }

}