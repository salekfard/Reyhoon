//
//  Response_Coordinates.swift
//  Reyhoon
//
//  Created by Ali Salekfard on 2/2/18.
//  Copyright © 2018 Ali Salekfard. All rights reserved.
//

import UIKit
import ObjectMapper

class Response_Coordinates: Mappable {

    var branches : [Response_Coordinates_branches]!
    
    init() {
    }
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        branches    <- map["branches"]
    }
}

class Response_Coordinates_branches: Mappable {
    
    var id : Int!
    var name_fa : String = "";
    var distance : Double = 0.0;
    
    init() {
    }
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        id          <- map["id"]
        name_fa     <- map["name_fa"]
        distance    <- map["distance"]
    }
    
    static func getNearest(branches : [Response_Coordinates_branches] , count : Int) -> [Response_Coordinates_branches]
    {
        var result = [Response_Coordinates_branches]();
        
        if (branches.count == 0)
        {
            return result;
        }
        
        let listSorted = branches.sorted(by: { $0.distance < $1.distance }).prefix(count);
        
        result.append(contentsOf: listSorted);
        
        return result;
    }
}
