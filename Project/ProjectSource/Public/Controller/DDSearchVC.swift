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
        ["111111111111111asfgrasdfgasdgfasgasdfgafdgasdgasdgasgasasasdf111olmn1111111","22pjmk.,222","pj'klm.,iopjlk33","1111111111p'ijlkm,.111111111111111","22o9uijno;ilhjoi;222","3io;ljnkjlhno;iljk3"],
        ["10[hoi;noilkj111","2222222222222222222222","30hio;jno0i;jk3"],
        ["1111","22222","33333333333333333333","ddd0[oih;nj;pi  weqfasedfasefawefasdfasefasefasfasdfasefasefohkjdd"],
        ["110[hio;k11","20[hio;jkhio22wsfasdfasdfasdfasdfwefasefawesfwaesfasedfasdfasdfasdfasdfasdfsdfasdf22","30[oihknj3"],
        ["1[oihk;oikl111","222oih;nklm22","33io;nafgasdgfasdfgasdfgasfdasdfasdfasdfgvasdfvasdfcvasdfcxasdklm,oi;jk"]
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
        searchBox.placeholder = "热销"
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
        
//        collectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10)//not work
    }
    @objc func search()  {
        self.searchBox.resignFirstResponder()
        var keyWord = ""
        if let tempKeyWord =  self.searchBox.text, !tempKeyWord.isEmpty{keyWord = tempKeyWord}else{
            if let placeHolderWork =  self.searchBox.placeholder , !placeHolderWork.isEmpty{keyWord = placeHolderWork}else{return}
        }
        self.performSearch(keyWord:keyWord)
    }
    func performSearch(keyWord:String ){
        print("perform search : \(keyWord)")
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
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.searchBox.resignFirstResponder()
    }

}
extension DDSearchVC : DDSearchLayoutProtocol{
    func provideItemHeight(layout:DDSearchLayout?) -> CGFloat{//定值
    return 30.0
    }
    func provideItemWidth(layout: DDSearchLayout? ,indexPath:IndexPath) -> CGFloat{//变值
//        return ((collectionView.bounds.width - 40.000000001 ) / 3)
        let str = datas[indexPath.section][indexPath.item]
        let label = UILabel()
        label.text = str
        label.sizeToFit()
        return (label.bounds.width  + 10)
        
        
//        if indexPath.item % 3 == 0  {
//            return 100
//        }else if indexPath.item % 3 == 1  {
//            return 366
//        }else if indexPath.item % 3 == 2  {
//            return 200
//        }else{
//            return 222
//        }
    }
    func provideColumnMargin(layout:DDSearchLayout?) -> CGFloat{
        return 10
    }
    func provideRowMargin(layout:DDSearchLayout?) -> CGFloat{
        return 10
    }
    func provideEdgeInsets(layout:DDSearchLayout?) -> UIEdgeInsets{
        return UIEdgeInsetsMake(0, 10, 0, 10)
    }
    func provideSessionHeaderHeight(layout:DDSearchLayout?) -> CGFloat{//定值
        return 44
    }
    func provideSessionFooterHeight(layout:DDSearchLayout?) -> CGFloat{//定值
        return 44
    }
    
}
extension DDSearchVC : UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.searchBox.resignFirstResponder()
        let keyWord = datas[indexPath.section][indexPath.item]
        self.performSearch(keyWord:keyWord)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return datas[section].count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "DDSearchItem", for: indexPath)
        if let realItem = item as? DDSearchItem {
            realItem.title = datas[indexPath.section][indexPath.item]
            return realItem
        }
        return item
    }
    public func numberOfSections(in collectionView: UICollectionView) -> Int{
        return datas.count
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchBox.resignFirstResponder()
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
        self.layer.cornerRadius = self.bounds.height * 0.1
        self.layer.masksToBounds = true
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
