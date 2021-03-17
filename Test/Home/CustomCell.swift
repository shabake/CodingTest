//
//  CustomCell.swift
//  CodingTest
//
//  Created by mac on 2021/3/16.
//


import UIKit
import SnapKit
import Kingfisher

extension String {
    func stringHeightWidth(fontSize:CGFloat,width:CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let size = CGSize(width: width, height: CGFloat(MAXFLOAT))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        let attributes = [kCTFontAttributeName:font,kCTParagraphStyleAttributeName:paragraphStyle]
        let text = self as NSString
        let rect = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes as [NSAttributedString.Key : Any], context: nil)
        return rect.height
    }
}

class CustomCell: UITableViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView .addSubview(self.content)
        self.contentView .addSubview(self.custom)
        self.contentView .addSubview(self.line)
    }
        
    func setModel(cellFrame:CellFrame,indexPath:NSIndexPath ,count:NSInteger)  {
        self.content.frame = cellFrame.contentRect!
        self.content.text = cellFrame.model?.content
        self.custom.frame = cellFrame.customRect!
        self.custom.setImages(cellFrame: cellFrame)
        self.line.frame = cellFrame.lineRect!
        self.line.isHidden = false
        if indexPath.row == count - 1 {
            self.line.isHidden = true
        }
    }

    lazy var content:UILabel = {
        let content = UILabel()
        content.numberOfLines = 0
        content.textColor = UIColor.darkGray
        content.font = UIFont.systemFont(ofSize: 16)
        return content
    }()
    
    lazy var custom : CusView = {
        let custom = CusView()
        return custom
    }()
    
    lazy var line : UIView = {
        let line = UIView()
        line.backgroundColor = .lightText
        return line
    }()
}


















