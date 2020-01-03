//
//  KeywordCell.swift
//  catchup
//
//  Created by PJW on 02/01/2020.
//  Copyright © 2020 PJW. All rights reserved.
//

import UIKit
import Kanna

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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // scrollView 설정
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        
        self.scrollView.isPagingEnabled = true
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSize(width: CGFloat(self.pageSize) * self.contentView.frame.maxX, height: 0)
        
        // pageControll 설정
        self.pageControll.snp.makeConstraints{ (make) in
            make.bottom.equalTo(self.scrollView).offset(-5)
        }
        self.pageControll.numberOfPages = 2
        self.pageControll.currentPage = 0
        self.pageControll.isUserInteractionEnabled = false
        self.pageControll.pageIndicatorTintColor = UIColor(red:0.87, green:0.89, blue:0.90, alpha:1.0)
        self.pageControll.currentPageIndicatorTintColor = UIColor(red:0.31, green:0.53, blue:0.27, alpha:1.0)
        
        // keywordContentView 설정
        let pageWidth = self.contentView.frame.maxX
        let pageHeight = self.contentView.frame.maxY - 40
        
        self.keywordContentView1.frame = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        self.keywordContentView2.frame = CGRect(x: pageWidth, y: 0, width: pageWidth, height: pageHeight)
        
        self.scrollView.addSubview(self.keywordContentView1)
        self.scrollView.addSubview(self.keywordContentView2)
        self.contentView.addSubview(self.pageControll)

        
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
       //view.layer.borderWidth = 1
       //view.layer.borderColor = UIColor.blue.cgColor
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
       //numLabel.layer.borderColor = UIColor.green.cgColor
       //numLabel.layer.borderWidth = 1
       
       titleLabel.textAlignment = .left
       titleLabel.font = UIFont.systemFont(ofSize: 12)
       //titleLabel.layer.borderColor = UIColor.red.cgColor
       //titleLabel.layer.borderWidth = 1
       
       superView.addSubview(numLabel)
       superView.addSubview(titleLabel)
       
       numLabel.snp.makeConstraints { (make) in
           make.left.equalTo(superView).offset(leftOffset)
           make.height.equalTo(superView.frame.height)
           make.width.equalTo(numLabelWidth)
       }
       
       titleLabel.snp.makeConstraints { (make) in
           make.left.equalTo(numLabel.snp.right).offset(rightOffset)
           make.height.equalTo(superView.frame.height)
       }
   }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if fmod(scrollView.contentOffset.x, scrollView.frame.maxX) == 0 {
            self.pageControll.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
        }
    }

}
