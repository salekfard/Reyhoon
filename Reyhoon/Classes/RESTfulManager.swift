//
//  RESTfulManager.swift
//  Reyhoon
//
//  Created by Ali Salekfard on 2/2/18.
//  Copyright © 2018 Ali Salekfard. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class RESTfulManager: NSObject {
    
    static func sendDefaultRequest(HttpMethod httpMethod : HTTPMethod , Url strUrl : String , PostString strPost : String? = nil , TimeOut intTimeOut : Int , Authorization isAuthorization : Bool = false, Cashe isCache : Bool = false , withSuccess success:@escaping (_ response: String?) -> (), andFailure failure:@escaping (_ error: Error?) -> ()) {
        
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
        
        Alamofire.request(request as URLRequestConvertible).validate().responseString
            {
                response in
                
            guard response.result.isSuccess else {
                failure(response.result.error)
                return;
            }
            
            if let value = response.result.value {
                success(value);
                //You can use this to responseJSON
                /*do {
                    let dataSerialization = try JSONSerialization.data(withJSONObject: value, options: []);
                    if let stringData = NSString(data: dataSerialization, encoding: String.Encoding.utf8.rawValue)
                    {
                        success(stringData as String);
                    }
                } catch let error{
                    failure(error);
                    return;
                }*/
            }
            
            failure(nil);
        }
    }
}
