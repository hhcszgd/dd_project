//
//  TestMoveItem2VC.swift
//  Project
//
//  Created by WY on 2017/11/18.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit
private let reuseIdentifier = "Cell"
class TestMoveItem2VC: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate   {
    var arr  = [1,2,3,4,5,6,]
    
    let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: 580), collectionViewLayout: UICollectionViewFlowLayout())
     func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("invoke after moved , deal dataSource at here ")
        collectionView.reloadData()
        arr.swapAt(2, 3);
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        self.congitGesture()
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = CGSize(width: 40, height: 40)
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    func congitGesture()  {
        let longPress = UILongPressGestureRecognizer.init(target: self , action: #selector(handleGesture(gesture:)))
        collectionView.addGestureRecognizer(longPress)
    }
//    installsStandardGestureForInteractiveMovement
    @objc func handleGesture(gesture :  UILongPressGestureRecognizer)  {
        print(gesture.state.rawValue)
        switch(gesture.state) {
        case UIGestureRecognizerState.began:
            guard let selectedIndexPath =  self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView)) else {break}
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case UIGestureRecognizerState.changed:
                collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case UIGestureRecognizerState.ended:
                 collectionView.endInteractiveMovement()
        default:
                 collectionView.cancelInteractiveMovement()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        // Configure the cell
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }

}
