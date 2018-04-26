//
//  WXApiWrap.swift
//  SwiftDemos
//
//  Created by qianzhao on 2018/4/25.
//  Copyright © 2018年 qianzhao. All rights reserved.
//

import QBToast
import RxCocoa
import RxSwift
import Util

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
private let APPID = "wxa1f06899243f8b14"
private let MiniProgramWebPageUrl = "http://baidu.com"
private let MiniProgramBrandUserName = ""
private let MiniProgramSharePath = "/pages/index/index"


class WXApiWrap: NSObject {
    public static let shared = WXApiWrap()
    public let shareResult = PublishSubject<WXErrCodeWrap>()
    public let loginResult:PublishSubject<String> = PublishSubject<String>()
    var randomStateStr: String?
    public func setup() {
        print("setup WXApiWrap...")
        WXApi.registerApp(APPID, enableMTA: true)
    }
}

extension WXApiWrap{
    func quickLogin() -> Void {
        randomStateStr = String.randomSmallCaseString(length: 10)
        let req: SendAuthReq = SendAuthReq()
        req.scope = "snsapi_userinfo,snsapi_base"
        req.state = randomStateStr
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
        sendReq.scene = Int32(convertChannelToWXScene(channel))
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
            
        case .urlParams:
            let message: WXMediaMessage = WXMediaMessage.init()
            let obj: WXWebpageObject = WXWebpageObject()
            obj.webpageUrl = content.url;
            message.mediaObject = obj;
            message.description = content.summary
            message.title = content.title
            message.thumbData = content.thumbData
            sendReq.message = message;
            
        case .miniProgram:
            let ext: WXMiniProgramObject = WXMiniProgramObject();
            ext.webpageUrl = MiniProgramWebPageUrl;
            ext.userName = MiniProgramBrandUserName;
            ext.path = MiniProgramSharePath;
            
            let message: WXMediaMessage = WXMediaMessage()
            message.title = content.title
            message.description = content.summary
            message.thumbData = content.thumbData
            message.mediaObject = ext
            sendReq.message = message;
            
        case .gif:
            let message: WXMediaMessage = WXMediaMessage()
            message.title = content.title! + "aa"
            message.description = content.description
            message.thumbData = content.thumbData;
            
            let imgo:WXEmoticonObject = WXEmoticonObject.init();
            imgo.emoticonData = content.imageData;
            message.mediaObject = imgo;
            message.mediaTagName = "WECHAT_TAG_TRANSLATOR";
            
            sendReq.message = message
            sendReq.bText = false
//        default:
//            sendReq.bText = true
//            sendReq.text = content.title
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
        if convertWXErrorCode(rsp.errCode) == .success && randomStateStr == rsp.state {
            print("success ///")
        }
    }
    
    fileprivate func responseSendMessage(_ rsp: SendMessageToWXResp) -> Void{
        print("SendMessageToWXResp: \(rsp)")
        let errCode = convertWXErrorCode(rsp.errCode)
        shareResult.onNext(errCode)
//        if convertWXErrorCode(rsp.errCode) == .success {
        TestClass1.test4()
//            print("success ///")
//            debugPrint("success debugPrint ///")
//            QBToaster.showText("hello world!\nHow are you? What", pos: .center)
//        }
    }
}

extension String{
    static func randomSmallCaseString(length: Int) -> String {
        var output = ""
        for _ in 0..<length {
            let randomNumber = arc4random() % 26 + 97
            let randomChar = Character(UnicodeScalar(randomNumber)!)
            output.append(randomChar)
        }
        return output
    }
}
