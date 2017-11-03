//
//  DDSearchLayout.swift
//  Project
//
//  Created by WY on 2017/11/2.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit


@objc protocol DDSearchLayoutProtocol : NSObjectProtocol{
    func provideItemHeight(layout:DDSearchLayout? , indexPath : IndexPath) -> CGFloat
    func provideItemWidth(layout: DDSearchLayout?) -> CGFloat
    @objc optional func provideColumnCount(layout:DDSearchLayout?) -> Int
    @objc optional func provideColumnMargin(layout:DDSearchLayout?) -> CGFloat
    @objc optional func provideRowMargin(layout:DDSearchLayout?) -> CGFloat
    @objc optional func provideEdgeInsets(layout:DDSearchLayout?) -> UIEdgeInsets
    @objc optional func provideSessionHeaderHeight(layout:DDSearchLayout?) -> CGFloat
}
class DDSearchLayout: UICollectionViewLayout {
    weak var  delegate :DDSearchLayoutProtocol?
    var columnCount : Int {
        let sessionHeaderH  = self.delegate?.provideSessionHeaderHeight?(layout: self) ?? 0
        
        if let column = self.delegate?.provideColumnCount?(layout: self) {
            mylog(columns.count)
            mylog(column)
            if columns.count != column {
                columns = Array.init(repeating: sessionHeaderH, count: column)
            }
            return  column
        }else{
            columns = [sessionHeaderH]
            return 1
        }
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
    var minY : CGFloat = 0
    var columns : [CGFloat] = [CGFloat]()
    override func prepare() {
        super.prepare()
        attributes.removeAll()
        //先考虑只有一组的情况, 而且没有header
        columns.removeAll()
        let _ = columnCount//chushihua
        let itemsCount = self.collectionView?.numberOfItems(inSection: 0) ?? 0
        let sectionCount = self.collectionView?.numberOfSections ?? 0
        if sectionCount > 0  {
            if let header = self.layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader, at: IndexPath(item: 0, section: 0)){
                attributes.append(header)
            }
        }
        for index  in 0..<itemsCount {
            let currentIndex = IndexPath(item: index, section: 0)
            if let attribute = self.layoutAttributesForItem(at: currentIndex){
                attributes.append(attribute)
            }
        }
    }
    override var collectionViewContentSize: CGSize{
        return CGSize(width: self.collectionView?.bounds.size.width ?? UIScreen.main.bounds.size.width, height: self.columns.max() ?? 0)
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes?{
        if indexPath.section == 0  {
            let headerAttribute  = UICollectionViewLayoutAttributes.init(forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, with: indexPath)
            headerAttribute.frame = CGRect(x: 0, y: 0, width: self.collectionView?.bounds.width ?? UIScreen.main.bounds.width, height: 64)
            return headerAttribute
        }
        return nil
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attribute = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
        let width = self.delegate?.provideItemWidth(layout: self)  ?? 0
        let height = self.delegate?.provideItemHeight(layout: self, indexPath: indexPath) ?? 0
        let shortestYvalue = self.columns.min() ?? 0
        let shortestYvalueCol = self.columns.index(of: shortestYvalue)
        let columNum = shortestYvalueCol
        let x = self.edgeInsets.left + CGFloat(columNum ?? 0) * (width + self.columnMargin)
        let y = columns[columNum ?? 0]  + rowMargin
        self.columns[columNum ?? 0] = columns[columNum ?? 0] + height
        attribute.frame = CGRect(x: x , y: y , width: width, height: height)
        return attribute
    }
}
