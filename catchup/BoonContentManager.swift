//
//  BoonContentManager.swift
//  catchup
//
//  Created by PJW on 13/01/2020.
//  Copyright © 2020 PJW. All rights reserved.
//

import UIKit
import Alamofire

class BoonContentManager {
    
    lazy var boonContents: [(title: String, url: String, imgUrl: String)] = {
        var list = [(String, String, String)]()
        return list
    }()
    
    let url_prefix = "https://scorpii.shop/korean/"
    
    // functions regarding API
    // 82cook 인기 게시물 호출 함수
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
                    self.boonContents.append((title as! String, url as! String, imgUrl as! String))
                }
                completion?()
            }
        }
    }
}
