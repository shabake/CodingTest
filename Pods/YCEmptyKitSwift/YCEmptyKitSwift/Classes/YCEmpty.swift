//
//  YCEmpty.swift
//  YCEmptyKitDemo
//
//  Created by Xyy on 2020/7/16.
//  Copyright © 2020 sany. All rights reserved.
//

import UIKit

/// Wrapper
public final class YCEmpty<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

/// Compatible
public protocol YCEmptyCompatible {
    associatedtype YCEmptyCompatibleType
    var ycEmpty: YCEmptyCompatibleType { get }
}

public extension YCEmptyCompatible {
    var ycEmpty: YCEmpty<Self> {
        return YCEmpty(self)
    }
}

/// UIScrollView SYEmptyCompatible
extension UIScrollView: YCEmptyCompatible {}
