//
//  ViewController.swift
//  CodingTest
//
//  Created by mac on 2021/3/14.
//

import UIKit
import YCEmptyKitSwift

class GHListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var list = [CellFrame]()
    lazy var table : UITableView = {
        let table = UITableView(frame: CGRect(x:0,y:0,width:UIScreen.main.bounds.width,height:UIScreen.main.bounds.height), style: UITableView.Style.plain)
        table.delegate = self
        table.dataSource = self
        table.ycEmpty.delegate = self
        table.ycEmpty.dataSource = self
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table .register(CustomCell.self, forCellReuseIdentifier: "register")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Coding Test"
        self.view .addSubview(table)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "空页面", style: .done, target: self, action: #selector(noData))
        loadData()
    }
    
    @objc func noData() {
        self.list.removeAll()
        self.table .reloadData()
    }

    func loadData() {
        for i in 0 ..< 5 {
            let model = Model()
            let cellFrame = CellFrame()
            if i == 0 {
                model.type = "text"
                model.content = "首先，感谢您抽出宝贵的时间进行 Coding Test, 这个 Coding Test 的目标是实现一个多类型的列表页以及对应的详情页面，您可以自由发挥实现整体效果，我们将根据您的最终作品做一个评估考核。"
            } else if i == 1 {
                model.content = ""
                model.type = "img"
                model.imgUrls = [
                      "https://www.arcblockio.cn/blog/static/2c6120caf67e5c927e7254f115e58fcd/38a09/cover.jpg"
                    ]
            }  else if i == 2 {
                model.type = "text-img"
                model.content = "下面是 ArcBlock DevCon 2020 的精彩图片...(可能是很长的文字，多张不同图片，图片可以是0张或者很多张，这里只给了三张为例子"
                
                model.imgUrls =  [
                     "https://www.arcblockio.cn/blog/static/88b798d281e42ae3570a25e208e89d39/38a09/cover.jpg",
                     "https://www.arcblockio.cn/blog/static/461a789adcb0f768d46d60163ee73bd3/f5292/devcon.jpg",
                     "https://www.arcblock.io/blog/static/fb2e8a2c56da3fadc4ff21ed5d96a4bc/38a09/cover.jpg"
                   ]
            } else if (i == 3) {
                model.type = "text-img"
                model.content = "这是 ArcBlock ABT Node 界面截图"
                model.imgUrls = [
                      "https://www.arcblockio.cn/blog/static/e8e5ec2f2824b819380b605d6c50cc2b/92c65/blocklets.png"
                    ]
            } else {
                model.type = "text-link"
                model.content = "这是 ABT 钱包的官网页面, 欢迎体验（需要考虑链接可访问）"
                model.link = "https://abtwallet.io/zh/"
            }
            cellFrame.setMModel(model: model, index: i)
            self.list.append(cellFrame)
        }
        
       self.table.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CustomCell = tableView .dequeueReusableCell(withIdentifier: "register", for: indexPath) as! CustomCell
        cell.setModel(cellFrame: self.list[indexPath.row], indexPath: indexPath as NSIndexPath, count: self.list.count)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellFrame:CellFrame = self.list[indexPath.row]
        return cellFrame.cellH!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cellFrame:CellFrame = self.list[indexPath.row];
        
        if cellFrame.model?.type == "text-link" {
            if (cellFrame.model?.link) != nil {
                let webViewVc = GHWebViewController()
                webViewVc.cellFrame = cellFrame
                self.navigationController?.pushViewController(webViewVc, animated: true)
            }
        } else {
            let vc = GHDetailsViewController()
            vc.cellFrame = cellFrame
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


extension GHListViewController: YCEmptyDataSource {
    
    func imageForEmpty(in view: UIView) -> UIImage? {
        return UIImage(named: "placeholder.jpg")
    }
    
    func titleForEmpty(in view: UIView) -> NSAttributedString? {
        return NSAttributedString(string: "没有数据")
    }
    
    func descriptionForEmpty(in view: UIView) -> NSAttributedString? {
        return NSAttributedString(string: "点击重新加载")
    }
    
    func horizontalSpaceForEmpty(in view: UIView) -> CGFloat {
        return 20
    }
}

extension GHListViewController: YCEmptyDelegate {
    
    func emptyView(_ emptyView: UIView, tappedIn view: UIView) {
        loadData()
    }
    func emptyButton(_ button: UIButton, tappedIn view: UIView) {
        loadData()
    }
}







































