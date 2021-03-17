//
//  CellFrame.swift
//  CodingTest
//
//  Created by mac on 2021/3/16.
//  Copyright © 2018年 KKL. All rights reserved.
//

import UIKit


class CellFrame: NSObject {
    var model:Model? ///model
    var contentRect:CGRect?//内容frame
    var customRect:CGRect?//内容frame
    var lineRect:CGRect?
    var cellH:CGFloat?
    
    func setMModel(model:Model,index:NSInteger)  {
        self.model = model
        
        let titleW:CGFloat = UIScreen.main.bounds.width - 40
        var totalHeight:CGFloat = 0;
        let contentX:CGFloat = 20
        let contentY:CGFloat = 10
        let contentW:CGFloat = titleW
    
        
        if model.content?.isEmpty == true {
            self.contentRect = CGRect.zero
        } else {
            self.contentRect = CGRect(x: contentX, y: contentY, width: contentW, height: (model.content?.stringHeightWidth(fontSize: 16, width: contentW))!)
        }
        
        if model.imgUrls == nil || model.imgUrls?.count == 0 {
            self.customRect = CGRect(x: 20, y: self.contentRect?.maxY ?? 0, width: titleW, height: 0.0)
        } else {
            self.customRect = CGRect(x: 20, y: self.contentRect!.maxY + 10 , width: titleW, height: titleW * 3 / 4)
        }
        
        if self.customRect != nil {
            totalHeight = self.customRect!.maxY
        } else if self.contentRect != nil {
            totalHeight = self.contentRect!.maxY
        }

        if totalHeight == 0 {
            self.cellH = 0
        } else {
            self.cellH = totalHeight + 10
        }
        if cellH != 0 {
            self.lineRect = CGRect(x: 20, y:self.cellH! - 1 , width: titleW, height: 1)
        } else {
            self.lineRect = CGRect.zero
        }
    }
}


