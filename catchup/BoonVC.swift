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

class BoonVC: UICollectionViewController {
    
    lazy var boonContents: [(title: String, url: String, imgUrl: String, imgHeight: Int)] = {
        var list = [(String, String, String, Int)]()
        return list
    }()
    
    var boonImages: Array<UIImage> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = self.collectionView.collectionViewLayout as! PinterestLayout
        layout.delegate = self
        
        // collectionView 환경 설정
        self.collectionView.backgroundColor = .white
        self.collectionView.contentInset = UIEdgeInsets(top: 23, left: 8, bottom: 10, right: 8)

        let webContentManager = BoonContentManager()
        webContentManager.getBoonContents {
            self.boonContents = webContentManager.boonContents
            self.collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func getRandomColor()-> UIColor? {
        let color1 = UIColor(red:0.39, green:0.90, blue:0.70, alpha:1.0)
        let color2 = UIColor(red:0.55, green:0.91, blue:0.60, alpha:1.0)
        let color3 = UIColor(red:0.75, green:0.92, blue:0.46, alpha:1.0)
        let color4 = UIColor(red:0.13, green:0.79, blue:0.59, alpha:1.0)
        let color5 = UIColor(red:0.32, green:0.81, blue:0.40, alpha:1.0)
        let color6 = UIColor(red:0.58, green:0.85, blue:0.18, alpha:1.0)
        let colors = [color1, color2, color3, color4, color5, color6]
        
        return colors.randomElement()!
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
        
        cell.labelTitle.text = data.title
        cell.labelTitle.textColor = UIColor.black
        cell.labelTitle.font = UIFont.systemFont(ofSize: 13)
        
        cell.containerView.backgroundColor = self.getRandomColor()
        
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
        let itemSize = (self.collectionView.frame.width - (self.collectionView.contentInset.left + self.collectionView.contentInset.right + 10)) / 2
      return CGSize(width: itemSize, height: itemSize)
    }
}

extension BoonVC: PinterestLayoutDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        let height = self.boonContents[indexPath.item].imgHeight

        let randomHeights: Array<CGFloat> = [25, 50, 75]
        return CGFloat(height) + randomHeights.randomElement()!
    }
}

