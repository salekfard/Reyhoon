//
//  RESTfulManager.swift
//  Reyhoon
//
//  Created by Ali Salekfard on 2/2/18.
//  Copyright © 2018 Ali Salekfard. All rights reserved.
//

import UIKit
import Alamofire

class RESTfulManager: NSObject {
    
    static func sendDefaultRequest(HttpMethod httpMethod : HTTPMethod , Url strUrl : String , PostString strPost : String? , TimeOut intTimeOut : Int , Authorization isAuthorization : Bool = false, Cashe isCache : Bool = false , withSuccess success:@escaping (_ response: Any?) -> (), andFailure failure:@escaping (_ error: Error?) -> ()) {
        
        var request = URLRequest(url: URL(string: strUrl)!);
        request.httpMethod = httpMethod.rawValue;
        request.setValue("application/json", forHTTPHeaderField: "Content-Type");
        request.setValue("application/json", forHTTPHeaderField: "Accept");
        
        if (intTimeOut > 0) {
            request.timeoutInterval = TimeInterval(intTimeOut);
        }
        
        if (strPost != nil) {
            if (strPost!.count > 0) {
                let postData : Data = (strPost?.data(using: String.Encoding.utf8))!
                request.httpBody = postData;
            }
        }
        
        Alamofire.request(request as URLRequestConvertible).validate().responseJSON {
            response in
            
            guard response.result.isSuccess else {
                failure(response.result.error)
                return
            }
            
            if let value = response.result.value {
                success(value)
            }
        }
    }
}
