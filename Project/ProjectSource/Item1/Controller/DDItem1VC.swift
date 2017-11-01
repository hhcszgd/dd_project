//
//  DDItem1VC.swift
//  ZDLao
//
//  Created by WY on 2017/10/13.
//  Copyright © 2017年 com.16lao. All rights reserved.
//

import UIKit

class DDItem1VC: DDNormalVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        GDStorgeManager.standard.setValue("English", forKey: LLanguageTableName)// .value(forKey: LLanguageTableName)
        print(GDLanguageManager.titleByKey(key: "title"))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("test account")
        
        DDAccount.share.deleteAccountFromDisk()
        
        DDAccount.share.setPropertisOfShareBy(dict : ["name": "JohnLock" , "head_images" : "http://www.baidu.com/" , "member_id" : "3"] as [String : AnyObject])
        
        self.navigationController?.pushViewController(DDNormalVC(), animated: true )
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
