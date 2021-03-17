//
//  CustomItem.swift
//  CodingTest
//
//  Created by mac on 2021/3/16.
//

import UIKit
import SnapKit
import Kingfisher


class CustomItem: UICollectionViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.init())
        self .addSubview(self.imgView)
        self.imgView .addSubview(self.leftArrow)
        self.imgView .addSubview(self.rightArrow)
        
        self.leftArrow.snp.makeConstraints { (m) in
            m.left.equalTo(self.imgView).offset(20)
            m.centerY.equalTo(self.imgView)
            m.width.equalTo(30)
            m.height.equalTo(50)
        }
        
        self.rightArrow.snp.makeConstraints { (m) in
            m.right.equalTo(self.imgView).offset(-20)
            m.centerY.equalTo(self.leftArrow)
            m.width.height.equalTo(self.leftArrow)
        }
    }
    
    func setImageName(imageName:String ,indexPath:NSIndexPath ,count:NSInteger)  {
        let url = URL(string: imageName)
        imgView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        imgView.frame = self.bounds
        if indexPath.row == 0 {
            self.leftArrow.isHidden = true
            self.rightArrow.isHidden = false
        } else if (indexPath.row == count - 1) {
            self.leftArrow.isHidden = false
            self.rightArrow.isHidden = true
        } else {
            self.leftArrow.isHidden = false
            self.rightArrow.isHidden = false
        }
    }
    
    var clickLeftArrow: (() -> Void)?
    var clickRightArrow: (() -> Void)?
    
    @objc func clickLeftArrowAction() {
        clickLeftArrow?()
    }
    
    @objc func clickRightArrowAction() {
        clickRightArrow?()
    }
    
    lazy var imgView:UIImageView = {
        let img = UIImageView()
        img.contentMode = UIView.ContentMode.scaleToFill
        img.isUserInteractionEnabled = true
        return img
    }()
    
    lazy var leftArrow:UIButton = {
        let button = UIButton()
        button .setImage(UIImage(named: "leftArrow"), for: .normal)
        button.addTarget(self, action: #selector(clickLeftArrowAction), for: .touchUpInside)
        return button
    }()
    
    lazy var rightArrow:UIButton = {
        let button = UIButton()
        button .setImage(UIImage(named: "rightArrow"), for: .normal)
        button.addTarget(self, action: #selector(clickRightArrowAction), for: .touchUpInside)
        return button
    }()
    
}
