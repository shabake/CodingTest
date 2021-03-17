//
//  header.swift
//  CodingTest
//
//  Created by mac on 2021/3/16.
//
import UIKit

import Foundation

// MARK: - ********* Device Size
public var kScreenWid: CGFloat { return UIScreen.main.bounds.size.width }

public var kScreenHei: CGFloat { return UIScreen.main.bounds.size.height }

func isIphonex() -> Bool {
        var isIphonex = false
        if #available(iOS 11.0, *),
           UIApplication.shared.delegate?
                .window??.safeAreaInsets.bottom != 0 {
            isIphonex = true
        }
        return isIphonex
    }

public var kIsX: Bool { return isIphonex()}
public var kNavBtm: CGFloat { return kNavTop + 44 }

public var kNavTop: CGFloat {
    if kIsX { return 44 }
    return 20
}

public var kHairHei: CGFloat {
    if kIsX { return 30 }
    return 0
}

public var kSafeBtm: CGFloat {
    if kIsX { return 34 }
    return 0
}

public var kTabbarHei: CGFloat {
    if kIsX { return 34 + 49 }
    return 49
}
