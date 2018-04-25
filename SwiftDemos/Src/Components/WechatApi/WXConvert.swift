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

//WXSceneSession  = 0,        /**< 聊天界面    */
//WXSceneTimeline = 1,        /**< 朋友圈      */
//WXSceneFavorite = 2,        /**< 收藏       */
func convertChannelToWXScene(_ channel: ShareChannel) -> Int32 {
    var scene: Int32 = 0
    switch channel {
    case .wechatMiniProgram:
        scene = 0
    case .wechatTimeline:
        scene = 1
    case .wechatSession:
        scene = 0
    case .wechatFavor:
        scene = 2
    default:
        scene = 0
    }
    return scene
}
