//
//  AlertHelper.swift
//  Reyhoon
//
//  Created by Ali Salekfard on 2/2/18.
//  Copyright © 2018 Ali Salekfard. All rights reserved.
//

import UIKit

class AlertActionCustom : NSObject
{
    var title : String!
    var style : UIAlertActionStyle!
    
    init(title : String , style : UIAlertActionStyle)
    {
        self.title = title;
        self.style = style;
    }
}

class AlertHelper: NSObject {
    
    static func show(viewController : UIViewController , Title strTitle : String , message : String , actions : [AlertActionCustom] , completion: @escaping (AlertActionCustom) -> ())
    {
        if (actions.count == 0)
        {
            return;
        }
        
        let alert = UIAlertController(title: strTitle, message: message, preferredStyle: UIAlertControllerStyle.alert);
        
        for action in actions
        {
            alert.addAction(UIAlertAction(title: action.title, style: action.style, handler: { action in
                completion(AlertActionCustom(title: action.title!, style: action.style));
            }))
        }
        
        viewController.present(alert, animated: true, completion: nil)
    }
}
