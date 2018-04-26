//
//  WxApiWrap+Test.swift
//  SwiftDemos
//
//  Created by qianzhao on 2018/4/25.
//  Copyright © 2018年 qianzhao. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa
import QBToast

private var shareDisposeBag = DisposeBag()
private var loginDisposeBag = DisposeBag()
private var myLoginDisposeBag = DisposeBag()

extension WXApiWrap {
    
    func test() -> Void {
//        test10()
//        testLogin()
//        myLoginDisposeBag = DisposeBag()
        
//        self.myLogin("").subscribe(onNext: { (info) in
//            print("info = \(info)")
//        }, onError: { (err) in
//            print("err222 = \(err)")
//        }).disposed(by: myLoginDisposeBag)
        
        self.myLogin2("").subscribe(onSuccess: { (info) in
            print("info = \(info)")
        }, onError: { (err) in
            print("err222 = \(err)")
        }).disposed(by: myLoginDisposeBag)
    }
    
    fileprivate func testLogin() -> Void {
        WXApiWrap.shared.quickLogin()
        loginDisposeBag = DisposeBag()
        WXApiWrap.shared.loginResult.subscribe(onNext: { [weak self](_ code:String) in
            self?.loginCallback(code)
        }, onError: { (_ error: Error) in
            print("error = \(error)")
        }, onCompleted: {
            print("onCompleted")
        }).disposed(by: loginDisposeBag)
    }
    
    fileprivate func test1() -> Void {
        let content = ShareContent("this is title", url: "http://baidu.com", summary: "summary")
        WXApiWrap.shared.shareContent(content, channel: .wechatSession)
    }
    
    fileprivate func test2() -> Void {
        let content:ShareContent = ShareContent("this is title", url: "http://baidu.com", summary: "summary")
        let image: UIImage = #imageLiteral(resourceName: "icon_new")
        content.imageData = UIImagePNGRepresentation(image)
        content.contentType = .imageOnly
        WXApiWrap.shared.shareContent(content, channel: .wechatSession)
    }
    
    fileprivate func test10() -> Void {
        let content:ShareContent = ShareContent("this is title", url: "http://baidu.com", summary: "summary")
        content.contentType = .urlParams
        content.thumbData = UIImagePNGRepresentation(#imageLiteral(resourceName: "icon_camera"))
        WXApiWrap.shared.shareContent(content, channel: .wechatTimeline)
        
        shareDisposeBag = DisposeBag() // 每次创建新的，之前的block会被释放。每次一个
        WXApiWrap.shared.shareResult.subscribe(onNext: { [weak self] (_ errCode: WXErrCodeWrap) in
            print("result = \(errCode)")
            self!.shareCallback(errCode)
        }).disposed(by: shareDisposeBag)
    }
    
    fileprivate func test11() -> Void {
        let content:ShareContent = ShareContent("this is title", url: "http://baidu.com", summary: "summary")
        content.contentType = .miniProgram
        content.thumbData = UIImagePNGRepresentation(#imageLiteral(resourceName: "icon_camera"))
        WXApiWrap.shared.shareContent(content, channel: .wechatMiniProgram)
    }
    
    fileprivate func test12() -> Void {
        let content:ShareContent = ShareContent("this is title", url: "http://baidu.com", summary: "summary")
        content.contentType = .gif
        content.thumbData = UIImagePNGRepresentation(#imageLiteral(resourceName: "icon_camera"))
        let fileUrl: String? = Bundle.main.path(forResource: "share", ofType: "gif")
        let data:NSData? = try? NSData(contentsOf: URL(fileURLWithPath: fileUrl!), options: .alwaysMapped)
        content.imageData = data! as Data
        
        WXApiWrap.shared.shareContent(content, channel: .wechatSession)
    }
}

extension WXApiWrap{
    func shareCallback(_ errCode: WXErrCodeWrap) -> Void{
        var toastText = ""
        switch errCode {
        case .success:
            toastText = "分享成功"
        case .errUserCancel:
            toastText = "用户已经取消"
        case .errCommon:
            toastText = "分享失败"
        case .errAuthDeny:
            toastText = "没有权限"
        default:
            toastText = "分享失败"
        }
        QBToaster.showText(toastText, pos: .center)
    }
    
    func loginCallback(_ code: String) -> Void{
        print("loginCallback: \(code)")
    }
}

extension WXApiWrap{
    func myLogin(_ str: String) -> Observable<([String:String])> {
        return Observable<([String:String])>.create { (observer) in
//            loginDisposeBag = DisposeBag()
            WXApiWrap.shared.quickLogin()
            WXApiWrap.shared.loginResult.subscribe(onNext: { (_ code:String) in
                print("aaaa:\(self)")
                let resultInfo:[String:String] = [
                    "code": code,
                    "test": "testString"
                ]
                observer.onNext(resultInfo)
                observer.onCompleted() // 只有一次让其完成
                }, onError: { (_ error: Error) in
                    print("error = \(error)")
                    observer.onError(error)
            }).disposed(by: loginDisposeBag)
            
            return Disposables.create()
        }
    }
    
    // 使用Single 标识只有发送一次成功的结果。但是bbbb:<SwiftDemos.WXApiWrap: 0x1c0279400> 依然后调用多次
    func myLogin2(_ str: String) -> Single<([String:String])> {
        return Single<([String:String])>.create { (single) in
            WXApiWrap.shared.quickLogin()
            WXApiWrap.shared.loginResult.subscribe(onNext: { (_ code:String) in
                print("bbbb:\(self)")
                let resultInfo:[String:String] = [
                    "code": code,
                    "test": "testString"
                ]
                single(.success(resultInfo))
            }, onError: { (_ error: Error) in
                print("error = \(error)")
                single(.error(error))
            }).disposed(by: loginDisposeBag)
            return Disposables.create()
        }
    }
}
