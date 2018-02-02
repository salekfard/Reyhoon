//
//  UIColor+Extend.swift
//  Reyhoon
//
//  Created by Ali Salekfard on 2/2/18.
//  Copyright © 2018 Ali Salekfard. All rights reserved.
//

import UIKit

extension UIColor
{
    ///Ex. UIColor.getEasyColor(R: number, G: number, B: number)
    static func getEasyColor(R red : CGFloat , G green: CGFloat , B blue : CGFloat , Alpha alpha : CGFloat = 1.0) -> UIColor
    {
        return UIColor(red: (red/255.0), green: (green/255.0), blue: (blue/255.0), alpha: alpha);
    }
}
