//
//  DDRootVC.swift
//  ZDLao
//
//  Created by WY on 2017/10/13.
//  Copyright © 2017年 com.16lao. All rights reserved.
//

import UIKit

class DDRootNavVC: DDBaseNavVC  /*,UITabBarControllerDelegate*/{
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    convenience  init() {
        let rootTabBarVC = DDRootTabBarVC()
        self.init(rootViewController: rootTabBarVC)
        self.setNavigationBarHidden(true , animated: false )
//        rootTabBarVC.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
