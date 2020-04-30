//
//  WeatherCell.swift
//  catchup
//
//  Created by PJW on 28/04/2020.
//  Copyright © 2020 PJW. All rights reserved.
//

import UIKit
import SnapKit

class WeatherCell: UITableViewCell {
    
    var containerView: UIView!
    var iconImage: UIImageView!
    var iconLabel: UILabel!
    var curNum: UILabel!
    var mmNum: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func initCell() {
        self.containerView = UIView()
        self.iconImage = UIImageView()
        self.iconLabel = UILabel()
        self.curNum = UILabel()
        self.mmNum = UILabel()
        
        let totalWidth = self.contentView.frame.width - (10 * 2)
        let totalHeight = self.contentView.frame.height - 20
        
        self.containerView.frame = CGRect(x: 10, y: 20, width: totalWidth, height: totalHeight)
        
        // 배경 그라이데이션 설정
//        let gradient = CAGradientLayer()
//        gradient.frame = self.containerView.bounds
//        gradient.startPoint = CGPoint(x: 0, y: 0)
//        gradient.endPoint = CGPoint(x: 1, y: 1)
//
//        gradient.colors = [
//            UIColor(red: 0.82, green: 0.99, blue: 1.00, alpha: 1.00).cgColor,
//            UIColor(red: 0.99, green: 0.86, blue: 0.57, alpha: 1.00).cgColor
//        ]
//        self.containerView.layer.addSublayer(gradient)
        
        self.iconImage.contentMode = .scaleAspectFit
        
        self.iconLabel.font = UIFont.init(name: Constants.mainFont, size: 21)
        self.curNum.font = UIFont.init(name: Constants.mainFont, size: 21)
        self.mmNum.font = UIFont.init(name: Constants.mainFont, size: 16)
        
//        self.mmNum.textColor = UIColor(red:0.53, green:0.56, blue:0.59, alpha:1.0)
        self.iconLabel.textColor = UIColor.black
        self.curNum.textColor = UIColor.black
        self.mmNum.textColor = UIColor.black
        
        self.curNum.textAlignment = .left
        self.mmNum.textAlignment = .right

        self.curNum.text = "17"
        self.mmNum.text = "21 / 7"
        self.iconLabel.text = "서울 맑음"
        
        self.containerView.addSubview(self.iconImage)
        self.containerView.addSubview(self.iconLabel)
        self.containerView.addSubview(self.curNum)
        self.containerView.addSubview(self.mmNum)
        
        self.contentView.addSubview(self.containerView)
        
        self.iconImage.snp.makeConstraints { (make) in
            make.left.equalTo(self.containerView).offset(10)
            make.top.equalTo(self.containerView).offset(25)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        self.iconLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.iconImage.snp.right).offset(20)
            make.centerY.equalTo(self.containerView)
        }
        
        self.mmNum.snp.makeConstraints { (make) in
            make.right.equalTo(self.containerView).offset(-15)
            make.centerY.equalTo(self.containerView).offset(2)
        }
        
        self.curNum.snp.makeConstraints { (make) in
            make.right.equalTo(self.mmNum.snp.left).offset(-15)
            make.centerY.equalTo(self.containerView)
        }
    }
    
    func setCell(_ icon: UIImage, _ infoText: String, _ curText: String, _ mmText: String) {
        
        self.iconImage.image = icon
        self.iconLabel.text = infoText
        self.curNum.text = curText
        self.mmNum.text = mmText
    }

}
