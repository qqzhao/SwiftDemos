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
    
    func isAvailable() -> Bool {
        return WXApi.isWXAppInstalled()
    }
    
    func handleURL(_ url: URL) -> Bool {
        return WXApi.handleOpen(url, delegate: WXApiWrap.shared)
    }
    
    func shareContent(_ content: ShareContent, channel: ShareChannel) -> Void {
        guard channel == .wechatTimeline || channel == .wechatSession || channel == .wechatMiniProgram else {
            return
        }
        
        let sendReq: SendMessageToWXReq = SendMessageToWXReq()
        sendReq.scene = convertChannelToWXScene(channel)
        switch content.contentType {
        case .titleOnly:
            sendReq.bText = true
            sendReq.text = content.title
            
        case .imageOnly:
            let message: WXMediaMessage = WXMediaMessage.init()
            let obj: WXImageObject = WXImageObject()
            obj.imageData = content.imageData;
            message.mediaObject = obj;
            sendReq.message = message;
            
        case .titleImage:
            sendReq.bText = false
            let message: WXMediaMessage = WXMediaMessage.init()
            let obj: WXImageObject = WXImageObject()
            obj.imageData = content.imageData;
            message.mediaObject = obj;
            message.title = content.title
            sendReq.message = message;
            
        case .summaryImage:
            let message: WXMediaMessage = WXMediaMessage.init()
            let obj: WXImageObject = WXImageObject()
            obj.imageData = content.imageData;
            message.mediaObject = obj;
            message.description = content.summary
            sendReq.message = message;
            
        case .titleSummaryImage:
            let message: WXMediaMessage = WXMediaMessage.init()
            let obj: WXImageObject = WXImageObject()
            obj.imageData = content.imageData;
            message.mediaObject = obj;
            message.title = content.title
            message.description = content.summary
            sendReq.message = message;
            
        case .urlOnly:
            let message: WXMediaMessage = WXMediaMessage.init()
            let obj: WXWebpageObject = WXWebpageObject()
            obj.webpageUrl = content.url;
            message.mediaObject = obj;
            sendReq.message = message;
            
        case .titleUrl:
            let message: WXMediaMessage = WXMediaMessage.init()
            let obj: WXWebpageObject = WXWebpageObject()
            obj.webpageUrl = content.url;
            message.mediaObject = obj;
            message.title = content.title
            sendReq.message = message;
            
        case .SummaryUrl:
            let message: WXMediaMessage = WXMediaMessage.init()
            let obj: WXWebpageObject = WXWebpageObject()
            obj.webpageUrl = content.url;
            message.mediaObject = obj;
            message.description = content.summary
            sendReq.message = message;
            
        case .titleSummaryUrl:
            let message: WXMediaMessage = WXMediaMessage.init()
            let obj: WXWebpageObject = WXWebpageObject()
            obj.webpageUrl = content.url;
            message.mediaObject = obj;
            message.description = content.summary
            message.title = content.title
            sendReq.message = message;
            
        case .titleSummaryImageUrl:
            let message: WXMediaMessage = WXMediaMessage.init()
            let obj: WXWebpageObject = WXWebpageObject()
            obj.webpageUrl = content.url;
            message.mediaObject = obj;
            message.description = content.summary
            message.title = content.title
            message.thumbData = content.thumbData
            sendReq.message = message;
            
        default:
            sendReq.bText = true
            sendReq.text = content.title
        }
        
        let success: Bool = WXApi.send(sendReq)
        print("success = \(success)")
    }
}

extension WXApiWrap: WXApiDelegate{
    func onReq(_ req: BaseReq!) {
        print("onReq: \(req)")
    }
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
