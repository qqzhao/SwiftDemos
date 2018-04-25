//
//  WxApiWrap+Test.swift
//  SwiftDemos
//
//  Created by qianzhao on 2018/4/25.
//  Copyright © 2018年 qianzhao. All rights reserved.
//

import UIKit
import Foundation

extension WXApiWrap {
    
    func test() -> Void {
        test12()
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
        do{
            let data:NSData = try NSData(contentsOf: URL(fileURLWithPath: fileUrl!), options: .alwaysMapped)
            content.imageData = data as Data
        } catch {}
        
//        content.imageData = UIImagePNGRepresentation(#imageLiteral(resourceName: "icon_camera"))
        WXApiWrap.shared.shareContent(content, channel: .wechatSession)
    }
}
