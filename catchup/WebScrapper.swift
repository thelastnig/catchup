//
//  WebScrapper.swift
//  catchup
//
//  Created by PJW on 16/12/2019.
//  Copyright © 2019 PJW. All rights reserved.
//

import Kanna
import Alamofire

class WebScrapper {
    
    func getNaverKeyword() {
        let url = "https://datalab.naver.com/keyword/realtimeList.naver?where=main"
        let call = Alamofire.request(url)
        
        call.responseString { response in
            if let html = response.result.value {
                self.parseHTML(html: html)
            }
        }
    }
    
    func parseHTML(html: String) {
        if let doc = try? Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
            var tempList: [Dictionary<String, String>] = []
            let list = doc.xpath("//div[@class='ranking_box']/ul/li")
            
            for item in list {
                if let title = item.at_xpath("div/span/span[@class='item_title']")?.text, let num = item.at_xpath("div/span[@class='item_num']")?.text {
                    let dic = [num: title]
                    tempList.append(dic)
                }
            }
            let ud = UserDefaults.standard
            ud.set(tempList, forKey: "naverKeyword")
            print("here")
        }
    }
}
