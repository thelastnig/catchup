//
//  BoonCell.swift
//  catchup
//
//  Created by PJW on 13/01/2020.
//  Copyright © 2020 PJW. All rights reserved.
//

import UIKit

class BoonCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var containerView: UIView!
    
    override func awakeFromNib() {
      super.awakeFromNib()
      self.containerView.layer.cornerRadius = 6
      self.containerView.layer.masksToBounds = true
      self.containerView.backgroundColor = .lightGray
    }
    
}
