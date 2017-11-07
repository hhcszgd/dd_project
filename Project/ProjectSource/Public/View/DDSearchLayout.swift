//
//  DDSearchLayout.swift
//  Project
//
//  Created by WY on 2017/11/2.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit


@objc protocol DDSearchLayoutProtocol : NSObjectProtocol{
    func provideItemHeight(layout:DDSearchLayout?) -> CGFloat//定值
    func provideItemWidth(layout: DDSearchLayout?) -> CGFloat//变值
    @objc optional func provideColumnMargin(layout:DDSearchLayout?) -> CGFloat
    @objc optional func provideRowMargin(layout:DDSearchLayout?) -> CGFloat
    @objc optional func provideEdgeInsets(layout:DDSearchLayout?) -> UIEdgeInsets
    @objc optional func provideSessionHeaderHeight(layout:DDSearchLayout?) -> CGFloat//定值
    @objc optional func provideSessionFooterHeight(layout:DDSearchLayout?) -> CGFloat//定值
}
class DDSearchLayout: UICollectionViewLayout {
    weak var  delegate :DDSearchLayoutProtocol?
    var sessionHeaderH   : CGFloat {
        return self.delegate?.provideSessionHeaderHeight?(layout: self) ?? 0
    }
    var sessionFooterH  : CGFloat {
        return self.delegate?.provideSessionFooterHeight?(layout: self) ?? 0
    }
    var columnMargin : CGFloat {
        if let columnMargin = self.delegate?.provideColumnMargin?(layout: self) {return  columnMargin}else{return 0}
    }
    var rowMargin: CGFloat{
        if let rowMargin = self.delegate?.provideRowMargin?(layout: self) {return  rowMargin}else{return 0}
    }
    var edgeInsets : UIEdgeInsets {
        if let edgeInsets = self.delegate?.provideEdgeInsets?(layout: self) {return  edgeInsets}else{return UIEdgeInsets.zero}
    }
    var attributes : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    var maxY : CGFloat = 0
    var maxX : CGFloat = 0
//    var columns : [CGFloat] = [CGFloat]()
    override func prepare() {
        super.prepare()
        attributes.removeAll()
        //先考虑只有一组的情况, 而且没有header
//        columns.removeAll()
        
        let sectionCount = self.collectionView?.numberOfSections ?? 0
        for sectionIndex  in 0..<sectionCount {
            if let header = self.layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader, at: IndexPath(item: 0, section: sectionIndex)){
                attributes.append(header)
            }
            let itemsCount = self.collectionView?.numberOfItems(inSection: sectionIndex) ?? 0
            for itemIndex  in 0..<itemsCount {
                let currentIndex = IndexPath(item: itemIndex, section: sectionIndex)
                if let attribute = self.layoutAttributesForItem(at: currentIndex){
                    attributes.append(attribute)
                }
            }
            if let header = self.layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionFooter, at: IndexPath(item: 0, section: sectionIndex)){
                attributes.append(header)
            }
            
            
        }
//        if sectionCount > 0  {
//            if let header = self.layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader, at: IndexPath(item: 0, section: 0)){
//                attributes.append(header)
//            }
//        }
//        for index  in 0..<itemsCount {
//            let currentIndex = IndexPath(item: index, section: 0)
//            if let attribute = self.layoutAttributesForItem(at: currentIndex){
//                attributes.append(attribute)
//            }
//        }
    }
    override var collectionViewContentSize: CGSize{
//        return CGSize(width: self.collectionView?.bounds.size.width ?? UIScreen.main.bounds.size.width, height: self.columns.max() ?? 0)
    return CGSize(width: self.collectionView?.bounds.size.width ?? UIScreen.main.bounds.size.width, height: maxY )//+ rowMargin + (self.delegate?.provideItemHeight(layout: self) ?? 0))
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes?{
        if elementKind == UICollectionElementKindSectionHeader {
            let headerAttribute  = UICollectionViewLayoutAttributes.init(forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, with: indexPath)
            headerAttribute.frame = CGRect(x: 0, y: maxY , width: self.collectionView?.bounds.width ?? UIScreen.main.bounds.width, height: sessionHeaderH)
            maxY += (rowMargin+sessionHeaderH)
            maxX = 0
            return headerAttribute
        }else if elementKind == UICollectionElementKindSectionFooter{
            let footerAttribute  = UICollectionViewLayoutAttributes.init(forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, with: indexPath)
            footerAttribute.frame = CGRect(x: 0, y: maxY , width: self.collectionView?.bounds.width ?? UIScreen.main.bounds.width, height: sessionFooterH)
            maxY += sessionFooterH
            if indexPath.section+1 != self.collectionView?.numberOfSections ?? 1000{//最后一个尾不加行间距了
                maxY += rowMargin
            }
            maxX = 0
            return footerAttribute
        }
        
        
        
        
//        if indexPath.section == 0  {
//            let headerAttribute  = UICollectionViewLayoutAttributes.init(forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, with: indexPath)
//            headerAttribute.frame = CGRect(x: 0, y: 0, width: self.collectionView?.bounds.width ?? UIScreen.main.bounds.width, height: 64)
//            return headerAttribute
//        }
        return nil
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attribute = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
        let collectionShowWidth = (self.collectionView?.bounds.size.width ?? UIScreen.main.bounds.width) - (self.collectionView?.contentInset.left ?? 0) - (self.collectionView?.contentInset.right ?? 0)  //collection出去左右偏移量 , 可显示的最大宽度
        let leftShowWidth = collectionShowWidth - maxX - columnMargin//剩余可显示的宽度
        var  width = self.delegate?.provideItemWidth(layout: self)  ?? 0
        let height = self.delegate?.provideItemHeight(layout: self) ?? 0
        if width >= collectionShowWidth {width = collectionShowWidth}
        var  x : CGFloat  = 0
        var y : CGFloat = 0
        print("剩余宽度\(leftShowWidth)")
        if leftShowWidth >= width {//继续往后排
            x = maxX
            y = maxY
            maxX += (width + columnMargin)
            
        }else{//换行 , Y值+行间距+itemH , x值为当前itemW
            maxX = 0
            x = maxX
            maxY += (rowMargin + height)
            maxX += (width  + columnMargin)
            y = maxY
        }
        
        if let itemsCount = self.collectionView?.numberOfItems(inSection: indexPath.section){
            if (itemsCount - 1 ) == indexPath.item{maxY += (height + rowMargin)}//最后一个结束后加itemH
        }
//        let shortestYvalue = self.columns.min() ?? 0
//        let shortestYvalueCol = self.columns.index(of: shortestYvalue)
//        let columNum = shortestYvalueCol
//        let x = self.edgeInsets.left + CGFloat(columNum ?? 0) * (width + self.columnMargin)
//        let y = columns[columNum ?? 0]  + rowMargin
//        self.columns[columNum ?? 0] = columns[columNum ?? 0] + height
        print("x值:\(x)")
        attribute.frame = CGRect(x: x , y: y , width: width, height: height)
        return attribute
    }
}