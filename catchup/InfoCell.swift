//
//  InfoCell.swift
//  catchup
//
//  Created by PJW on 05/05/2020.
//  Copyright © 2020 PJW. All rights reserved.
//

import UIKit

class InfoCell: UITableViewCell {
    
    var infoView: UIView!
    var infoLabel: UILabel!
    var container: UIView!
    var leftView: UIView!
    var centerView: UIView!
    var centerNView: UIView!
    var rightView: UIView!
    
    var leftImageView: UIImageView!
    var centerImageView: UIImageView!
    var centerNImageView: UIImageView!
    var rightImageView: UIImageView!
    var leftLabel: UILabel!
    var centerLabel: UILabel!
    var centerNLabel: UILabel!
    var rightLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func initCell() {
        self.infoView = UIView()
        self.infoLabel = UILabel()
        self.container = UIView()
        self.leftView = UIView()
        self.centerView = UIView()
        self.centerNView = UIView()
        self.rightView = UIView()
        self.leftImageView = UIImageView()
        self.centerImageView = UIImageView()
        self.centerNImageView = UIImageView()
        self.rightImageView = UIImageView()
        self.leftLabel = UILabel()
        self.centerLabel = UILabel()
        self.centerNLabel = UILabel()
        self.rightLabel = UILabel()
        
        self.infoLabel.font = UIFont.init(name: Constants.mainFontBold, size: 18)
        self.infoLabel.textColor = UIColor(red:0.29, green:0.31, blue:0.34, alpha:1.0)
        self.infoLabel.textAlignment = .left
        self.infoLabel.text = "생활 정보"
        
        self.leftLabel.font = UIFont.init(name: Constants.mainFont, size: 12)
        self.centerLabel.font = UIFont.init(name: Constants.mainFont, size: 12)
        self.centerNLabel.font = UIFont.init(name: Constants.mainFont, size: 12)
        self.rightLabel.font = UIFont.init(name: Constants.mainFont, size: 12)
        
        self.leftLabel.textColor = UIColor(red:0.29, green:0.31, blue:0.34, alpha:1.0)
        self.centerLabel.textColor = UIColor(red:0.29, green:0.31, blue:0.34, alpha:1.0)
        self.centerNLabel.textColor = UIColor(red:0.29, green:0.31, blue:0.34, alpha:1.0)
        self.rightLabel.textColor = UIColor(red:0.29, green:0.31, blue:0.34, alpha:1.0)
        
        self.leftLabel.textAlignment = .center
        self.centerLabel.textAlignment = .center
        self.centerNLabel.textAlignment = .center
        self.rightLabel.textAlignment = .center
        
        self.leftLabel.text = "별자리운세"
        self.centerLabel.text = "띠별운세"
        self.centerNLabel.text = "타로"
        self.rightLabel.text = "기타"
        
    }

}
