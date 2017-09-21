//
//  ViewController.swift
//  PullStram
//
//  Created by DaWang on 2017/9/21.
//  Copyright © 2017年 Anderson. All rights reserved.
//

import UIKit

private let ContentCell = "ContentCell"

class ViewController: UIViewController {

    fileprivate lazy var collectionView : UICollectionView = {

        let layout = DWWaterFallFlowLayout();
        layout.dataSource = self;

        let itemMargin:CGFloat = 10;
        layout.minimumLineSpacing = itemMargin;
        layout.minimumInteritemSpacing = itemMargin;
        layout.sectionInset = UIEdgeInsetsMake(itemMargin, itemMargin, itemMargin, itemMargin);

        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout);
        collectionView.backgroundColor = UIColor.cyan
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: ContentCell);

        return collectionView;
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
    }

}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (Int(arc4random_uniform(20)) + 20);
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCell, for: indexPath);
        cell.backgroundColor = UIColor.red;
        return cell
    }
}







extension ViewController : DWWaterFallFlowLayoutDataSource{
    func waterFallNumberOfCols(_ waterFall: DWWaterFallFlowLayout) -> Int {
        return 3;
    }

    func waterFall(_ waterFall: DWWaterFallFlowLayout, item: Int) -> CGFloat {
        return CGFloat(arc4random_uniform(140) + 120)
    }
}
































