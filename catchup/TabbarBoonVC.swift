//
//  TabbarBoonVC.swift
//  catchup
//
//  Created by PJW on 13/02/2020.
//  Copyright © 2020 PJW. All rights reserved.
//

import UIKit

class TabbarBoonVC: UITabBarController {
    
    // Tabbar Custom
    let csTabbar = UIView()
    
    let tabBoonContainer = UIView()
    let tabBoonViewContainer = UIView()
    let tabBoon = UIButton(type: .custom)
    let tabBoonView = UIButton(type: .custom)
    let tabCount: CGFloat = 2
    let tabBoonBottomBar = UIView()
    let tabBoonViewBottomBar = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        
        // 기존 tabbar 숨기기
        self.tabBar.isHidden = true
        
        // tabbar custom
        let width = self.view.frame.width
        let height_tabbar: CGFloat = Constants.csBoonTabbarHeight
        
        self.csTabbar.frame = CGRect(x: 0, y: 0, width: width, height: height_tabbar)
        self.csTabbar.backgroundColor = UIColor.white
        self.csTabbar.layer.addBorder([.bottom], color: self.grayColor1, width: 1)
        self.view.addSubview(self.csTabbar)
        
        
        let tabBtnWidth = self.csTabbar.frame.width / self.tabCount
        let tabBtnHeight = self.csTabbar.frame.height
        
        // tabbar button container 설정
        self.tabBoonContainer.frame = CGRect(x: 0, y: 0, width: tabBtnWidth, height: tabBtnHeight)
        self.tabBoonViewContainer.frame = CGRect(x: tabBtnWidth, y: 0, width: tabBtnWidth, height: tabBtnHeight)
        
        // tabbar button 설정
        self.tabBoon.frame = CGRect(x: 0, y: 0, width: tabBtnWidth, height: tabBtnHeight - 3)
        self.tabBoonView.frame = CGRect(x: 0, y: 0, width: tabBtnWidth, height: tabBtnHeight - 3)
        
        // tabbar button bottom bar 설정
        let barWidth = tabBtnWidth / 2
        self.tabBoonBottomBar.frame = CGRect(x: barWidth / 2, y: tabBtnHeight - 3, width: barWidth, height: 2)
        self.tabBoonViewBottomBar.frame = CGRect(x: barWidth / 2, y: tabBtnHeight - 3, width: barWidth, height: 2)
        self.tabBoonBottomBar.tag = 0
        self.tabBoonViewBottomBar.tag = 1
        
        self.tabBoonContainer.addSubview(self.tabBoon)
        self.tabBoonContainer.addSubview(self.tabBoonBottomBar)
        self.tabBoonViewContainer.addSubview(self.tabBoonView)
        self.tabBoonViewContainer.addSubview(self.tabBoonViewBottomBar)
        
        self.addTabBarBtn(btn: self.tabBoon, title: "실시간 인기 게시물", tag: 0)
        self.addTabBarBtn(btn: self.tabBoonView, title: "많이 본 게시물", tag: 1)
        self.csTabbar.addSubview(self.tabBoonContainer)
        self.csTabbar.addSubview(self.tabBoonViewContainer)
        
        // 실시간 인기 게시물 선택
        self.onTabBarItemClick(self.tabBoon)
    }
    
    override func viewWillLayoutSubviews() {
        // custom header, tabbar의 높이만큼 rootview 위치 및 높이 조정
        let screen = UIScreen.main.bounds
        let margin = self.upperHeight + Constants.csTabbarHeight
        self.view.frame.origin.y = margin
        self.view.frame.size.height = screen.size.height - margin
    }
    
    func addTabBarBtn(btn: UIButton, title:String, tag:Int) {
        btn.setTitle(title, for: .normal)
        btn.tag = tag
        
        btn.setTitleColor(self.grayColor6, for: .normal)
        btn.setTitleColor(self.grayColor8, for: .selected)
        btn.titleLabel?.font = UIFont.init(name: Constants.mainFont, size: 13)
        btn.setBackgroundColor(.white, for: .selected)
        
        btn.addTarget(self, action: #selector(onTabBarItemClick(_:)), for: .touchUpInside)
    }
    
    @objc func onTabBarItemClick(_ sender: UIButton) {
        self.tabBoon.isSelected = false
        self.tabBoonView.isSelected = false
        self.tabBoonBottomBar.backgroundColor = UIColor.white
        self.tabBoonViewBottomBar.backgroundColor = UIColor.white
        
        sender.isSelected = true
        self.selectedIndex = sender.tag
        switch sender.tag {
        case self.tabBoonBottomBar.tag:
            self.tabBoonBottomBar.backgroundColor = self.grayColor8
        case self.tabBoonViewBottomBar.tag:
            self.tabBoonViewBottomBar.backgroundColor = self.grayColor8
        default:
            ()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
