//
//  BanTModel.swift
//  MyRx
//
//  Created by Hony on 2016/12/28.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import ObjectMapper
import HandyJSON

class BanTJSON: Mappable,HandyJSON {
    var status: Int?
    var msg: String?
    var ts: Int?
    var  data: BanTModel?
    
    required init?(map: Map) {}
    
     required init() {}
    // Mappable
    func mapping(map: Map) {
        status    <- map["status"]
        msg         <- map["msg"]
        ts      <- map["data"]
        data       <- map["data"]

    }
    
}
class BanTUser : Mappable , HandyJSON{
    var user_id: String?
    var nickname: String?
    var avatar: String?
    var is_official: Int?
    var article_topic_count: String?
    var post_count: String?
    
    required init() {}
    required init?(map: Map) {}
    
    // Mappable
    func mapping(map: Map) {
        user_id    <- map["user_id"]
        nickname         <- map["nickname"]
        avatar      <- map["avatar"]
        is_official       <- map["is_official"]
        article_topic_count  <- map["article_topic_count"]
        post_count  <- map["post_count"]
    }
}

class BanTModel: Mappable ,HandyJSON{
    
    var  id: String?
    var title:String?
    var desc:String?
    var type: String?
    var share_url: String?
    var category: String?
    var share_pic: String?
    var pic: String?
    var islike: Bool?
    var likes: String?
    var is_show_like: Bool?
    var iscomment: Bool?
    var comments: String?
    var article_content:String?
    var user: BanTUser?
    
    required init() {}
    required init?(map: Map) {}
    
    // Mappable
    func mapping(map: Map) {
        id    <- map["id"]
        title         <- map["title"]
        desc      <- map["desc"]
        type       <- map["type"]
        share_url  <- map["share_url"]
        category  <- map["category"]
        share_pic  <- map["share_pic"]
        pic  <- map["pic"]
        islike  <- map["islike"]
        likes  <- map["likes"]
        is_show_like  <- map["is_show_like"]
        iscomment  <- map["iscomment"]
        comments  <- map["comments"]
        article_content  <- map["article_content"]
        user  <- map["user"]
    }
    

}
