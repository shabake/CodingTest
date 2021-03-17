//
//  GHNetworkConfig.swift
//  GHNetwork
//
//  Created by RAIN on 2019/12/6.
//  Copyright © 2019 Smartech. All rights reserved.
//

import Foundation

class GHNetworkConfig {

    static let shared = GHNetworkConfig()

    var baseURL: String? = nil

    private init() { }
}
