//
//  DDSearchVC.swift
//  Project
//
//  Created by WY on 2017/11/7.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class DDSearchVC: DDNormalVC {
    let datas = [
        ["1111","22222","22222","22222","22222","22222","22222","22222","22222","22222","22222","22222","22222","22222","33","33"],["444444","555555555555555555555555555555","6666666666666"],["777777777","888888","999999999999999999999999999999999"]
    ]
    let searchBox = UITextField.init()
    let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: DDSearchLayout())
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNavigationBar()
        self.configCollectionView()
        // Do any additional setup after loading the view.
    }
    func configNavigationBar()  {
        self.navigationItem.titleView = searchBox
        searchBox.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 44 * 2, height: 30)
        searchBox.backgroundColor = UIColor.red
        searchBox.borderStyle = UITextBorderStyle.roundedRect
        let rightView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        rightView.backgroundColor = UIColor.blue
        searchBox.rightView = rightView
        searchBox.rightViewMode = .always
        let searchButton =  UIBarButtonItem.init(title: "搜索", style: UIBarButtonItemStyle.plain, target: self, action: #selector(search))
        searchButton.setTitlePositionAdjustment(UIOffset.init(horizontal: 9, vertical: 0), for: UIBarMetrics.default)
        self.navigationItem.rightBarButtonItem = searchButton
    }
    func configCollectionView() {
        self.view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.frame = self.view.bounds
        collectionView.register(DDSearchItem.self, forCellWithReuseIdentifier: "DDSearchItem")
        collectionView.register(DDSearchSessionHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "DDSearchCollectionHeader")
        collectionView.register(DDSearchSessionFooter.self , forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "DDSearchCollectionFooter")
        if let searchLayout = collectionView.collectionViewLayout as? DDSearchLayout {
            searchLayout.delegate = self
        }
    }
    @objc func search()  {
        print("perform search")
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
extension DDSearchVC : DDSearchLayoutProtocol{
    func provideItemHeight(layout:DDSearchLayout?) -> CGFloat{//定值
    return 44.0
    }
    func provideItemWidth(layout: DDSearchLayout? ) -> CGFloat{//变值
        return 64//待更改
    }
    func provideColumnMargin(layout:DDSearchLayout?) -> CGFloat{
        return 10
    }
    func provideRowMargin(layout:DDSearchLayout?) -> CGFloat{
        return 10
    }
//    func provideEdgeInsets(layout:DDSearchLayout?) -> UIEdgeInsets
    func provideSessionHeaderHeight(layout:DDSearchLayout?) -> CGFloat{//定值
        return 44
    }
    func provideSessionFooterHeight(layout:DDSearchLayout?) -> CGFloat{//定值
        return 44
    }
}
extension DDSearchVC : UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return datas[section].count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "DDSearchItem", for: indexPath)
        if let realItem = item as? DDSearchItem {
            realItem.title = datas[indexPath.section][indexPath.item]
            print("title ---------> \(datas[indexPath.section][indexPath.item])")
            return realItem
        }
        return item
    }
    public func numberOfSections(in collectionView: UICollectionView) -> Int{
        return datas.count
    }
    
    // The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        if kind == UICollectionElementKindSectionHeader {
            return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "DDSearchCollectionHeader", for: indexPath)
        }else{
            return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "DDSearchCollectionFooter", for: indexPath)
        }
    }

}

class DDSearchItem: UICollectionViewCell {
    let titleLabel  = UILabel()
    
    var title :  String = "000"{
        didSet{
            self.titleLabel.text = title
            self.layoutIfNeeded()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame )
        self.setupSubviews()
        self.backgroundColor = UIColor.red
    }
    func setupSubviews()  {
        self.contentView.addSubview(titleLabel)
        titleLabel.textAlignment = NSTextAlignment.center
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = self.contentView.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DDSearchSessionHeader: UICollectionReusableView {
    let label1 = UILabel()
    let label2 = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame )
        self.addSubview(label1)
        
        self.backgroundColor = UIColor.green
        label1.text = "主标题"
        label1.font = UIFont.systemFont(ofSize: 12)
        label1.textColor = UIColor.lightGray
        self.addSubview(label2)
        label2.textColor = UIColor.gray
        label2.text = "副标题"
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        label1.frame = CGRect(x: 20, y: 0, width: 150, height: 44)
        label2.frame = CGRect(x: 150, y: 0, width: 150, height: 44)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class DDSearchSessionFooter: UICollectionReusableView {
    let label1 = UILabel()
    let label2 = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame )
        self.addSubview(label1)
        self.backgroundColor = UIColor.blue
        label1.text = "主标题"
        label1.font = UIFont.systemFont(ofSize: 12)
        label1.textColor = UIColor.lightGray
        self.addSubview(label2)
        label2.textColor = UIColor.gray
        label2.text = "副标题"
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        label1.frame = CGRect(x: 20, y: 0, width: 150, height: 44)
        label2.frame = CGRect(x: 150, y: 0, width: 150, height: 44)
        func showSubviews(isShow:Bool){
            for (_ , subview ) in self.subviews.enumerated(){
                subview.isHidden = !isShow
            }
        }
        if self.bounds.height <= 0  {
            showSubviews(isShow: false)
        }else{
            showSubviews(isShow: true)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}