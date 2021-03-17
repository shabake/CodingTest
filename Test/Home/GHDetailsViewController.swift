//
//  GHDetailsViewController.swift
//  CodingTest
//
//  Created by mac on 2021/3/16.
//

import UIKit

class GHDetailsViewController: UIViewController {
    
    var cellFrame = CellFrame();
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "详情"
        
        if cellFrame.model?.imgUrls != nil {
            self.view .addSubview(self.custom)
            self.custom.frame = CGRect(x: 20, y: kNavBtm + 10, width: UIScreen.main.bounds.size.width - 40 , height: ((UIScreen.main.bounds.size.width - 40)  * 3) / 4)
            self.custom.setImages(cellFrame: cellFrame)
        }
        
        if cellFrame.model?.content != nil {
            self.view .addSubview(self.content)
            var y:CGFloat = kNavBtm + 10
            if cellFrame.model?.imgUrls != nil {
                y = self.custom.frame.maxY + 10
            };
            self.content.frame = CGRect(x: 20, y: y, width: UIScreen.main.bounds.size.width - 40 , height: (cellFrame.model?.content?.stringHeightWidth(fontSize: 16, width: UIScreen.main.bounds.width - 40))!)
            self.content.text = cellFrame.model?.content
        }

    }
    
    lazy var custom:CusView = {
        let custom = CusView()
        custom.backgroundColor = .red
        return custom
    }()
    
    lazy var content:UILabel = {
        let content = UILabel()
        content.numberOfLines = 0
        content.textColor = UIColor.darkGray
        content.font = UIFont.systemFont(ofSize: 16)
        return content
    }()
}
