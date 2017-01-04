//
//  TopicList.swift
//  MyRx
//
//  Created by Hony on 2016/12/30.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import HandyJSON


class TopicBanner: HandyJSON {
    
    var type: String?
    var content_id: String?
    var topic_type: String?
    var title: String?
    var thumb:  String?
    var url:  String?
    
    required init() {}
}

class TopicGroup: HandyJSON {
    var type: String?
    var name: String?
    var mode: String?
    var topic_list: [TopicInfo]?
    required init() {}
}

class TopicList: HandyJSON {
    var banner: [TopicBanner]?
    var topic_group_list: [TopicGroup]?
    required init() {}
}





