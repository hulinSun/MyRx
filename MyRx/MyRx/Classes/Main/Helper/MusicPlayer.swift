
//
//  MusicPlayer.swift
//  MyRx
//
//  Created by Hony on 2017/1/12.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit
import AVFoundation
import RxSwift
import RxCocoa

/// 这里不把他设计成单例的原因是，这个工具类牵扯
class MusicPlayer: NSObject {

    let bag = DisposeBag()
    var musics: [Music] // 所有的歌曲
    var index: Int = 0 // 当前播放的歌曲索引
    var  player: AVPlayer!
    var currentPlayItem: AVPlayerItem!
    var first: Bool = true /// 标记第一次添加的通知。第一次没播放的不添加通知
    
    /// 初始化方法
    init(musics: [Music]) {
        self.musics = musics
        super.init()
        setupPlayer()
    }
    
    /// 默认播放的是第一首歌
    private func setupPlayer(){
        // MARK: 这里默认去第一个的目的是先让aplayer 有值
        index = 0
        let initMusic = musics[index]
        guard  let mp3 = initMusic.infos?.mp3 else { return }
        if let item = mp3.playItem(){
            player = AVPlayer(playerItem: item)
        }
    }
    
    /// 播放第几个歌曲 ---> 这里才是真正的播放.所以在这里做KVO操作
    func play(at idx: Int){
        let initMusic = musics[idx]
        index = idx
        guard let mp3 = initMusic.infos?.mp3 else { return }
        if let item = mp3.playItem(){
            
            removeObser() // 移除之前的通知
            // 移除之前item的监听 ,并且不是第一次的哪个没播放的通知
            if let lastItem = player.currentItem {
                if !first{ // 不是第一次
                    removeObserToitem(playItem: lastItem) // 移除之前的kvo
                }
            }
            player.replaceCurrentItem(with: item)
            player.play()
            first = false // 第一次没有了 = =
            playEndObserve() // 播放结束的通知
            progressObser() // 进度
            addobserToItem(playItem: item) // kvo
        }
    }
    
    /// 播放制定歌曲
    func play(music: Music) {
        // 获取index
        let idx = musics.index { (m) -> Bool in
            return m.infos?.mp3 == music.infos?.mp3
        }
        if let d = idx{
            play(at: d)
        }
    }
    
    /// kvo监听item改变
    private func addobserToItem(playItem: AVPlayerItem){
        
        // 播放状态
        playItem.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options: NSKeyValueObservingOptions.new, context: nil)
        
        /// 缓冲
        playItem.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.loadedTimeRanges), options: NSKeyValueObservingOptions.new, context: nil)
        
        // 缓冲区空了，需要等待数据
        playItem.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.isPlaybackBufferEmpty), options: NSKeyValueObservingOptions.new, context: nil)
        // 缓冲区有足够数据可以播放了
        playItem.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.isPlaybackLikelyToKeepUp), options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    private func removeObserToitem(playItem: AVPlayerItem){
        playItem.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.status))
        playItem.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.loadedTimeRanges))
        playItem.removeObserver(self, forKeyPath:  #keyPath(AVPlayerItem.isPlaybackBufferEmpty))
        playItem.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.isPlaybackLikelyToKeepUp))
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        let item = player.currentItem!
        guard  let key = keyPath , let changeValue = change else { return }
        let new = changeValue[.newKey]
        switch key {
        case "status":
            if let status = new as? AVPlayerStatus, status == AVPlayerStatus.readyToPlay{
                print("正在播放\(CMTimeGetSeconds(item.duration))")
            }
            
        case "loadedTimeRanges":
            // 计算缓冲进度
            if let timeInterVarl    = self.availableDuration() {
                print("缓冲\(timeInterVarl)")
            }
            
        case "playbackBufferEmpty":
            print("playbackBufferEmpty \(new!)")
        case "playbackLikelyToKeepUp":
            print("playbackLikelyToKeepUp \(new!)")
        default:
            print("--")
        }
    }
    
    /// 添加播放结束通知
    private func playEndObserve()  {
        let end = Notification.Name.AVPlayerItemDidPlayToEndTime
        NotificationCenter.default.rx.notification(end)
            .subscribe { (e) in
                print("播放到结束了")
            }.addDisposableTo(bag)
    }
    
    /// 移除通知
    private func removeObser(){
        NotificationCenter.default.removeObserver(self)
    }
    
    /// 添加播放进度通知
    private func progressObser(){
        if let playItem = player.currentItem{
            let time = CMTime(value: CMTimeValue(1.0), timescale: CMTimeScale(1.0))
            player.addPeriodicTimeObserver(forInterval: time, queue: DispatchQueue.main, using: { (t) in
                let current = CMTimeGetSeconds(t)
                let total = CMTimeGetSeconds(playItem.duration)
                print("当前\(current) 总时长\(total)")
            })
        }
    }
    
    /// 计算缓冲时长
    fileprivate func availableDuration() -> TimeInterval? {
        if let loadedTimeRanges = player.currentItem?.loadedTimeRanges,
            let first = loadedTimeRanges.first {
            let timeRange = first.timeRangeValue // 本次缓冲时长
            let startSeconds = CMTimeGetSeconds(timeRange.start)
            let durationSecound = CMTimeGetSeconds(timeRange.duration)
            let result = startSeconds + durationSecound
            return result
        }
        return nil
    }

    
    /// 下一首
    func next()  {
        if index == musics.count - 1{ // 最后一首
            // 播放第一首
            play(at: 0)
        }else{
            play(at: index + 1)
        }
    }
    /// 上一首
    func previous() {
        if index == 0{
         play(at: musics.count - 1)
        }else{
            play(at: index - 1)
        }
    }
    /// 暂停
    func pause()  {
        player.pause()
    }
    /// 继续播放
    func resumu(){
        // 继续播放
    }
    
    
    deinit {
        removeObser()
        if let item = player.currentItem{
            removeObserToitem(playItem: item)
        }
    }
    
}

private extension String{
    
    func playItem() -> AVPlayerItem? {
        if self.isEmpty { return nil }
        if let urlString = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) , let url = URL.init(string: urlString){
            return AVPlayerItem(url: url)
        }else{
            return nil
        }
    }
}
