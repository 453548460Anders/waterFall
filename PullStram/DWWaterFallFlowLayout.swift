//
//  DWWaterFallFlowLayout.swift
//  PullStram
//
//  Created by DaWang on 2017/9/21.
//  Copyright © 2017年 Anderson. All rights reserved.
//

import UIKit


protocol DWWaterFallFlowLayoutDataSource: class {
    func waterFallNumberOfCols(_ waterFall:DWWaterFallFlowLayout) -> Int

    func waterFall(_ waterFall:DWWaterFallFlowLayout, item: Int) -> CGFloat


}

class DWWaterFallFlowLayout: UICollectionViewFlowLayout {


    weak var dataSource: DWWaterFallFlowLayoutDataSource?
    fileprivate lazy var cellAttrs : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()

    fileprivate lazy var cols: Int = {
        return  self.dataSource?.waterFallNumberOfCols(self) ?? 2
    }()

    fileprivate lazy var totalHeight:[CGFloat] = Array(repeating: self.sectionInset.top, count: self.cols);

}


/// 准备布局
extension DWWaterFallFlowLayout{
    override func prepare() {


        // 一个cell的位置是由UICollectionViewLayoutAttributes决定的

        // 0> 定义默认初始的时候, 所有cell的位置的数据

        // 1> 获取总共的collectionViewCell
        let itemCount:Int = (collectionView?.numberOfItems(inSection: 0))!;

        // 2> 给每一个cell创建一个UICollectionViewLayoutAttributes属性

        // 2.1> 计算每个cell的宽度
        let cellW:CGFloat = ((collectionView?.bounds.width)! - sectionInset.left - sectionInset.right - CGFloat(cols - 1) * minimumInteritemSpacing) / CGFloat(cols)

        for i in 0..<itemCount {

            // 1> 根据i, 创建indexPath
            let indexPath = IndexPath(item: i, section: 0)

            // 2> 根据IndexPath, 创建对应的UICollectionViewLayoutAttributes
            let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)

            guard let cellH:CGFloat = dataSource?.waterFall(self, item: i) else {
                fatalError("请实现对应的数据源方法, 并且需要返回cell的高度")
            }
            let minH = totalHeight.min()
            let minIndex = totalHeight.index(of: minH!)
            let cellX = sectionInset.left + (cellW + minimumInteritemSpacing) * CGFloat(minIndex!)
            let cellY = minH! + minimumLineSpacing

            // 3> 设置attr的frame属性
            attr.frame = CGRect(x: cellX, y: cellY, width: cellW, height: cellH)

            // 3.1> 更新totalHeight
            totalHeight[minIndex!] = minH! + cellH + minimumLineSpacing

            // 4> 保存attr
            cellAttrs.append(attr);

        }
    }
}

/// 返回已经布置好的布局
extension DWWaterFallFlowLayout{
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cellAttrs;
    }
}

/// 设置ContentSize
extension DWWaterFallFlowLayout{
    override var collectionViewContentSize: CGSize{
        return CGSize(width: 0, height: totalHeight.max()! + sectionInset.bottom);
    }
}


