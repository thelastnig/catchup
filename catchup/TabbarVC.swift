//
//  TabbarVC.swift
//  catchup
//
//  Created by PJW on 22/01/2020.
//  Copyright © 2020 PJW. All rights reserved.
//

import UIKit

class TabbarVC: UITabBarController, UITabBarControllerDelegate {
    
    // Tabbar Custom
    let csHeader = UIView()
    let csTabbar = UIView()
    
    let tabMain = UIButton(type: .custom)
    let tabCommunity = UIButton(type: .custom)
    let tabBoon = UIButton(type: .custom)
    let tabCount: CGFloat = 3
    
    // 메인 페이지를 위한 변수 설정
    lazy var naverKeyword: [(keyword: String, url: String)] = {
        var list = Array.init(repeating: ("", "https://www.naver.com"), count: 20)
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
    
    
    // 커뮤니티 탭을 위한 변수 설정
    lazy var cookContents: [(title: String, url: String, idx: Int)] = {
        var list = [(String, String, Int)]()
        return list
    }()
    
    lazy var bullpenContents: [(title: String, url: String, idx: Int)] = {
        var list = [(String, String, Int)]()
        return list
    }()
    
    lazy var ilbeContents: [(title: String, url: String, idx: Int)] = {
        var list = [(String, String, Int)]()
        return list
    }()
    
    lazy var instizContents: [(title: String, url: String, idx: Int)] = {
        var list = [(String, String, Int)]()
        return list
    }()
    
    lazy var ruliwebContents: [(title: String, url: String, idx: Int)] = {
        var list = [(String, String, Int)]()
        return list
    }()
    
    lazy var clienContents: [(title: String, url: String, idx: Int)] = {
        var list = [(String, String, Int)]()
        return list
    }()
    
    lazy var namuContents: [(title: String, url: String, idx: Int)] = {
        var list = [(String, String, Int)]()
        return list
    }()
    
    lazy var ppomppuContents: [(title: String, url: String, idx: Int)] = {
        var list = [(String, String, Int)]()
        return list
    }()
    
    lazy var nateContents: [(title: String, url: String, idx: Int)] = {
        var list = [(String, String, Int)]()
        return list
    }()
    
    lazy var fmContents: [(title: String, url: String, idx: Int)] = {
        var list = [(String, String, Int)]()
        return list
    }()
    
    lazy var theqooContents: [(title: String, url: String, idx: Int)] = {
        var list = [(String, String, Int)]()
        return list
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        
        // 네트워크 연결 확인
        self.checkNetwork()
        
        // 기존 tabbar 숨기기
        self.tabBar.isHidden = true
        
        // tabbar custom
        let width = self.view.frame.width
        let height_header: CGFloat = self.upperHeight
        let height_tabbar: CGFloat = Constants.csTabbarHeight
        let x: CGFloat = 0
        let y_tabbar: CGFloat = height_header
        
        self.csHeader.frame = CGRect(x: x, y: 0, width: width, height: height_header)
        self.csTabbar.frame = CGRect(x: x, y: y_tabbar, width: width, height: height_tabbar)
        
        self.csHeader.backgroundColor = UIColor.white
        self.csTabbar.backgroundColor = UIColor.white
        
        // tabbar 아래 선 추가
        self.csTabbar.layer.addBorder([.bottom], color: self.grayColor1, width: 1)
        
        self.view.addSubview(self.csHeader)
        self.view.addSubview(self.csTabbar)
        
        // header에 sidebar를 위한 toggle 버튼 달기
        let sideBtn = UIButton(type: .custom)
        sideBtn.frame.size = CGSize(width: 20, height: 20)
        self.csHeader.addSubview(sideBtn)
        sideBtn.snp.makeConstraints{ (make) in
            make.bottom.equalTo(self.csHeader).offset(-20)
            make.left.equalTo(self.csHeader).offset(20)
        }
  
        let iconMenu = UIImage(named: "iconBar")
        let newIconMenu = resizeImage(image: iconMenu!, toTheSize: CGSize(width: 20, height: 20))
        sideBtn.setImage(newIconMenu, for: .normal)
        sideBtn.layer.borderWidth = 1
        sideBtn.layer.borderColor = UIColor.red.cgColor
        
        // sidebar toggle 버튼의 label 달기
//        let sideBtnLabel = UILabel()
//        sideBtnLabel.font = UIFont.init(name: Constants.mainFontBold, size: 12)
//        sideBtnLabel.text = "메뉴"
//        sideBtnLabel.textColor = UIColor.white
//        sideBtnLabel.contentMode = .center
//        sideBtnLabel.addCharacterSpacing(kernValue: 1.5)
//        self.csHeader.addSubview(sideBtnLabel)
//        sideBtnLabel.snp.makeConstraints{ (make) in
//            make.top.equalTo(sideBtn.snp.bottom).offset(2)
//            make.centerX.equalTo(sideBtn.snp.centerX)
//        }
        
//        sideBtn.layer.borderWidth = 1
//        sideBtn.layer.borderColor = UIColor.red.cgColor
        
        if let revealVC = self.revealViewController() {
            sideBtn.addTarget(revealVC, action: #selector(revealVC.revealToggle(_:)), for: .touchUpInside)
            revealVC.rearViewRevealWidth = self.view.frame.size.width
            revealVC.rearViewRevealOverdraw = 0
        }
        
        // header에 새로 고침을 위한 버튼 달기
        let reloadBtn = UIButton(type: .custom)
        reloadBtn.frame.size = CGSize(width: 20, height: 20)
        csHeader.addSubview(reloadBtn)
        reloadBtn.snp.makeConstraints{(make) in
            make.right.equalTo(self.csHeader).offset(-20)
            make.bottom.equalTo(self.csHeader).offset(-20)
        }
        reloadBtn.addTarget(self, action: #selector(onReloadButtonClick(_:)), for: .touchUpInside)
        
        let iconReload = UIImage(named: "iconReload")
        let newIconReload = resizeImage(image: iconReload!, toTheSize: CGSize(width: 20, height: 20))
        reloadBtn.setImage(newIconReload, for: .normal)
        reloadBtn.layer.borderWidth = 1
        reloadBtn.layer.borderColor = UIColor.red.cgColor
        
        // reload 버튼의 label 달기
//        let reloadLabel = UILabel()
//        reloadLabel.font = UIFont.init(name: Constants.mainFontBold, size: 12)
//        reloadLabel.text = "새로고침"
//        reloadLabel.textColor = UIColor.white
//        reloadLabel.contentMode = .center
//        self.csHeader.addSubview(reloadLabel)
//        reloadLabel.snp.makeConstraints{ (make) in
//            make.top.equalTo(reloadBtn.snp.bottom).offset(2)
//            make.centerX.equalTo(reloadBtn.snp.centerX)
//        }
        
        // tabbar button 설정
        let tabBtnWidth = self.csTabbar.frame.width / self.tabCount
        let tabBtnHeight = self.csTabbar.frame.height - 1
        
        self.tabMain.frame = CGRect(x: 0, y: 0, width: tabBtnWidth, height: tabBtnHeight)
        self.tabCommunity.frame = CGRect(x: tabBtnWidth, y: 0, width: tabBtnWidth, height: tabBtnHeight)
        self.tabBoon.frame = CGRect(x: tabBtnWidth * 2, y: 0, width: tabBtnWidth, height: tabBtnHeight)
        
        self.addTabBarBtn(btn: self.tabMain, title: "검색어/뉴스", tag: 0)
        self.addTabBarBtn(btn: self.tabCommunity, title: "커뮤니티", tag: 1)
        self.addTabBarBtn(btn: self.tabBoon, title: "1분 카카오", tag: 2)
        
        self.delegate = self
        
        // background에서 메인 페이지 관련 API를 호출하여 로딩 지연 방지
//        self.getContents()
        
        // background에서 커뮤니티 관련 API를 호출하여 카뮤니티 탭으로 이동 시 로딩 지연 방지
        self.getCommunityContents()
        
        // main 선택
        self.onTabBarItemClick(self.tabMain)
    }
    
    override func viewWillAppear(_ animated: Bool){
        
        // app이 foreground로 왔을 때 설정
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification
        , object: nil)
    }
    
    @objc func willEnterForeground() {
        self.checkNetwork()
        self.getCommunityContents()
        print("ForeGround!!!")
    }
    
    func addTabBarBtn(btn: UIButton, title:String, tag:Int) {
        btn.setTitle(title, for: .normal)
        btn.tag = tag
        
        btn.setTitleColor(self.grayColor8, for: .normal)
        btn.setTitleColor(self.grayColor9, for: .selected)
        btn.titleLabel?.font = UIFont.init(name: Constants.mainFont, size: 14)
        btn.setBackgroundColor(.white, for: .selected)
        
        btn.addTarget(self, action: #selector(onTabBarItemClick(_:)), for: .touchUpInside)
        
        self.csTabbar.addSubview(btn)
    }
    
    @objc func onTabBarItemClick(_ sender: UIButton) {
        self.tabMain.isSelected = false
        self.tabCommunity.isSelected = false
        self.tabBoon.isSelected = false
        self.tabMain.layer.addBorder([UIRectEdge.bottom], color: UIColor.white, width: 3)
        self.tabCommunity.layer.addBorder([UIRectEdge.bottom], color: UIColor.white, width: 3)
        self.tabBoon.layer.addBorder([UIRectEdge.bottom], color: UIColor.white, width: 3)
        self.tabMain.titleLabel?.font = UIFont.init(name: Constants.mainFont, size: 14)
        self.tabCommunity.titleLabel?.font = UIFont.init(name: Constants.mainFont, size: 14)
        self.tabBoon.titleLabel?.font = UIFont.init(name: Constants.mainFont, size: 14)
        
        sender.isSelected = true
        sender.layer.addBorder([UIRectEdge.bottom], color: self.grayColor9, width: 3)
        sender.titleLabel?.font = UIFont.init(name: Constants.mainFontBold, size: 14)
        self.selectedIndex = sender.tag
        if sender.tag == 0 {
//            let naviVC = self.selectedViewController as! UINavigationController
//            let mainVC = naviVC.viewControllers.first as! MainVC
//            mainVC.naverKeyword = self.naverKeyword
//            mainVC.naverMainNews = self.naverMainNews
//            mainVC.naverEnterNews = self.naverEnterNews
//            mainVC.naverSportsNews = self.naverSportsNews
//            print("sender----------0")
//            print(self.naverSportsNews)
        }
        else if sender.tag == 1 {
            let naviVC = self.selectedViewController as! UINavigationController
            let communityVC = naviVC.viewControllers.first as! CommunityVC
            communityVC.cookContents = self.cookContents
            communityVC.ilbeContents = self.ilbeContents
            communityVC.instizContents = self.instizContents
            communityVC.ruliwebContents = self.ruliwebContents
            communityVC.clienContents = self.clienContents
            communityVC.namuContents = self.namuContents
            communityVC.ppomppuContents = self.ppomppuContents
            communityVC.nateContents = self.nateContents
            communityVC.fmContents = self.fmContents
            communityVC.bullpenContents = self.bullpenContents
            communityVC.theqooContents = self.theqooContents
        }
    }
    
    @objc func onReloadButtonClick(_ sender: UIButton) {
        if self.selectedIndex == 0 {
            let naviVC = self.selectedViewController as! UINavigationController
            let mainVC = naviVC.viewControllers.first as! MainVC
            mainVC.reload()
        } else if self.selectedIndex == 1 {
            let naviVC = self.selectedViewController as! UINavigationController
            let communityVC = naviVC.viewControllers.first as! CommunityVC
            communityVC.reload()
        } else if self.selectedIndex == 2 {
            let tabVC = self.selectedViewController as! UITabBarController
            if tabVC.selectedIndex == 0 {
                let naviVC = tabVC.viewControllers?.first as! UINavigationController
                let boonVC = naviVC.viewControllers.first as! BoonVC
                boonVC.reload()
            } else if tabVC.selectedIndex == 1 {
                let naviVC = tabVC.viewControllers?.last as! UINavigationController
                let boonViewVC = naviVC.viewControllers.first as! BoonViewVC
                boonViewVC.reload()
            }
        }
    }
    
    // MARK: - Navigation
    
    // Main 화면 Data Load
    func getContents() {
        let webContentManager = MainContentManager()
        DispatchQueue.global(qos: .background).async {
            webContentManager.getNaverKeyword {
                self.naverKeyword = webContentManager.naverKeyword
            }
            webContentManager.getNaverMainNews {
                self.naverMainNews = webContentManager.naverMainNews
            }
            webContentManager.getNaverEnterNews {
                self.naverEnterNews = webContentManager.naverEnterNews
            }
            webContentManager.getNaverSportsNews {
                self.naverSportsNews = webContentManager.naverSportsNews
            }
        }
    }
    
    // Community 화면 Data Load
    func getCommunityContents() {
        let communityWebContentManager = CommunityContentManager()
        DispatchQueue.global(qos: .background).async {
            communityWebContentManager.getCookContents {
                self.cookContents = communityWebContentManager.cookContents
            }
            communityWebContentManager.getIlbeContents {
                self.ilbeContents = communityWebContentManager.ilbeContents
            }
            communityWebContentManager.getNamuContents {
                self.namuContents = communityWebContentManager.namuContents
            }
            communityWebContentManager.getNateContents {
                self.nateContents = communityWebContentManager.nateContents
            }
            communityWebContentManager.getClienContents {
                self.clienContents = communityWebContentManager.clienContents
            }
            communityWebContentManager.getPpomppuContents {
                self.ppomppuContents = communityWebContentManager.ppomppuContents
            }
            communityWebContentManager.getRuliwebContents {
                self.ruliwebContents = communityWebContentManager.ruliwebContents
            }
            communityWebContentManager.getInstizContents {
                self.instizContents = communityWebContentManager.instizContents
            }
            communityWebContentManager.getFmContents {
                self.fmContents = communityWebContentManager.fmContents
            }
            communityWebContentManager.getBullpenContents {
                self.bullpenContents = communityWebContentManager.bullpenContents
            }
            communityWebContentManager.getTheqooContents {
                self.theqooContents = communityWebContentManager.theqooContents
            }
        }
    }
}


