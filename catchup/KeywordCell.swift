//
//  KeywordCell.swift
//  catchup
//
//  Created by PJW on 02/01/2020.
//  Copyright © 2020 PJW. All rights reserved.
//

import UIKit

class KeywordCell: UITableViewCell {
    @IBOutlet var keywordContentView: UIView!
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = UIColor(red:0.97, green:0.98, blue:0.98, alpha:1.0)
        /*
        // keywordLabel 설정
        self.keywordLabel01.tag = 1
        self.setKeywordView(view: self.keywordLabel01)
        self.keywordLabel02.tag = 2
        self.setKeywordView(view: self.keywordLabel02)
        self.keywordLabel03.tag = 3
        self.setKeywordView(view: self.keywordLabel03)
        self.keywordLabel04.tag = 4
        self.setKeywordView(view: self.keywordLabel04)
        self.keywordLabel05.tag = 5
        self.setKeywordView(view: self.keywordLabel05)
        self.keywordLabel06.tag = 6
        self.setKeywordView(view: self.keywordLabel06)
        self.keywordLabel07.tag = 7
        self.setKeywordView(view: self.keywordLabel07)
        self.keywordLabel08.tag = 8
        self.setKeywordView(view: self.keywordLabel08)
        self.keywordLabel09.tag = 9
        self.setKeywordView(view: self.keywordLabel09)
        self.keywordLabel10.tag = 10
        self.setKeywordView(view: self.keywordLabel10)
        */
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // NAVER keyword view setting function
   func setKeywordView(view: UIView) {
       let keywordViewHeight = self.keywordContentView.frame.height / 5
       let keywordViewWidth = self.keywordContentView.frame.width / 2

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
       self.keywordContentView.addSubview(view)
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

}
