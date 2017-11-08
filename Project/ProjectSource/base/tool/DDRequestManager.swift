//
//  DDRequestManager.swift
//  ZDLao
//
//  Created by WY on 2017/10/17.
//  Copyright © 2017年 com.16lao. All rights reserved.
/*
 status = 1;
 id = 4;
 name = JohnLock;
 token = 5ebfcf173717960b25b270f06c401d20;
 avatar = http://f0.ugshop.cn/FilF9WGuUGZW5eX-WtfvpFoeTsaY;
 */

import UIKit
import Alamofire
class DDRequestManager: NSObject {
//    let baseUrl = "http://api.zdlao.dev/"
    let baseUrl = "http://api.hilao.cc/"
    
    var token : String? = "token"
    static let share : DDRequestManager = DDRequestManager()

    /*
     验证手机号/邮箱是否已经存在
     作者：张宏雷
     接口地址： http://api.zdlao.dev/password/checkPhone ||checkEmail
     */
    @discardableResult
    func checkPhone() -> DataRequest? {
        if let url  = URL(string:baseUrl + "password/checkPhone"){
        let para = ["phone":"18838120446"]
            return Alamofire.request(url , method: HTTPMethod.post , parameters: para   ).responseJSON(completionHandler: { (response) in
                print("pppppp\(response.result)")
            })
        }else{return nil }
    }
}



//    func initInfo()   {
//        let url = baseUrl + "init"
//        let did = UIDevice.current.identifierForVendor?.uuidString
//        let para = ["deviceid" : did! , "app_type" : "2" ]
////        Alamofire.request(url , method: HTTPMethod.post, parameters: para ).responsePropertyList{ (result) in
//////                        DefaultDataResponse
////            print("request result : \(result.data)")
////            }.responseString { (response) in
////                print("responseString resulw \(type(of: response.result.va)) data\(response.value)    error \(response.error)")
////        }
//        Alamofire.request(url, method: HTTPMethod.post, parameters: para  ).response(completionHandler: { (response) in
//            print("dataByte : \(response.data)")
//        }).responseJSON(completionHandler: { (response) in
//            print("JSON : \(response)")
//            if let dict = response.value as? [String : AnyObject]{
//                print("DICT : \(dict["status"])")
//            }
//        }).responsePropertyList() { (dataResponse) in
//            print("response : \(dataResponse)")
//        }
//    }
