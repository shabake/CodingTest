//
//  GHNetwork.swift
//  GHNetwork
//
//  Created by RAIN on 2016/11/15.
//  Copyright © 2016年 Smartech. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireNetworkActivityIndicator
import MBProgressHUD


enum ResponseType {
    case json, string, data
}

enum DataResponsePackage {
    
    case json(DataResponse<Any>)
    case string(DataResponse<String>)
    case data(DataResponse<Data>)
}


typealias ResponseJSON = [String: Any]
typealias ResponseString = String
typealias ResponseData = Data
typealias HttpStatusCode = Int

typealias SuccessTask = (ResponseJSON?, ResponseString?, ResponseData?, HttpStatusCode?, DataRequest, DataResponsePackage) -> Void
typealias FailureTask = (Error?, HttpStatusCode?, DataRequest, DataResponsePackage) -> Void


struct GHNetwork { }


//  MARK: - Public Methods

extension GHNetwork {

    /// 通用请求方法
    /// - Parameters:
    ///   - urlString: 请求地址
    ///   - method: 请求方法
    ///   - parameters: 请求参数
    ///   - encoding: 请求参数编码
    ///   - headers: 请求头
    ///   - timeoutInterval: 超时时长
    ///   - showIndicator: 是否显示 Indicator
    ///   - responseType: 返回数据格式类型
    ///   - success: 请求成功的 Task
    ///   - failure: 请求失败的 Task
    public static func request(
        with urlString: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        timeoutInterval: TimeInterval = 30.0,
        showIndicator: Bool = false,
        responseType: ResponseType = .json,
        success: @escaping SuccessTask,
        failure: @escaping FailureTask)
    {
        if showIndicator == true {
            GHNetwork.showIndicator()
            GHNetwork.showActivityIndicator()
        }

        DispatchQueue.global().async {
            do {
                let urlPath = try urlPathString(by: urlString)

                let request = Alamofire.request(urlPath, method: method, parameters: parameters, encoding: URLEncoding.queryString, headers: headers)

                switch responseType {
                    case .json:
                        GHNetwork.responseJSON(with: request, success: success, failure: failure)

                    case .string:
                        GHNetwork.responseString(with: request, success: success, failure: failure)

                    case .data:
                        GHNetwork.responseData(with: request, success: success, failure: failure)
                }
            } catch {
                print(error)
                GHNetwork.hideIndicator()
            }
        }
    }

}


//  MARK: - Private Methods

extension GHNetwork {

    private static func responseJSON(
        with request: DataRequest,
        success: @escaping SuccessTask,
        failure: @escaping FailureTask)
    {
        request.responseJSON { (responseJSON) in
            print("GHNetwork request debugDescription: \n", responseJSON.debugDescription, separator: "")

            let httpStatusCode = responseJSON.response?.statusCode
            guard let json = responseJSON.value else {
                failure(responseJSON.error, httpStatusCode, request, .json(responseJSON))
                GHNetwork.hideIndicator()
                return
            }
            var responseData = Data()
            if let data = responseJSON.data {
                responseData = data
            }
            let string = String(data: responseData, encoding: .utf8)

            success(json as? [String : Any], string, responseJSON.data, httpStatusCode, request, .json(responseJSON))
            GHNetwork.hideIndicator()
        }
    }

    private static func responseString(
        with request: DataRequest,
        success: @escaping SuccessTask,
        failure: @escaping FailureTask)
    {
        request.responseString { (responseString) in
            print("GHNetwork request debugDescription: \n", responseString.debugDescription, separator: "")

            let httpStatusCode = responseString.response?.statusCode
            guard let string = responseString.value else {
                failure(responseString.error, httpStatusCode, request, .string(responseString))
                GHNetwork.hideIndicator()
                return
            }

            success(nil, string, responseString.data, httpStatusCode, request, .string(responseString))
            GHNetwork.hideIndicator()
        }
    }

    private static func responseData(
        with request: DataRequest,
        success: @escaping SuccessTask,
        failure: @escaping FailureTask)
    {
        request.responseData { (responseData) in
            print("GHNetwork request debugDescription: \n", responseData.debugDescription, separator: "")

            let httpStatusCode = responseData.response?.statusCode
            guard let data = responseData.value else {
                failure(responseData.error, httpStatusCode, request, .data(responseData))
                GHNetwork.hideIndicator()
                return
            }
            let string = String(data: data, encoding: .utf8)

            success(nil, string, data, httpStatusCode, request, .data(responseData))
            GHNetwork.hideIndicator()
        }
    }

