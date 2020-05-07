//
//  TwitterCell.swift
//  catchup
//
//  Created by PJW on 06/05/2020.
//  Copyright © 2020 PJW. All rights reserved.
//

import UIKit

class TwitterCell: UITableViewCell {
    @IBOutlet var textContainer: UIView!
    
    @IBOutlet var textLabel1: UILabelPadding!
    @IBOutlet var textLabel2: UILabelPadding!
    @IBOutlet var textLabel3: UILabelPadding!
    
    var textLabelList:  Array<UILabelPadding>!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
