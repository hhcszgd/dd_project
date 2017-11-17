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
    let baseUrl = "http://api.hilao.dev/"
//    let baseUrl = "http://api.hilao.cc/"
    
    var token : String? = "token"
    static let share : DDRequestManager = DDRequestManager()
    private func performRequest(url : String,method:HTTPMethod , parameters: Parameters?   ) -> DataRequest? {
        if let url  = URL(string:baseUrl + url){
            return Alamofire.request(url , method: HTTPMethod.post , parameters: parameters   ).responseJSON(completionHandler: { (response) in
                print("print request result -->:\(response.result)")
            })
        }else{return nil }
    }
    /*
     验证手机号/邮箱是否已经存在
     作者：张宏雷
     接口地址： http://api.zdlao.dev/password/checkPhone ||checkEmail
     */
    @discardableResult
    func checkPhone(phoneNum : String) -> DataRequest? {
        let para = ["phone":phoneNum]
        let url = "password/checkPhone"
        return Alamofire.request(url  , method: HTTPMethod.post , parameters: para)
    }
    
    func checkEmail(email:String) -> DataRequest? {
        let url  = "password/checkPhone"
        let para = ["email":email]
        return performRequest(url: url , method: HTTPMethod.post, parameters: para)
    }
    /*
    获取验证码key值
     作者：张宏雷
     接口地址： http://api.hilao.dev/passport/getValidateCodeKey
     */
    @discardableResult
    func getKey() -> DataRequest? {
        let url  =  "passport/getValidateCodeKey"
        return performRequest(url: url , method: HTTPMethod.post, parameters: nil)
    }
    /*3.    验证码图片地址
     作者：张宏雷
     接口地址： http://api.hilao.dev/passport/getValidateCodeImg/UVlkdzOoAN0sr26Y
     请求方式：GET
     说明：key值以url地址段GET方式传递
     */
    @discardableResult
    func getAuthCodeImgUrl(key:String) -> DataRequest? {
        let url  = "passport/getValidateCodeImg/" + key
        return performRequest(url: url , method: HTTPMethod.get, parameters: nil )
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
