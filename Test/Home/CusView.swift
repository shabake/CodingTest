//
//  CusView.swift
//  CodingTest
//
//  Created by mac on 2021/3/16.
//


import UIKit
import Foundation
import Kingfisher

public class CusView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var imgViews = [UIImageView]()
    
    var list = [String]()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // 给cell赋值
    func setImages(cellFrame:CellFrame)  {
        if let imgUrls = cellFrame.model?.imgUrls {
            let count = imgUrls.count
            if count == 1 {
                let imgView = UIImageView()
                imgView.isUserInteractionEnabled = false
                imgView.contentMode = UIView.ContentMode.scaleToFill
                let url = URL(string: imgUrls.firstObject as! String)
                imgView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
                imgView.frame = self.bounds
                self .addSubview(imgView)
            } else {
                list = imgUrls as! [String]
                let flowLayout : UICollectionViewFlowLayout = {
                    let flt = UICollectionViewFlowLayout()
                    flt.minimumLineSpacing = 0
                    flt.minimumInteritemSpacing = 0
                    flt.scrollDirection = UICollectionView.ScrollDirection.horizontal
                    flt.itemSize = CGSize(width: self.bounds.size.width, height: self.bounds.size.height)
                    return flt
                }()
                
                let collectionView : UICollectionView = {
                    let col = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
                    col.bounces = false
                    col.delegate = self
                    col.dataSource = self
                    col.isPagingEnabled = true
                    col .register(CustomItem.self, forCellWithReuseIdentifier: "cell")
                    col.showsHorizontalScrollIndicator = false
                    return col
                }()
                collectionView.frame = self.bounds
                self .addSubview(collectionView)
                collectionView .reloadData()
            }
        }        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.list.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CustomItem = collectionView .dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomItem
        cell.setImageName(imageName: self.list[indexPath.row], indexPath: indexPath as NSIndexPath, count: self.list.count)
        
        cell.clickLeftArrow = { () in
            if indexPath.row == 0 {
                return
            }
            collectionView .setContentOffset(CGPoint(x: (Int(UIScreen.main.bounds.size.width) - 40) * (indexPath.row - 1), y: 0), animated: true)
        }
        
        cell.clickRightArrow = { () in
            if indexPath.row == self.list.count - 1 {
                return
            }
            collectionView .setContentOffset(CGPoint(x: (Int(UIScreen.main.bounds.size.width) - 40) * (indexPath.row + 1), y: 0), animated: true)
        }
        
     
        
        return cell
    }
    
  
    
}

