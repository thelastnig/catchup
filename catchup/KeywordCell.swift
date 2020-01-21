//
//  KeywordCell.swift
//  catchup
//
//  Created by PJW on 02/01/2020.
//  Copyright © 2020 PJW. All rights reserved.
//

import UIKit
import SnapKit

class KeywordCell: UITableViewCell, UIScrollViewDelegate {
    let pageSize = 2
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControll: UIPageControl!
    @IBOutlet var keywordContentView1: UIView!
    @IBOutlet var keywordContentView2: UIView!
    
    @IBOutlet var keywordLabel01: UIView!
    @IBOutlet var keywordLabel02: UIView!
    @IBOutlet var keywordLabel03: UIView!
    @IBOutlet var keywordLabel04: UIView!
    @IBOutlet var keywordLabel05: UIView!
    @IBOutlet var keywordLabel06: UIView!
    @IBOutlet var keywordLabel07: UIView!
    @IBOutlet var keywordLabel08: UIView!
    @IBOutlet var keywordLabel09: UIView!
    @IBOutlet var keywordLabel10: UIView!
    
    @IBOutlet var keywordLabel01_2: UIView!
    @IBOutlet var keywordLabel02_2: UIView!
    @IBOutlet var keywordLabel03_2: UIView!
    @IBOutlet var keywordLabel04_2: UIView!
    @IBOutlet var keywordLabel05_2: UIView!
    @IBOutlet var keywordLabel06_2: UIView!
    @IBOutlet var keywordLabel07_2: UIView!
    @IBOutlet var keywordLabel08_2: UIView!
    @IBOutlet var keywordLabel09_2: UIView!
    @IBOutlet var keywordLabel10_2: UIView!
    
    var cellKeywordViews: Array<UIView> = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // scrollView 설정
        self.scrollView.delegate = self

        // 각 view를 배열에 담기
        self.cellKeywordViews = [
            self.keywordLabel01, self.keywordLabel02,
            self.keywordLabel03, self.keywordLabel04,
            self.keywordLabel05, self.keywordLabel06,
            self.keywordLabel07, self.keywordLabel08,
            self.keywordLabel09, self.keywordLabel10,
            self.keywordLabel01_2, self.keywordLabel02_2,
            self.keywordLabel03_2, self.keywordLabel04_2,
            self.keywordLabel05_2, self.keywordLabel06_2,
            self.keywordLabel07_2, self.keywordLabel08_2,
            self.keywordLabel09_2, self.keywordLabel10_2
        ]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // NAVER keyword view setting function
    func setKeywordView(view: UIView, superView: UIView) {
        let keywordViewHeight = superView.frame.height / 5
        let keywordViewWidth = superView.frame.width / 2

        view.frame.size.width = keywordViewWidth
        view.frame.size.height = keywordViewHeight
        if view.tag < 6 {
           view.frame.origin.x = 0
           view.frame.origin.y = CGFloat(view.tag - 1) * keywordViewHeight
        } else {
           view.frame.origin.x = keywordViewWidth
           view.frame.origin.y = CGFloat(view.tag - 6) * keywordViewHeight
        }
        view.backgroundColor = UIColor.white
        superView.addSubview(view)
   }
   
   func setKeywordLabels(_ superView: UIView, _ numLabel: UILabel, _ titleLabel: UILabel) {

        let leftOffset: CGFloat = 10
        let rightOffset: CGFloat = 10
        let numLabelWidth: CGFloat = 20

        /*
        numLabel.frame = CGRect(x: 0, y: 0, width: numLabelWidth, height: superView.frame.height)
        */
        numLabel.textAlignment = .left
        numLabel.textColor = UIColor.brown
        numLabel.font = UIFont.boldSystemFont(ofSize: 12)

        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.lineBreakMode = .byTruncatingTail

        superView.addSubview(numLabel)
        superView.addSubview(titleLabel)

        numLabel.snp.makeConstraints { (make) in
           make.left.equalTo(superView).offset(leftOffset)
           make.height.equalTo(superView.frame.height)
           make.width.equalTo(numLabelWidth)
        }

        titleLabel.snp.makeConstraints { (make) in
           make.left.equalTo(numLabel.snp.right).offset(rightOffset)
           make.right.equalTo(superView).offset(-rightOffset)
           make.height.equalTo(superView.frame.height)
        }
       
   }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if fmod(scrollView.contentOffset.x, scrollView.frame.width) == 0 {
            self.pageControll.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        }
    }

}
