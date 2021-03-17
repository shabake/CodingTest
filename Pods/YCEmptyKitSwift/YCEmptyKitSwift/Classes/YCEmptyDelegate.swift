//
//  SYEmptyDelegate.swift
//  SYEmptyKitDemo
//
//  Created by Xyy on 2020/7/16.
//  Copyright © 2020 sany. All rights reserved.
//

import UIKit

// MARK: - YCEmptyDelegate
public protocol YCEmptyDelegate: class {
    
    /// 设置空页面展示的时候是否显示淡入动画（默认true)
    /// - Parameter view: 空页面的父视图
    func emptyShouldFadeIn(in view: UIView) -> Bool
    
    /// 设置空页面是否展示（默认true)
    /// - Parameter view: 空页面的父视图
    func emptyShouldDisplay(in view: UIView) -> Bool
    
    /// 设置空页面是否允许触摸（默认true)
    /// - Parameter view: 空页面的父视图
    func emptyShouldAllowTouch(in view: UIView) -> Bool
    
    /// 设置空页面是否允许点击（默认true)
    /// - Parameter view: 空页面的父视图
    func emptyShouldEnableTapGesture(in view: UIView) -> Bool
    
    /// 设置空页面是否可以滚动动（默认true)
    /// - Parameter view: 空页面的父视图
    func emptyShouldAllowScroll(in view: UIView) -> Bool
    
    /// 设置空页面图片是否展示动画（默认true)
    /// - Parameter view: 空页面的父视图
    func emptyShouldAnimateImageView(in view: UIView) -> Bool
    
    /// 设置空页面按钮的点击事件
    /// - Parameters:
    ///   - button: 空页面的按钮
    ///   - view: 空页面的父视图
    func emptyButton(_ button: UIButton, tappedIn view: UIView)
    
    /// 设置空页面的点击事件
    /// - Parameters:
    ///   - emptyView: 空页面
    ///   - view: 空页面的父视图
    func emptyView(_ emptyView: UIView, tappedIn view: UIView)
    
    /// 设置空页面将要出现的回调
    /// - Parameter view: 空页面的父视图
    func emptyWillAppear(in view: UIView)
    
    /// 设置空页面已经出现的回调
    /// - Parameter view: 空页面的父视图
    func emptyDidAppear(in view: UIView)
    
    /// 设置空页面将要消失的回调
    /// - Parameter view: 空页面的父视图
    func emptyWillDisAppear(in view: UIView)
    
    /// 设置空页面已经消失的回调
    /// - Parameter view: 空页面的父视图
    func emptyDidDisAppear(in view: UIView)
    
    /// 是否允许自动增加Inset来调整位置（默认false)
    /// - Parameter view: 空页面的父视图
    func emptyShouldAutoAddInsetWhenSuperviewIsScrollView(in view: UIView) -> Bool
}

// MARK: - YCEmptyDelegate默认实现
public extension YCEmptyDelegate {
    
    func emptyShouldFadeIn(in view: UIView) -> Bool {
        return true
    }
    
    func emptyShouldDisplay(in view: UIView) -> Bool {
        return true
    }
    
    func emptyShouldAllowTouch(in view: UIView) -> Bool {
        return true
    }
    
    func emptyShouldEnableTapGesture(in view: UIView) -> Bool {
        return true
    }
    
    func emptyShouldAllowScroll(in view: UIView) -> Bool {
        return true
    }
    
    func emptyShouldAnimateImageView(in view: UIView) -> Bool {
        return true
    }
    
    func emptyButton(_ button: UIButton, tappedIn view: UIView) {}
    
    func emptyView(_ emptyView: UIView, tappedIn view: UIView) {}
    
    func emptyWillAppear(in view: UIView) {}
    
    func emptyDidAppear(in view: UIView) {}
    
    func emptyWillDisAppear(in view: UIView) {}
    
    func emptyDidDisAppear(in view: UIView) {}
    
    /// 是否允许自动增加Inset来调整位置（默认false)
    func emptyShouldAutoAddInsetWhenSuperviewIsScrollView(in view: UIView) -> Bool {
        return false
    }
}
