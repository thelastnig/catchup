//
//  BoonContentManager.swift
//  catchup
//
//  Created by PJW on 13/01/2020.
//  Copyright © 2020 PJW. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class BoonContentManager {
    
    lazy var boonContents: [(title: String, url: String, imgUrl: String, imgHeight: Int, id: String)] = {
        var list = [(String, String, String, Int, String)]()
        return list
    }()
    
    lazy var boonContentsView: [(title: String, url: String, imgUrl: String, imgHeight: Int, id: String)] = {
        var list = [(String, String, String, Int, String)]()
        return list
    }()
    
    let url_prefix = "https://scorpii.shop/korean/"
    
    // functions regarding API
    // boon 실시간 인기 게시물 호출 함수
    func getBoonContents(completion: (() -> Void)? = nil) {
        
        let url = url_prefix + "boon"
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
                    let imgUrl = data["imageLink"]
                    let imgHeight = data["imageHeight"]
                    let id = "normal"
                    self.boonContents.append((title as! String, url as! String, imgUrl as! String, imgHeight as! Int, id))
                }
                
                self.boonContents.append(("", "", "", 0, "last"))
                completion?()
            }
        }
    }
    
    // boon 많이 본 게시물 호출 함수
    func getBoonContentsView(completion: (() -> Void)? = nil) {
        
        let url = url_prefix + "boonv"
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
                    let imgUrl = data["imageLink"]
                    let imgHeight = data["imageHeight"]
                    let id = "normal"
                    self.boonContentsView.append((title as! String, url as! String, imgUrl as! String, imgHeight as! Int, id))
                }
                self.boonContentsView.append(("", "", "", 0, "last"))
                completion?()
            }
        }
    }
}
