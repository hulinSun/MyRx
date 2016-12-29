//
//  MatchService.swift
//  MyRx
//
//  Created by Hony on 2016/12/29.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import Moya

/**
 虽然是HTTPS.这里火柴盒的接口信息可以抓取到,参数也可以拿到，但是无奈无奈走了头校验，调不了接口.只能做本地json 读取了。但是这里 假装 调接口 。熟悉一下 moya = =
 
 参数是这样的
 {
	"lastid": "0",
	"source": "APP",
	"uid": "1248932",
	"register_id": "",
	"platform": "IOS",
	"udid": "e0164119fcedd620533b1a6a163454b13b4be0e9",
	"user_id": "1248932",
	"version": "4.9.0",
	"token_key": "MTI0ODkzMizmiafov7dfLCw2ZGFmMzs5YWMwNmU0OWM0OWY5MTgzNjc0MGVlZTA5Njk5ZDBhYg=="
 }
 https://soa.ihuochaihe.com:442/v1/thread/momentsad // 主页 好友界面接口
 https://soa.ihuochaihe.com:442/v1/thread/likemomentsad 主页 欢喜界面接口
 
 
 你会发现未授权 = =
*/


/// 主页火柴service

enum MatchService {
    
    case momentsad //好友界面
    case likemomentsad //欢喜界面
}



extension MatchService: TargetType {
    var baseURL: URL { return URL(string:"https://soa.ihuochaihe.com:442")! }
    var path: String {
        switch self {
        case .momentsad:
            return "/v1/thread/momentsad"
            
        case .likemomentsad:
            return "/v1/thread/likemomentsad"
        }
    }
    var method: Moya.Method {
        switch self {
        case .momentsad, .likemomentsad:
            return .post
        }
    }
    var parameters: [String: Any]? {
        return nil
    }
    
    /// 模拟假数据用
    var sampleData: Data {
        
        let s = Bundle.main.path(forResource: "momentsad", ofType: nil)
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: s!))else{
            return "".utf8Encoded
        }
        return data
    }
    
    var task: Task {
        return .request
    }
}

// MARK: - Helpers
private extension String {
    
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
}



