//
//  WXApiWrap.swift
//  SwiftDemos
//
//  Created by qianzhao on 2018/4/25.
//  Copyright © 2018年 qianzhao. All rights reserved.
//

import UIKit

/**
 UIKit.framework
 Foundation.framework
 SystemConfiguration.framework
 CoreTelephony.framework
 Security.framework
 libz.tbd
 libc++.tbd
 libsqlite3.tbd
 */
let APPID = "wxa1f06899243f8b14"

class WXApiWrap: NSObject {
    public static let shared = WXApiWrap()
    public func setup() {
        print("setup WXApiWrap...")
        WXApi.registerApp(APPID, enableMTA: true)
    }
}

extension WXApiWrap{
    func quickLogin() -> Void {
        let req: SendAuthReq = SendAuthReq()
        req.scope = "snsapi_userinfo,snsapi_base"
        req.state = "123";
        WXApi.sendAuthReq(req, viewController: nil, delegate: WXApiWrap.shared)
    }
    
    func handleURL(_ url: URL) -> Bool {
        return WXApi.handleOpen(url, delegate: WXApiWrap.shared)
    }
}

extension WXApiWrap: WXApiDelegate{
    func onReq(_ req: BaseReq!) {
        print("onReq: \(req)")
    }
    
    /*! @brief 发送一个sendReq后，收到微信的回应
     *
     * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
     * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
     * @param resp具体的回应内容，是自动释放的
     */
    func onResp(_ resp: BaseResp!) {
        print("resp: \(resp)")
        if resp.isKind(of: SendAuthResp.self) {
            let authRsp:SendAuthResp = resp as! SendAuthResp
            responseSendAuth(authRsp)
        } else if resp.isKind(of: SendMessageToWXResp.self) {
            let authRsp:SendMessageToWXResp = resp as! SendMessageToWXResp
            responseSendMessage(authRsp)
        }
    }
    
    fileprivate func responseSendAuth(_ rsp: SendAuthResp) -> Void{
        print("SendAuthResp: \(rsp)")
        if convertWXErrorCode(rsp.errCode) == .success {
            print("success ///")
        }
    }
    
    fileprivate func responseSendMessage(_ rsp: SendMessageToWXResp) -> Void{
        print("SendMessageToWXResp: \(rsp)")
        if convertWXErrorCode(rsp.errCode) == .success {
            print("success ///")
        }
    }
}

enum WXErrCodeWrap {
    case success,errCommon,errUserCancel,errSendFail,errAuthDeny,errUnsupport
}
func convertWXErrorCode(_ errCode:Int32) -> WXErrCodeWrap{
    var ret: WXErrCodeWrap = .errCommon
    switch errCode {
    case 0:
        ret = .success
    case -1:
        ret = .errCommon
    case -2:
        ret = .errUserCancel
    case -3:
        ret = .errSendFail
    case -4:
        ret = .errAuthDeny
    case -5:
        ret = .errUnsupport
    default:
        ret = .success
    }
    return ret
}

