//
//  MatchModel.swift
//  MyRx
//
//  Created by Hony on 2016/12/29.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import HandyJSON

class TopicInfo: HandyJSON {
    
    var voice_sample_rate: Double?
    var id: String?
    var topic_id: String?
    var topic_name:String?
    var topic_type: String?
    var view: String?
    var author_id: String?
    var link_url: String?
    var voice_url_mp3: String?
    var voice_url_aac: String?
    var voice_thumb: String?
    var voice_thumb_org: String?
    var voice_view: String?
    var voice_long_time: String?
    var voice_wave_data: String?
    var author: String?
    var avatar: String?
    var role: String?
    var thumb: String?
    var thumb_org: String?
    var width: String?
    var height: String?
    var content:String?
    var heart: String?
    var forward: String?
    var repost: String?
    var comment: String?
    var created: String?
    var pubtime2: String?
    var is_private: String?
    var vip_type: String?
    var relation: String?
    var isself: String?
    var is_fav: String?
    var is_like: String?
    var is_follow: Bool?
    
    
    required init() {}
}


class Topic: HandyJSON {
    
    var type: String?
    var lastid: String?
    var info: TopicInfo?
    
    required init() {}
}
