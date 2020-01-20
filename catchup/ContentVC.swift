//
//  ContentVC.swift
//  catchup
//
//  Created by PJW on 19/12/2019.
//  Copyright © 2019 PJW. All rights reserved.
//

import UIKit
import WebKit

class ContentVC: UIViewController, WKNavigationDelegate {
    
    var url: String?

    @IBOutlet var indicator: UIActivityIndicatorView!
    @IBOutlet var broswer: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.broswer.navigationDelegate = self
        
        guard let url = URL(string:url!) else { return }
        let request = URLRequest(url: url)
        self.broswer.load(request)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @available(iOS 8.0, *)
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.indicator.startAnimating()
    }
    
    @available(iOS 8.0, *)
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.indicator.stopAnimating()
    }
}
