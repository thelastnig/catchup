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

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        self.csHeader.backgroundColor = self.mainColor
        self.csTabbar.backgroundColor = UIColor.white
        
        // tabbar 아래 선 추가
        self.csTabbar.layer.addBorder([.bottom], color: self.grayColor1, width: 1)
        
        self.view.addSubview(self.csHeader)
        self.view.addSubview(self.csTabbar)
        
        // header에 sidebar를 위한 toggle 버튼 달기
        let sideBtn = UIButton(type: .system)
        sideBtn.frame = CGRect(x: 10, y: self.statusHeight + 5, width: 30, height: 30)
        sideBtn.setTitle("A", for: .normal)
        csHeader.addSubview(sideBtn)
        
        if let revealVC = self.revealViewController() {
            sideBtn.addTarget(revealVC, action: #selector(revealVC.revealToggle(_:)), for: .touchUpInside)
            revealVC.rearViewRevealWidth = self.view.frame.size.width
            revealVC.rearViewRevealOverdraw = 0
        }
        
        // header에 새로 고침을 위한 버튼 달기
        let reloadBtn = UIButton(type: .system)
        reloadBtn.frame.size = CGSize(width: 100, height: 30)
        reloadBtn.setTitle("RELOAD", for: .normal)
        csHeader.addSubview(reloadBtn)
        reloadBtn.snp.makeConstraints{(make) in
            make.right.equalTo(self.csHeader).offset(-10)
            make.bottom.equalTo(self.csHeader).offset(-10)
        }
        reloadBtn.addTarget(self, action: #selector(onReloadButtonClick(_:)), for: .touchUpInside)
        
        // tabbar button 설정
        let tabBtnWidth = self.csTabbar.frame.width / self.tabCount
        let tabBtnHeight = self.csTabbar.frame.height - 1
        
        self.tabMain.frame = CGRect(x: 0, y: 0, width: tabBtnWidth, height: tabBtnHeight)
        self.tabCommunity.frame = CGRect(x: tabBtnWidth, y: 0, width: tabBtnWidth, height: tabBtnHeight)
        self.tabBoon.frame = CGRect(x: tabBtnWidth * 2, y: 0, width: tabBtnWidth, height: tabBtnHeight)
        
        self.addTabBarBtn(btn: self.tabMain, title: "Main", tag: 0)
        self.addTabBarBtn(btn: self.tabCommunity, title: "Community", tag: 1)
        self.addTabBarBtn(btn: self.tabBoon, title: "Boon", tag: 2)
        
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
        
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.setTitleColor(self.subColor, for: .selected)
        btn.titleLabel?.font = UIFont.init(name: "AppleSDGothicNeo-Bold", size: 14)
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
        
        sender.isSelected = true
        sender.layer.addBorder([UIRectEdge.bottom], color: self.mainColor, width: 3)
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
        }
    }
    
    @objc func onReloadButtonClick(_ sender: UIButton) {
        let indexPath = IndexPath(row: 0, section: 0)
        if self.selectedIndex == 0 {
            let naviVC = self.selectedViewController as! UINavigationController
            let mainVC = naviVC.viewControllers.first as! MainVC
            mainVC.tableView.reloadData()
            mainVC.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        } else if self.selectedIndex == 1 {
            let naviVC = self.selectedViewController as! UINavigationController
            let communityVC = naviVC.viewControllers.first as! CommunityVC
            communityVC.tableView.reloadData()
            communityVC.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        } else if self.selectedIndex == 2 {
            let tabVC = self.selectedViewController as! UITabBarController
            if tabVC.selectedIndex == 0 {
                let naviVC = tabVC.viewControllers?.first as! UINavigationController
                let boonVC = naviVC.viewControllers.first as! BoonVC
                boonVC.collectionView.reloadData()
                boonVC.collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
            } else if tabVC.selectedIndex == 1 {
                let naviVC = tabVC.viewControllers?.last as! UINavigationController
                let boonViewVC = naviVC.viewControllers.first as! BoonViewVC
                boonViewVC.collectionView.reloadData()
                boonViewVC.collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
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
        }
    }
}
