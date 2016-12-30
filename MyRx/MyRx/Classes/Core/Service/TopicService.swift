//
//  TopicService.swift
//  MyRx
//
//  Created by Hony on 2016/12/30.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import Moya



/// 话题service

// https://soa.ihuochaihe.com:442/v1/topic/index

enum TopicService: String {
    case index
}

extension TopicService: TargetType {
    
    var baseURL: URL { return URL(string:"https://soa.ihuochaihe.com:442")! }
    
    var path: String {
        switch self {
        case .index:
            return "/v1/topic/index"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .index:
            return .post
        }
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    /// 模拟假数据用
    var sampleData: Data {
        return JSONTool.dataWith(name: self.rawValue)
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
