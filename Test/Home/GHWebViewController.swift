//
//  GHWebViewController.swift
//  CodingTest
//
//  Created by mac on 2021/3/16.
//

import UIKit
import WebKit

class GHWebViewController: UIViewController {
    var cellFrame = CellFrame();

    var webview = WKWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "link链接"
        self.view.backgroundColor = .white

        if cellFrame.model?.content != nil {
            self.view .addSubview(self.content)
            let y:CGFloat = kNavBtm + 10
            self.content.frame = CGRect(x: 20, y: y, width: UIScreen.main.bounds.size.width - 40 , height: (cellFrame.model?.content?.stringHeightWidth(fontSize: 16, width: UIScreen.main.bounds.width - 40))!)
            self.content.text = cellFrame.model?.content
        }
        
        let webview = WKWebView(frame: CGRect(x: 0, y: self.content.frame.maxY + 10, width: self.view.frame.width, height: self.view.frame.height))
        let url = NSURL(string: cellFrame.model!.link!)
        let request = NSURLRequest(url: url! as URL)
        webview.load(request as URLRequest)
        self.view.addSubview(webview)
    }
    
    lazy var content:UILabel = {
        let content = UILabel()
        content.numberOfLines = 0
        content.textColor = UIColor.darkGray
        content.font = UIFont.systemFont(ofSize: 16)
        return content
    }()
}

