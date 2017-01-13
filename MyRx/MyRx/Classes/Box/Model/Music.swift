//
//  Music.swift
//  MyRx
//
//  Created by Hony on 2017/1/12.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit
import HandyJSON


class MusicInfo: HandyJSON {
    var id:	String?
    var title: String?
    var date: String?
    var author: String?
    var thumb: String?
    var width: String?
    var height: String?
    var mp3:String?
    var heart: String?
    var forward: String?
    var is_zan: Bool = false
    var is_fav: Bool = false
    required init() {}
}

class Music: HandyJSON {
    var type: String?
    var typename:String?
    var infos: MusicInfo?
    required init() {}
    
//    static func ==(lhs: Music, rhs: Music) -> Bool {
//        return lhs.infos?.mp3 == rhs.infos?.mp3
//    }
}


