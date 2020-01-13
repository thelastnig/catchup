//
//  BoonVC.swift
//  catchup
//
//  Created by PJW on 13/01/2020.
//  Copyright © 2020 PJW. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class BoonVC: UICollectionViewController {
    
    lazy var boonContents: [(title: String, url: String, imgUrl: String)] = {
        var list = [(String, String, String)]()
        return list
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        let webContentManager = BoonContentManager()
        webContentManager.getBoonContents {
            self.boonContents = webContentManager.boonContents
            self.collectionView.reloadData()
        }
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
        
        let data = self.boonContents[indexPath.row]
        
        cell.labelTitle.text = data.title
        cell.labelTitle.textColor = UIColor.white
        cell.labelTitle.font = UIFont.systemFont(ofSize: 13)
        
        // 이미지 다운로드 및 설정
        
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
        let data = self.boonContents[indexPath.row]
        let url = data.url
        
        let contentVC = self.storyboard?.instantiateViewController(identifier: "contentVC") as! ContentVC
        
        contentVC.url = url
        self.navigationController?.pushViewController(contentVC, animated: true)
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
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 1) / 2
        let height: CGFloat = 200
        
        return CGSize(width: width, height: height)

    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }

    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}