    private static func urlPathString(by urlString: String) throws -> String {
        if let host = GHNetworkConfig.shared.baseURL, host.GH_hasHttpPrefix {
            if host.hasSuffix("/") && urlString.hasPrefix("/") {
                var fixHost = host
                fixHost.GH_removeLast(ifHas: "/")
                return fixHost + urlString
            } else if host.hasSuffix("/") == false && urlString.hasPrefix("/") == false {
                return host + "/" + urlString
            } else {
                return host + urlString
            }
        } else if urlString.GH_hasHttpPrefix {
            return urlString
        } else {
            throw GHNetworkError.wrongURLFormat
        }
    }
    
}


// MARK: - Indicator View

extension GHNetwork {

    /// 在 Status Bar 上显示 Activity Indicator
    /// - Parameters:
    ///   - startDelay: 开始延迟时间
    ///   - completionDelay: 结束延迟时间
    public static func showActivityIndicator(startDelay: TimeInterval = 0.0,
                                             completionDelay: TimeInterval = 0.7)
    {
        NetworkActivityIndicatorManager.shared.isEnabled = true
        NetworkActivityIndicatorManager.shared.startDelay = startDelay
        NetworkActivityIndicatorManager.shared.completionDelay = completionDelay
    }

    /// 显示 indicator
    /// - Parameters:
    ///   - mode: 显示模式，默认为 .indeterminate
    ///   - text: 显示的文字，默认为空
    private static func showIndicator(mode: MBProgressHUDMode = .indeterminate,
                                      text: String = "")
    {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.keyWindow else { return }
            let hud = MBProgressHUD.showAdded(to: window, animated: true)
            hud.mode = mode
            hud.label.text = text
        }
    }

    /// 隐藏 indicator
    private static func hideIndicator() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.keyWindow else { return }
            MBProgressHUD.hide(for: window, animated: true)
        }
    }

}


// MARK: - Proxy

extension GHNetwork {

    /// 是否设置网络代理
    public static var isSetupProxy: Bool {
        if proxyType == kCFProxyTypeNone {
            #if DEBUG
            print("当前未设置网络代理")
            #endif
            return false
        } else {
            #if DEBUG
            print("当前设置了网络代理")
            #endif
            return true
        }
    }

    /// 网络代理主机名
    public static var proxyHostName: String {
        let hostName = proxyInfos.object(forKey: kCFProxyHostNameKey) as? String ?? "Proxy Host Name is nil"
        #if DEBUG
        print("Proxy Host Name: \(hostName)")
        #endif
        return hostName
    }

    /// 网络代理端口号
    public static var proxyPortNumber: String {
        let portNumber = proxyInfos.object(forKey: kCFProxyPortNumberKey) as? String ?? "Proxy Port Number is nil"
        #if DEBUG
        print("Proxy Port Number: \(portNumber)")
        #endif
        return portNumber
    }

    /// 网络代理类型
    public static var proxyType: CFString {
        let type = proxyInfos.object(forKey: kCFProxyTypeKey) ?? kCFProxyTypeNone
        #if DEBUG
        print("Proxy Type: \(type)")
        #endif
        return type
    }

    /// 网络代理信息
    private static var proxyInfos: AnyObject {
        let proxySetting = CFNetworkCopySystemProxySettings()!.takeUnretainedValue()
        let url = URL(string: "https://www.baidu.com")!
        let proxyArray = CFNetworkCopyProxiesForURL(url as CFURL, proxySetting).takeUnretainedValue()

        let proxyInfo = (proxyArray as [AnyObject])[0]
        return proxyInfo
    }

}


// MARK: - VPN

extension GHNetwork {

    /// 是否开启 VPN
    public static var isVPNOn: Bool {
        var flag = false
        let proxySetting = CFNetworkCopySystemProxySettings()?.takeUnretainedValue() as? [AnyHashable: Any] ?? [:]
        let keys = (proxySetting["__SCOPED__"] as? NSDictionary)?.allKeys as? [String] ?? []

        for key in keys {
            let nsKey = key as NSString
            let checkStrings = ["tap", "tun", "ipsec", "ppp"]

            let condition = checkStrings.reduce(false) { (res, string) -> Bool in
                res || nsKey.range(of: string).location != NSNotFound
            }

            if condition {
                #if DEBUG
                print("当前开启了 VPN")
                #endif
                flag = true
                break
            }
        }
        #if DEBUG
        if flag == false {
            print("当前未开启 VPN")
        }
        #endif
        return flag
    }
}


// MARK: - String Extension

fileprivate extension String {

    /// 是否含有 http / https 前缀
    var GH_hasHttpPrefix: Bool {
        return self.hasPrefix("http://") || self.hasPrefix("https://")
    }

    /// 如果含有某个后缀，则删除
    /// - Parameter suffix: 需要删除的后缀
    mutating func GH_removeLast(ifHas suffix: String) {
        if hasSuffix(suffix) {
            removeLast()
        }
    }

}
