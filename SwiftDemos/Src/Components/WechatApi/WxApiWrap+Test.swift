//
//  WxApiWrap+Test.swift
//  SwiftDemos
//
//  Created by qianzhao on 2018/4/25.
//  Copyright © 2018年 qianzhao. All rights reserved.
//

import UIKit

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
//        conent.imageSrc = "http://stdl.qq.com/stdl/translator/wxappedu/wap/student/3-2-1.jpg"
        let image: UIImage = #imageLiteral(resourceName: "icon_new")
        content.imageData = UIImagePNGRepresentation(image)
        content.contentType = .imageOnly
        WXApiWrap.shared.shareContent(content, channel: .wechatSession)
    }
    
    fileprivate func test3() -> Void {
        let content:ShareContent = ShareContent("this is title", url: "http://baidu.com", summary: "summary")
        content.contentType = .urlOnly
        WXApiWrap.shared.shareContent(content, channel: .wechatSession)
    }
    
    fileprivate func test4() -> Void {
        let content:ShareContent = ShareContent("this is title", url: "http://baidu.com", summary: "summary")
        content.contentType = .titleImage
        WXApiWrap.shared.shareContent(content, channel: .wechatSession)
    }
    
    fileprivate func test5() -> Void {
        let content:ShareContent = ShareContent("this is title", url: "http://baidu.com", summary: "summary")
        content.contentType = .summaryImage
        WXApiWrap.shared.shareContent(content, channel: .wechatSession)
    }
    
    fileprivate func test6() -> Void {
        let content:ShareContent = ShareContent("this is title", url: "http://baidu.com", summary: "summary")
        content.contentType = .titleSummaryImage
        WXApiWrap.shared.shareContent(content, channel: .wechatSession)
    }
    
    fileprivate func test7() -> Void {
        let content:ShareContent = ShareContent("this is title", url: "http://baidu.com", summary: "summary")
        content.contentType = .titleUrl
        WXApiWrap.shared.shareContent(content, channel: .wechatSession)
    }
    
    fileprivate func test8() -> Void {
        let content:ShareContent = ShareContent("this is title", url: "http://baidu.com", summary: "summary")
        content.contentType = .SummaryUrl
        WXApiWrap.shared.shareContent(content, channel: .wechatSession)
    }
    
    fileprivate func test9() -> Void {
        let content:ShareContent = ShareContent("this is title", url: "http://baidu.com", summary: "summary")
        content.contentType = .titleSummaryUrl
        WXApiWrap.shared.shareContent(content, channel: .wechatSession)
    }
    
    fileprivate func test10() -> Void {
        let content:ShareContent = ShareContent("this is title", url: "http://baidu.com", summary: "summary")
        content.contentType = .titleSummaryImageUrl
        content.thumbData = UIImagePNGRepresentation(#imageLiteral(resourceName: "icon_camera"))
        WXApiWrap.shared.shareContent(content, channel: .wechatSession)
    }
}
