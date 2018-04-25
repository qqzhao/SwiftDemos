//
//  ShareManager.swift
//  SwiftDemos
//
//  Created by qianzhao on 2018/4/25.
//  Copyright © 2018年 qianzhao. All rights reserved.
//

import UIKit

enum ShareChannel {
    case qqFriends,qqZone,
        wechatSession,wechatTimeline,wechatMiniProgram,wechatFavor,
        weibo
}

/**
 分享的主要分3类titleOnly、Image,Url
 */
enum ShareContentType {
    case titleOnly,
        imageOnly, // 后3个都不行，分享失败 (titleImage,summaryImage,titleSummaryImage)
        urlParams,
        miniProgram,
        gif
}

class ShareContent: NSObject{
    var title: String?
    var summary: String?
    var thumbData: Data?
    var url: String?
    var localImagePath: String?
    var imageData: Data?
    var contentType: ShareContentType = .titleOnly
    init(_ title: String?, url: String?, summary: String?) {
        super.init()
        self.title = title
        self.url = url
        self.summary = summary
    }
}

class ShareManager: NSObject {
    public static let shared = ShareManager()
}
