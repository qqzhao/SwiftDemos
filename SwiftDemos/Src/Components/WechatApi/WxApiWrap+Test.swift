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

let disposeBag = DisposeBag()

extension WXApiWrap {
    
    func test() -> Void {
        test10()
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
        
        WXApiWrap.shared.shareResult.subscribe(onNext: { (_ errCode) in
            print("result = \(errCode)")
            if errCode == WXErrCodeWrap.success {
                QBToaster.showText("分享成功", pos: .center)
            } else {
                QBToaster.showText("分享失败", pos: .center)
            }
        }).disposed(by: disposeBag)
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
//        do{
//            let data:NSData = try NSData(contentsOf: URL(fileURLWithPath: fileUrl!), options: .alwaysMapped)
//            content.imageData = data as Data
//        } catch {}
        
        let data:NSData? = try? NSData(contentsOf: URL(fileURLWithPath: fileUrl!), options: .alwaysMapped)
        content.imageData = data! as Data
        
        WXApiWrap.shared.shareContent(content, channel: .wechatSession)
    }
}
