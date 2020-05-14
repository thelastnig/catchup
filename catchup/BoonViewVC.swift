//
//  BoonVC.swift
//  catchup
//
//  Created by PJW on 13/01/2020.
//  Copyright © 2020 PJW. All rights reserved.
//

import UIKit
import AVFoundation
import SafariServices
import SnapKit
import GoogleMobileAds

class BoonViewVC: UICollectionViewController {
    
    lazy var boonContentsView: [(title: String, url: String, imgUrl: String, imgHeight: Int, id: String)] = {
        var list = [(String, String, String, Int, String)]()
        return list
    }()
    
    var boonImages: Array<UIImage> = []
    
    // refreshcontroll 설정
    private let refreshControl = UIRefreshControl()
    
    // 구글 애드몹 배너 객체 선언
    var bannerView: GADBannerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네트워크 연결 확인
        network.reachability.whenUnreachable = { reachability in
            self.checkNetwork()
        }
        
        // collectionView 환경 설정
        self.collectionView.backgroundColor = .white
        self.collectionView.contentInset = UIEdgeInsets(top: 23, left: 10, bottom: 10, right: 10)

        let webContentManager = BoonContentManager()
        webContentManager.getBoonContentsView {
            self.boonContentsView = webContentManager.boonContentsView
            self.collectionView.reloadData()
        }
        
        // 아이템 간격을 0으로 초기화
        let flow = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = 0
        
        // 구글 애드몹 달기
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        self.addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewWillLayoutSubviews() {
        // custom header, tabbar의 높이만큼 rootview 위치 및 높이 조정
        let screen = UIScreen.main.bounds
        let margin = Constants.csBoonTabbarHeight
        let marginHeight = Constants.csBoonTabbarHeight + Constants.csTabbarHeight + self.upperHeight
        self.view.frame.origin.y = margin
        self.view.frame.size.height = screen.size.height - marginHeight
    }

    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.boonContentsView.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "boon_cell", for: indexPath) as! BoonCell
        
        let data = self.boonContentsView[indexPath.item]
                
        // 마지막 셀 설정
        if data.id == "last" {
            cell.frame.size = CGSize(width: 0, height: 0)
            return cell
        } else {
            // imageView 설정 (위치, 크기)
            let itemWidth = (self.collectionView.frame.width - (self.collectionView.contentInset.left + self.collectionView.contentInset.right + 10)) / 2
            let itemHeight = itemWidth * Constants.boonHeightRatio / Constants.boonWidthRatio
            let imageViewHeight = itemWidth * Constants.boonImageHeightRatio / Constants.boonWidthRatio

            let verticalMargin = itemWidth > 190 ? Constants.boonLabelVerticalMargin : Constants.boonLabelVerticalMarginS
            cell.imageView.frame.size = CGSize(width: itemWidth, height: imageViewHeight)
            cell.imageView.frame.origin = CGPoint(x: 0, y: 0)
            cell.imageView.layer.borderColor = self.grayColor1.cgColor
            cell.imageView.layer.borderWidth = 1
            
            // containerView 설정
            cell.containerView.frame.size = CGSize(width: itemWidth, height: itemHeight - imageViewHeight)
            cell.containerView.frame.origin = CGPoint(x: 0, y: imageViewHeight)
            
            // lableSource 설정
            cell.labelSource.text = "많이 본 게시물 \(indexPath.row + 1)"
            cell.labelSource.textColor = self.grayColor6
            cell.labelSource.font = UIFont.init(name: Constants.mainFont, size: 11)
            cell.labelSource.frame.size.width = itemWidth - (Constants.boonLabelHorizontalMargin * 2)
            cell.labelSource.frame.size.height = 21
            cell.labelSource.frame.origin = CGPoint(x:0 , y: verticalMargin)
            
            // lableTitle 설정
            cell.labelTitle.text = data.title
            cell.labelTitle.textColor = self.grayColor9
            cell.labelTitle.font = UIFont.init(name: Constants.mainFont, size: 13)
            
            cell.labelTitle.frame.size.width = itemWidth - (Constants.boonLabelHorizontalMargin * 2)
            cell.labelTitle.frame.size.height = 42
            cell.labelTitle.frame.origin =
            CGPoint(x:0 , y: cell.labelSource.frame.height + (verticalMargin))
            
            // 이미지 다운로드 및 배열에 저장
            let path = data.imgUrl

            let task = URLSession.shared.dataTask(with: URL(string: path)!) {
                data, response, error in
                let imageData = data!

                DispatchQueue.main.async {
                    cell.imageView.image = UIImage(data: imageData)
                }
            }
            task.resume()
            
            return cell
        }
    }
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = self.boonContentsView[indexPath.item]
        let url = data.url
        
        // safariViewController 생성 및 설정
        let config = SFSafariViewController.Configuration()
        config.barCollapsingEnabled = false
        let safariViewController = SFSafariViewController(url: URL(string: url)!, configuration: config)
        safariViewController.dismissButtonStyle = .close
        
        self.navigationController?.present(safariViewController, animated: true, completion: nil)
    }
    
    @objc func pullToRefresh(_ sender: Any) {
        let webContentManager = BoonContentManager()
        webContentManager.getBoonContentsView {
            self.boonContentsView = webContentManager.boonContentsView
            self.collectionView.reloadData()
        }
        
        self.dispatchDelay(delay: Constants.delayTime) {
            // 당겨서 새로고침 종료
           self.refreshControl.endRefreshing()
        }
    }
    
    func reload() {
        let activityIndicator = ActivityIndicator(view: self.view, navigationController: self.navigationController, tabBarController: nil, upperHeight: self.upperHeight)
        activityIndicator.showActivityIndicator(text: "로딩 중")
        let indexPath = IndexPath(row: 0, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
        let webContentManager = BoonContentManager()
        webContentManager.getBoonContentsView {
            self.boonContentsView = webContentManager.boonContentsView
            self.collectionView.reloadData()
        }
        self.dispatchDelay(delay: Constants.delayTime) {
            activityIndicator.stopActivityIndicator()
        }
    }

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
                    
    // 구글 애드몹 배너 설정 메소드
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(bannerView)
//        self.view.bringSubviewToFront(bannerView)
        self.view.insertSubview(bannerView, at: self.view.subviews.count)
        self.view.addConstraints(
        [NSLayoutConstraint(item: bannerView,
                            attribute: .bottom,
                            relatedBy: .equal,
                            toItem: bottomLayoutGuide,
                            attribute: .top,
                            multiplier: 1,
                            constant: 0),
         NSLayoutConstraint(item: bannerView,
                            attribute: .centerX,
                            relatedBy: .equal,
                            toItem: view,
                            attribute: .centerX,
                            multiplier: 1,
                            constant: 0)
        ])
     }

}

// collectionView Item의 크기를 설정하는 추가 함수들
extension BoonViewVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (self.collectionView.frame.width - (self.collectionView.contentInset.left + self.collectionView.contentInset.right + Constants.boonItemDistance)) / 2
        let itemHeight = itemWidth * Constants.boonHeightRatio / Constants.boonWidthRatio
        let data = self.boonContentsView[indexPath.item]
        if data.id == "last" {
            return CGSize(width: itemWidth, height: 0)
        } else {
            return CGSize(width: itemWidth, height: itemHeight)
        }
    }
}


