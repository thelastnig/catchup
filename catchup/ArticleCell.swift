//
//  ArticleCell.swift
//  catchup
//
//  Created by PJW on 06/01/2020.
//  Copyright © 2020 PJW. All rights reserved.
//

import UIKit
import Kanna

class ArticleCell: UITableViewCell {
    @IBOutlet var labelNum: UILabel!
    @IBOutlet var labelText: UILabel!
    @IBOutlet var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
