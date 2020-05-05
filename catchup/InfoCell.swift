//
//  InfoCell.swift
//  catchup
//
//  Created by PJW on 05/05/2020.
//  Copyright © 2020 PJW. All rights reserved.
//

import UIKit

class InfoCell: UITableViewCell {
    
    var infoLabel: UILabel!
    var container: UIView!
    var leftView: UIView!
    var centerView: UIView!
    var rightView: UIView!
    
    var leftImageView: UIImageView!
    var centerImageView: UIImageView!
    var rightImageView: UIImageView!
    var leftLabel: UILabel!
    var centerLabel: UILabel!
    var rightLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func initCell() {
        self.infoLabel = UILabel()
        self.container = UIView()
        self.leftView = UIView()
        self.centerView = UIView()
        self.rightView = UIView()
        self.leftImageView = UIImageView()
        self.centerImageView = UIImageView()
        self.rightImageView = UIImageView()
        self.leftLabel = UILabel()
        self.centerLabel = UILabel()
        self.rightLabel = UILabel()
        
        self.leftLabel.font = UIFont.init(name: Constants.mainFont, size: 16)
        self.centerLabel.font = UIFont.init(name: Constants.mainFont, size: 16)
        self.rightLabel.font = UIFont.init(name: Constants.mainFont, size: 16)
        
        self.leftLabel.textColor = UIColor(red:0.29, green:0.31, blue:0.34, alpha:1.0)
        self.centerLabel.textColor = UIColor(red:0.29, green:0.31, blue:0.34, alpha:1.0)
        self.rightLabel.textColor = UIColor(red:0.29, green:0.31, blue:0.34, alpha:1.0)
        
        self.leftLabel.textAlignment = .center
        self.centerLabel.textAlignment = .center
        self.rightLabel.textAlignment = .center
        
        self.leftLabel.text = "날씨"
        self.centerLabel.text = "주식"
        self.rightLabel.text = "운세"
        
    }

}
