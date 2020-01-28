//
//  TabbarVC.swift
//  catchup
//
//  Created by PJW on 22/01/2020.
//  Copyright © 2020 PJW. All rights reserved.
//

import UIKit

class TabbarVC: UITabBarController, UITabBarControllerDelegate {
    
    // 메인 페이지를 위한 변수 설정
    
    
    // 커뮤니티 탭을 위한 변수 설정
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
    
    lazy var ppomppuContents: [(title: String, url: String)] = {
        var list = [(String, String)]()
        return list
    }()
    
    lazy var nateContents: [(title: String, url: String)] = {
        var list = [(String, String)]()
        return list
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        // background에서 메인 페이지 관련 API를 호출하여 로딩 지연 방지
        
        // background에서 커뮤니티 관련 API를 호출하여 카뮤니티 탭으로 이동 시 로딩 지연 방지
        self.getCommunityContents()
    }
    
    override func viewWillAppear(_ animated: Bool){ NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification
        , object: nil)
    }
    
    @objc func willEnterForeground() {
        self.getCommunityContents()
        print("ForeGround!!!")
    }
    

    // MARK: - Navigation

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController.selectedIndex == 1 {
            let naviVC = viewController as! UINavigationController
            let communityVC = naviVC.viewControllers.first as! CommunityVC
            communityVC.cookContents = self.cookContents
            communityVC.ilbeContents = self.ilbeContents
            communityVC.instizContents = self.instizContents
            communityVC.ruliwebContents = self.ruliwebContents
            communityVC.clienContents = self.clienContents
            communityVC.namuContents = self.namuContents
            communityVC.ppomppuContents = self.ppomppuContents
            communityVC.nateContents = self.nateContents
        }
    }
    
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
        }
    }
}
