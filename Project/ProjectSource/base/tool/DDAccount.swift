//
//  DDAccount.swift
//  ZDLao
//
//  Created by WY on 2017/10/13.
//  Copyright © 2017年 com.16lao. All rights reserved.
//

import UIKit

class DDAccount: NSObject , NSCoding{
    @objc var userName : String?
    @objc var userID  : String?
    @objc var member_id : String?
    @objc var name : String?
    @objc var head_images:String?
    static let share : DDAccount = {
        if let account = DDAccount.read(){
            return account
        }else{
            return DDAccount.init()
        }
    }()
    ///save account from memary to disk .
    
    /// return value  : save success or not
    @discardableResult
    func save() -> Bool {
        let docuPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
        if let realDocuPath : NSString = docuPath as NSString? {
            let filePath = realDocuPath.appendingPathComponent("Account.data")
            let isSuccess =  NSKeyedArchiver.archiveRootObject(self , toFile: filePath)
            if isSuccess {
                mylog("archive success")
            }else{
                mylog("archive failure")
            }
            return isSuccess
        }else{
            mylog("the  path of archive is not exist")
            return false
        }
    }
    ///load account from local disk
    class  func read() -> DDAccount? {
        let docuPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
        if let realDocuPath : NSString = docuPath as NSString? {
            let filePath = realDocuPath.appendingPathComponent("Account.data")
            let object =  NSKeyedUnarchiver.unarchiveObject(withFile:  filePath)
            if let realObjc = object as? DDAccount {
                return realObjc
            }else{
                return  nil
            }
        }else{
            mylog("the  path of unarchive is not exist")
            return  nil
        }
    }
    ///set share account's propertis by other account dictionary
    func setPropertisOfShareBy( dict : [String : AnyObject])  {
        self.setPropertisOfShareBy(otherAccount : DDAccount.init(dict: dict))
    }
    
    ///set share account's propertis by other account instance
    func setPropertisOfShareBy( otherAccount : DDAccount)  {
        DDAccount.share.name = otherAccount.name
        DDAccount.share.head_images = otherAccount.head_images
        DDAccount.share.member_id = otherAccount.member_id
        DDAccount.share.save()
    }
    
    ///remove account data from disk
    @discardableResult
    func deleteAccountFromDisk() -> Bool {
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as NSString).appendingPathComponent("Account.data")
        do {
            try  FileManager.default.removeItem(atPath: path)
            mylog("remove account data from disk success")
            DDAccount.share.setPropertisOfShareBy(otherAccount : DDAccount())
            return true
        }catch  let error as NSError {
            mylog("remove account data from disk failure")
            mylog(error)
            return false
        }
    }
    init(dict : [String : AnyObject]? = nil ) {
        super.init()
        if dict == nil  {return}
        self.setValuesForKeys(dict!)
//        if let data  = dict?["data"] {
//            if let memberid = data as? String{
//                self.member_id = memberid
//            }
//        }
    }
    
    /////////////////////////////////////////////////////////////////
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "id" {
            self.member_id = value as? String
            return
        }
        super.setValue(value, forKey: key)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        //do nothing
    }
    
    // implement NSCoding protocol method
    
    //unarchive binary data to instance
    required init?(coder aDecoder: NSCoder) {
        //        token = aDecoder.decodeObjectForKey("token") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        member_id = aDecoder.decodeObject(forKey: "member_id") as? String
        head_images = aDecoder.decodeObject(forKey: "head_images") as? String
    }
    //unarchive instance to binary data
    func encode(with aCoder: NSCoder) {
        //        aCoder.encodeObject(token, forKey: "token")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(member_id, forKey: "member_id")
        aCoder.encode(head_images, forKey: "head_images")
    }
}
