//
//  TwitterCell.swift
//  catchup
//
//  Created by PJW on 06/05/2020.
//  Copyright © 2020 PJW. All rights reserved.
//

import UIKit

class TwitterCell: UITableViewCell {
    
    var textContainer: UIView!
    var textLabel1: UILabel!
    var textLabel2: UILabel!
    var textLabel3: UILabel!
    
    var textLabelList:  Array<UILabel>!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func cellInit(_ num: Int) {
        self.textContainer = UIView()
        self.textLabel1 = UILabel()
        self.textLabel2 = UILabel()
        self.textLabel3 = UILabel()
        self.textLabelList = [self.textLabel1, self.textLabel2, self.textLabel3]
        
        for idx in 0..<num {
            self.textLabelList[idx].contentMode = .center
            self.textLabelList[idx].font = UIFont.init(name: Constants.mainFont, size: 14)
        }
        
    }

}
