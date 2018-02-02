//
//  MainViewController.swift
//  Reyhoon
//
//  Created by Ali Salekfard on 2/2/18.
//  Copyright © 2018 Ali Salekfard. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var arrayCollection = [Response_Coordinates_branches]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getData();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadAllData()
    {
        arrayCollection = [Response_Coordinates_branches]();
        
    }
    
    func getData()
    {
        RESTfulManager.sendDefaultRequest(HttpMethod: .get, Url: GENERAL_URL_SERVICES+"/public-api/v1/listings/by-coordinates?lng=51.409954&lat=35.757540", TimeOut: GENERAL_SERVICES_TIME_OUT, withSuccess: {(response) in
            
            let responseEntity = Response_Coordinates(JSONString: response!);
            
            if (responseEntity != nil && responseEntity?.branches != nil)
            {
                if (responseEntity!.branches.count > 0)
                {
                    self.arrayCollection.append(contentsOf: Response_Coordinates_branches.getNearest(branches: responseEntity!.branches, count: 10));
                }
            }
            
        }, andFailure: { (error) in
            if (error != nil)
            {
                let nsError = error! as NSError;
                if (nsError.code == -1008 || nsError.code == -1009)
                {
                    AlertHelper.show(viewController: self, Title: "System Message", message: "Check Your Connection", actions: [AlertActionCustom(title: "Retry", style: UIAlertActionStyle.default)])
                    {
                        action in
                        self.reloadAllData();
                        self.getData();
                    }
                }
            }
        })
    }
    
}
