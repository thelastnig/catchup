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

class BoonVC: UICollectionViewController {
    
    lazy var boonContents: [(title: String, url: String, imgUrl: String, imgHeight: Int)] = {
        var list = [(String, String, String, Int)]()
        return list
    }()
    
    var boonImages: Array<UIImage> = []
    
    // refreshcontroll 설정
    private let refreshControl = UIRefreshControl()

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
        webContentManager.getBoonContents {
            self.boonContents = webContentManager.boonContents
            self.collectionView.reloadData()
        }
        
        // 당겨서 새로고침
        self.refreshControl.tintColor = mainColor
        self.refreshControl.center.x = self.collectionView.center.x
        
        let attributes = [NSAttributedString.Key.foregroundColor: mainColor]
        self.refreshControl.attributedTitle = NSAttributedString(string: "페이지 새로고침 중", attributes: attributes)
        
        self.refreshControl.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
        
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.refreshControl = self.refreshControl
        
        // 아이템 간격을 0으로 초기화
        let flow = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewWillLayoutSubviews() {
        // custom header, tabbar의 높이만큼 rootview 위치 조정
        self.view.frame.origin.y = Constants.csHeaderHeight + Constants.csTabbarHeight - (self.navigationController?.navigationBar.frame.height)!
    }

    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.boonContents.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "boon_cell", for: indexPath) as! BoonCell
        
        let data = self.boonContents[indexPath.item]
        
        // contentView 설정 (외곽선)
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = self.grayColor2.cgColor
        
        // imageView 설정 (위치, 크기)
        let itemWidth = (self.collectionView.frame.width - (self.collectionView.contentInset.left + self.collectionView.contentInset.right + 10)) / 2
        let itemHeight = itemWidth * Constants.boonHeightRatio / Constants.boonWidthRatio
        let imageViewHeight = itemWidth * Constants.boonImageHeightRatio / Constants.boonWidthRatio

        let verticalMargin = itemWidth > 190 ? Constants.boonLabelVerticalMargin : Constants.boonLabelVerticalMarginS
        cell.imageView.frame.size = CGSize(width: itemWidth, height: imageViewHeight)
        cell.imageView.frame.origin = CGPoint(x: 0, y: 0)
        
        // containerView 설정
        cell.containerView.frame.size = CGSize(width: itemWidth, height: itemHeight - imageViewHeight)
        cell.containerView.frame.origin = CGPoint(x: 0, y: imageViewHeight)
        
        // lableTitle 설정
        cell.labelTitle.text = data.title
        cell.labelTitle.textColor = UIColor.black
        cell.labelTitle.font = UIFont.systemFont(ofSize: 13)
        
        cell.labelTitle.frame.size.width = itemWidth - (Constants.boonLabelHorizontalMargin * 2)
        cell.labelTitle.frame.size.height = 42
        cell.labelTitle.frame.origin = CGPoint(x:Constants.boonLabelHorizontalMargin , y: verticalMargin)
        
        // labelTitle, labelSource 사이의 line 설정
        let line = UIView()
        line.frame.size = CGSize(width: 30, height: 1)
        line.backgroundColor = UIColor.lightGray
        cell.containerView.addSubview(line)
        
        line.frame.origin = CGPoint(x: Constants.boonLabelHorizontalMargin, y: cell.labelTitle.frame.height +  (verticalMargin * 2))
        
        // lableSource 설정
        cell.labelSource.text = "실시간 인기 게시물 \(indexPath.row + 1)"
        cell.labelSource.textColor = UIColor.lightGray
        cell.labelSource.font = UIFont.boldSystemFont(ofSize: 12)
        
        cell.labelSource.frame.size.width = itemWidth - (Constants.boonLabelHorizontalMargin * 2)
        cell.labelSource.frame.size.height = 21
        cell.labelSource.frame.origin = CGPoint(x:Constants.boonLabelHorizontalMargin , y: cell.labelTitle.frame.height + (verticalMargin * 3) + 1)
        
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
        let data = self.boonContents[indexPath.item]
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
        webContentManager.getBoonContents {
            self.boonContents = webContentManager.boonContents
            self.collectionView.reloadData()
        }
        
        self.dispatchDelay(delay: Constants.delayTime) {
            // 당겨서 새로고침 종료
           self.refreshControl.endRefreshing()
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

}

// collectionView Item의 크기를 설정하는 추가 함수들
extension BoonVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (self.collectionView.frame.width - (self.collectionView.contentInset.left + self.collectionView.contentInset.right + Constants.boonItemDistance)) / 2
        let itemHeight = itemWidth * Constants.boonHeightRatio / Constants.boonWidthRatio
      return CGSize(width: itemWidth, height: itemHeight)
    }
}


