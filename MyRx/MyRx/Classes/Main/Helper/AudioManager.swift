//
//  AudioManager.swift
//  MyRx
//
//  Created by Hony on 2017/1/9.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit
import AVFoundation
import RxSwift
import RxCocoa

/// 同步函数用异常机制处理错误
/// 异步函数用<泛型> 枚举 处理错误

/**
enum RecorderError {
    
    case initFailed // 初始化失败
    case authorizationDenied // 用户为授权
    case createAudioFileFailed // 创建录音文件失败
    case recordingFailed  // 录音失败
}

enum RecordResult{
    case success
    case failure(RecorderError)
}
extension RecorderError{
    var description: String{
        switch self {
        case .initFailed:
            return "初始化失败"
        case .authorizationDenied:
            return "用户未授权"
        case .createAudioFileFailed:
            return "创建录音文件失败"
        case .recordingFailed:
            return "录音过程中录音失败"
        }
    }
}*/

@objc protocol AudioManagerDelegate: NSObjectProtocol {
}

class AudioManager: NSObject {
    
    // 单例
    static let sharedManager = AudioManager()
    override private init(){
        super.init()
        self.initRecord()
    }
    
    /// 音频会话
    let session = AVAudioSession.sharedInstance()
    // 录音文件路径
    private let audilFile = "recodr.wav".cacheFileData()
    
    // 参数配置
    let setting: [String: NSNumber] = [
            AVSampleRateKey : NSNumber(value: 11025.0),
            AVFormatIDKey: NSNumber(value: kAudioFormatLinearPCM),
            AVLinearPCMBitDepthKey: NSNumber(value: 16),
            AVNumberOfChannelsKey: NSNumber(value: 2),
            AVEncoderAudioQualityKey: NSNumber(value: AVAudioQuality.max.rawValue)
        ]
    
    var delegate: AudioManagerDelegate?
    
    let tt: Variable<String> = Variable("")
    
    var isRecording: Bool {
        if recorder == nil{ return false}
        return self.recorder.isRecording
    }
    
    /// 定时器
    fileprivate lazy var timer: Timer = {
        let i = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(audioPowerChange), userInfo: nil, repeats: true)
        RunLoop.current.add(i, forMode: .commonModes)
        return i
    }()
    
    /// 录音时长
    private(set) var duration: Double = 0
    
    var durationDriver: Driver<Double>!
    
    var recorder: AVAudioRecorder!
    
    var player: AVAudioPlayer!
    
    private func requestRecordPermission(callback: @escaping (Bool) -> Void){
        // 授权状态
        // TODO:  返回的不应该是枚举吗？为什么返回的却是一个结构体。结构体还有一个rawValue,真瓜皮
        session.requestRecordPermission { (granted) in
            granted ? callback(true): callback(false)
        }
    }
    
    func initRecord() {
        requestRecordPermission { [unowned self] (granted) in
            if granted{
                let url: URL = URL(fileURLWithPath: self.audilFile)
                do{
                    // 会话设置
                    try self.session.setActive(true)
                    try self.session.setCategory(AVAudioSessionCategoryPlayAndRecord)
                    self.recorder = try AVAudioRecorder(url: url, settings: self.setting)
                    self.recorder.delegate = self
                    self.recorder.isMeteringEnabled = true
                    self.recorder.prepareToRecord()
                }catch{
                    print("error\(error)")
                }
            }
        }
    }
    
    /// 录音
    func record()  {
        if !recorder.isRecording{
            recorder.record()
            timer.fireDate = NSDate.distantPast
        }
    }
    
    /// 暂停录音
    func pause()  {
        print("pause \(duration)")
        if recorder.isRecording{
            recorder.pause()
            timer.fireDate = NSDate.distantFuture
        }
    }
    
    /// 停止录音
    func stopRecord() {
        duration = 0.0
        print("stopRecord \(duration)")
        recorder.stop()
        timer.fireDate = NSDate.distantFuture
        do{
            _ = try session.setCategory(AVAudioSessionCategoryPlayback)
            try session.setActive(true)
        }catch{
            print(error)
        }
    }
    
    
    @objc func audioPowerChange() {
        duration += 0.1
        recorder.updateMeters()
        //取得第一个通道的音频，注意音频强度范围时-160到0
        let power = recorder.averagePower(forChannel: 0)
        _ = (1.0/160.0) * (power + 160.0);
        tt.value = "\(duration)"
    }
    
    /************* 播放 *****************/
    
    func initPlayer()  {
        do{
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: self.audilFile))
            player.delegate = self
            player.numberOfLoops = 3
            player.prepareToPlay()
        }catch{
            print(error)
        }
    }
    
    func play()  {
        if !player.isPlaying{
            player.play()
        }
    }
    
    func pausePlay()  {
        if player.isPlaying {
            player.pause()
        }
    }
    
    func stopPlay() {
        player.stop()
    }
    
}

extension AudioManager: AVAudioRecorderDelegate, AVAudioPlayerDelegate{
    
    /// 结束录制的时候
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
    }
    
    /// 播放完毕的时候
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag{
            stopPlay()
        }
    }
}
