//
//  AppManager.swift
//  WHOSCALL_WORK
//
//  Created by Dante on 2021/1/12.
//  Copyright © 2021 Dante. All rights reserved.
//

import UIKit
import Alamofire

class AppManager: NSObject {
      /// api request handle
        static func requestAPI(url:URL, paramaters:Parameters?, success:@escaping (_ isSuccess:Bool, _ response:DataResponse<Any>, _ desc:String)->Void, fail:@escaping (_ error:String)->Void) {
            
            //test manager
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 120
            
            manager.request(url, method: .get, parameters: paramaters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                if response.result.isSuccess {
               
                      success(true, response,RESPONSE_SUCESS)
                }
                
                if response.result.isFailure {
                    #if DEBUG
                    print("request error:\(response.result.error.debugDescription)")
                    #endif
                    fail(response.result.error.debugDescription)
                }
            }
        }
}
