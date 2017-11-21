//
//  DDItem1VC.swift
//  ZDLao
//
//  Created by WY on 2017/10/13.
//  Copyright © 2017年 com.16lao. All rights reserved.
//

import UIKit
import CryptoSwift
class DDItem1VC: DDNormalVC {
    let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 88, width: UIScreen.main.bounds.width, height: 400), collectionViewLayout: DDMidBigLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testMidBigLayout()
//        GDStorgeManager.standard.setValue(nil , forKey: LLanguageTableName)// .value(forKey: LLanguageTableName)
//        print(GDLanguageManager.titleByKey(key: "title"))
//        let sha1   = "title".sha1()
//        print(sha1)
        self.testLocalize()
        // Do any additional setup after loading the view.
        self.testNeswork()
    }
    func testNeswork() {
        let a = DDRequestManager.share.getKey()?.responseJSON(completionHandler: { (response) in
            print("print result of getKey : \(response.description)")
            print("print response'result \(response.result)")
            print("print response'data  \(response.data )")
            dump("dump response.value : \(response.value)")
        })
    }

    func testLocalize() {
        let willBeShowLocalIdentifier =  GDLanguageManager.text("language_identifier") // 中文是:"zh_cn"
        let willBeShowLocal = Locale.init(identifier: "th_th")//localID为"th_th"的本地化对象
        let showInLocal = Locale.init(identifier: "ch_en")//以中文显示泰文信息
//        print(Locale.current.regionCode)//以当前区域(国家)显示localID为"zh_cn"的本地化对象的相关信息(国家 ,语言名称等)
        print(showInLocal.localizedString(forRegionCode: willBeShowLocal.regionCode!))
        print(showInLocal.localizedString(forLanguageCode: willBeShowLocal.languageCode!))
        /*
         输出
         Optional("泰国")
         Optional("泰文")
         */
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("test account")
        print(DDDevice.type)
//        DDAccount.share.deleteAccountFromDisk()
//        
//        DDAccount.share.setPropertisOfShareBy(dict : ["name": "JohnLock" , "head_images" : "http://www.baidu.com/" , "member_id" : "3"] as [String : AnyObject])
//        
//        self.navigationController?.pushViewController(DDNormalVC(), animated: true )
//        self.navigationController?.pushViewController(TestMoveItemVC(collectionViewLayout: UICollectionViewFlowLayout()), animated: true )
        
        self.navigationController?.pushViewController(TestMoveItem2VC(), animated: true )

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




extension DDItem1VC : UICollectionViewDataSource , UICollectionViewDelegate{
    func testMidBigLayout() {
        self.view.addSubview(self.collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UICollectionViewCell.self , forCellWithReuseIdentifier: "ddmidbig")
        if let layout  = collectionView.collectionViewLayout as? DDMidBigLayout {
            layout.itemSize = CGSize(width: 90 , height: 50)
            layout.scrollDirection = UICollectionViewScrollDirection.horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = UIEdgeInsets(top: 0, left: collectionView.bounds.width/2 - layout.itemSize.width/2, bottom: 0, right: collectionView.bounds.width/2 - layout.itemSize.width/2)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 320
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ddmidbig", for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}
