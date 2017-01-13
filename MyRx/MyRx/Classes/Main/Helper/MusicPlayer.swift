
//
//  MusicPlayer.swift
//  MyRx
//
//  Created by Hony on 2017/1/12.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit
import AVFoundation

/// 这里不把他设计成单例的原因是，这个工具类牵扯
class MusicPlayer: NSObject {

    var musics: [Music] // 所有的歌曲
    var index: Int // 当前播放的歌曲索引
    
    var  player: AVPlayer!
    var currentPlayItem: AVPlayerItem!
    
    /// 初始化方法
    init(musics: [Music],index: Int) {
        
        self.musics = musics
        self.index = index
        super.init()
        self.setupPlayer()
    }
    
    private func setupPlayer(){
        // 创建播放器
        // 当前的歌曲
        let initMusic = musics[index]
        guard  let u = initMusic.infos?.mp3 else { return }
        print(u)
        let s = u.addingPercentEncoding(withAllowedCharacters:  CharacterSet.urlQueryAllowed)
        if let url = URL.init(string: s!){
//            let item = AVPlayerItem(url: url)
//            currentPlayItem = item
            player = AVPlayer(url: url)
            player.play()
        }
    }
    
    /// 下一首
    func next()  {
        
    }
    
    /// 上一首
    func previout() {
        
    }
    
    /// 暂停
    func pause()  {
        
    }
    
    /// 继续播放
    func resumu(){
        
    }
}
