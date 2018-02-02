//
//  DistanceHelper.swift
//  Reyhoon
//
//  Created by Ali Salekfard on 2/2/18.
//  Copyright © 2018 Ali Salekfard. All rights reserved.
//

import UIKit

class DistanceHelper: NSObject {

    private var intMeter : Int!
    private var intKM : Int!
    
    init (meter : Double)
    {
        intMeter = Int(meter);
        intKM = Int(meter/1000);
    }
    
    func getDescription() -> String
    {
        if (intKM < 1)
        {
            return "\(intMeter!)m";
        }
        
        return "\(intKM!)km";
    }
    
    func getColor() -> UIColor
    {
        if (intKM < 1)
        {
            return COLOR_NEAR;
        }
        
        return COLOR_FAR;
    }
}
