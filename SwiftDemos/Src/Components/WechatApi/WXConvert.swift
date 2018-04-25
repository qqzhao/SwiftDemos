//
//  WXConvert.swift
//  SwiftDemos
//
//  Created by qianzhao on 2018/4/25.
//  Copyright © 2018年 qianzhao. All rights reserved.
//

enum WXErrCodeWrap {
    case success,errCommon,errUserCancel,errSendFail,errAuthDeny,errUnsupport
}
func convertWXErrorCode(_ errCode:Int32) -> WXErrCodeWrap{
    var ret: WXErrCodeWrap = .errCommon
    switch errCode {
    case WXSuccess.rawValue:
        ret = .success
    case WXErrCodeCommon.rawValue:
        ret = .errCommon
    case WXErrCodeUserCancel.rawValue:
        ret = .errUserCancel
    case WXErrCodeSentFail.rawValue:
        ret = .errSendFail
    case WXErrCodeAuthDeny.rawValue:
        ret = .errAuthDeny
    case WXErrCodeUnsupport.rawValue:
        ret = .errUnsupport
    default:
        ret = .success
    }
    return ret
}

//WXSceneSession  = 0,        /**< 聊天界面    */
//WXSceneTimeline = 1,        /**< 朋友圈      */
//WXSceneFavorite = 2,        /**< 收藏       */
func convertChannelToWXScene(_ channel: ShareChannel) -> UInt32 {
    var scene: UInt32 = 0
    switch channel {
    case .wechatMiniProgram:
        scene = WXSceneSession.rawValue
    case .wechatTimeline:
        scene = WXSceneTimeline.rawValue
    case .wechatSession:
        scene = WXSceneSession.rawValue
    case .wechatFavor:
        scene = WXSceneFavorite.rawValue
    default:
        scene = WXSceneSession.rawValue
    }
    return scene
}
