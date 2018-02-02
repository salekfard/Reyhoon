//
//  MainCollectionViewCell.swift
//  Reyhoon
//
//  Created by Ali Salekfard on 2/2/18.
//  Copyright © 2018 Ali Salekfard. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewMain: UIView!
    
    @IBOutlet weak var viewTitle: UIView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblDistance: UILabel!
    
    override func awakeFromNib() {
        self.contentView.transform = CGAffineTransform(scaleX: -1, y: 1);
        self.viewTitle.layer.cornerRadius = self.viewTitle.frame.size.width / 5.0;
        self.lblDistance.layer.cornerRadius = self.lblDistance.frame.size.height / 2.0;
    }
    
    
}
