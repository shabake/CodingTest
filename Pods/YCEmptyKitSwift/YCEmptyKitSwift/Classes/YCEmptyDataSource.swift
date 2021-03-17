//
//  SYEmptyDataSource.swift
//  SYEmptyKitDemo
//
//  Created by Xyy on 2020/7/16.
//  Copyright © 2020 sany. All rights reserved.
//

import UIKit

// MARK: - YCEmptyDataSource
public protocol YCEmptyDataSource: class {
    
    /// 设置要忽略Section数组，默认为nil
    /// - Parameter view: 空页面的父视图
    func sectionsToIgnore(in view: UIView) -> [Int]?
    
    /// 设置空页面图片
    /// - Parameter view: 空页面的父视图
    func imageForEmpty(in view: UIView) -> UIImage?
    
    /// 设置空页面图片的颜色
    /// - Parameter view: 空页面的父视图
    func imageTintColorForEmpty(in view: UIView) -> UIColor?
    
    /// 设置空页面图片动画
    /// - Parameter view: 空页面的父视图
    func imageAnimationForEmpty(in view: UIView) -> CAAnimation?
    
    /// 设置空页面标题文字
    /// - Parameter view: 空页面的父视图
    func titleForEmpty(in view: UIView) -> NSAttributedString?
    
    /// 设置空页面描述文字
    /// - Parameter view: 空页面的父视图
    func descriptionForEmpty(in view: UIView) -> NSAttributedString?
    
    /// 设置空页面相当于中间的竖直偏移，默认0
    /// - Parameter view: 空页面的父视图
    func verticalOffsetForEmpty(in view: UIView) -> CGFloat
    
    /// 设置空页面的水平间距，默认20
    /// - Parameter view: 空页面的父视图
    func horizontalSpaceForEmpty(in view: UIView) -> CGFloat
    
    /// 设置空页面的背景颜色
    /// - Parameter view: 空页面的父视图
    func backgroundColorForEmpty(in view: UIView) -> UIColor
    
    /// 设置空页面自定义View
    /// - Parameter view: 空页面的父视图
    func customViewForEmpty(in view: UIView) -> UIView?
    
    /// 设置空页面按钮的最小宽度
    /// - Parameter view: 空页面的父视图
    func buttonMinWidthForEmpty(in view: UIView) -> CGFloat?
    
    /// 设置空页面按钮的属性
    /// - Parameters:
    ///   - view: 空页面的父视图
    ///   - button: 空页面的按钮
    func prepareButtonForEmpty(in view: UIView, button: UIButton)
}

// MARK: - YCEmptyDataSource默认实现
public extension YCEmptyDataSource {
    
    func sectionsToIgnore(in view: UIView) -> [Int]? {
        return nil
    }
    
    func imageForEmpty(in view: UIView) -> UIImage? {
        return nil
    }
    
    func imageTintColorForEmpty(in view: UIView) -> UIColor? {
        return nil
    }
    
    func imageAnimationForEmpty(in view: UIView) -> CAAnimation? {
        return nil
    }
    
    func titleForEmpty(in view: UIView) -> NSAttributedString? {
        return nil
    }
    
    func descriptionForEmpty(in view: UIView) -> NSAttributedString? {
        return nil
    }
    
    func verticalOffsetForEmpty(in view: UIView) -> CGFloat {
        return 0
    }
    
    func verticalSpaceForEmpty(in view: UIView) -> CGFloat {
        return 20
    }
    
    func horizontalSpaceForEmpty(in view: UIView) -> CGFloat {
        return 20
    }
    
    func customViewForEmpty(in view: UIView) -> UIView? {
        return nil
    }
    
    func backgroundColorForEmpty(in view: UIView) -> UIColor {
        return .clear
    }
    
    func buttonMinWidthForEmpty(in view: UIView) -> CGFloat? {
        return nil
    }
    
    func prepareButtonForEmpty(in view: UIView, button: UIButton) {
        
    }
}

// MARK: - UIViewController
public extension YCEmptyDataSource where Self: UIViewController {
    func verticalOffsetForEmpty(in view: UIView) -> CGFloat {
        if let nav = self.navigationController, !nav.isNavigationBarHidden, nav.navigationBar.isTranslucent {
            return -nav.navigationBar.frame.maxY / 2
        }
        return 0
    }
}

// MARK: - UITableViewController
public extension YCEmptyDataSource where Self: UITableViewController {
    func verticalOffsetForEmpty(in view: UIView) -> CGFloat {
        var offset: CGFloat = 0
        if let nav = self.navigationController, !nav.isNavigationBarHidden, nav.navigationBar.isTranslucent {
            offset -= nav.navigationBar.frame.maxY / 2
        }
        if let tableHeaderView = tableView.tableHeaderView, !tableHeaderView.isHidden {
            return 0
        }
        return offset
    }
}
