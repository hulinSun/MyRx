//
//  AudioManager.swift
//  MyRx
//
//  Created by Hony on 2017/1/9.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit
import AVFoundation



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

class AudioManager {
    
    // 单例
    static let sharedManager = AudioManager()
    private init(){}
    
    /// 音频会话
    let session = AVAudioSession.sharedInstance()
    // 录音文件路径
    private let file = "recodr.wav".cacheFileData()
//    private let url: URL = URL(fileURLWithPath: file)
    
    // 参数配置
    let setting: [String: NSNumber] = [
            AVSampleRateKey : NSNumber(value: 11025.0),
            AVFormatIDKey: NSNumber(value: kAudioFormatLinearPCM),
            AVLinearPCMBitDepthKey: NSNumber(value: 16),
            AVNumberOfChannelsKey: NSNumber(value: 2),
            AVEncoderAudioQualityKey: NSNumber(value: AVAudioQuality.max.rawValue)
        ]
    
    var delegate: AudioManagerDelegate?
    
    var isRecording: Bool {
        if recorder == nil{ return false}
        return self.recorder.isRecording
    }
    
    /// 定时器
    fileprivate lazy var timer: Timer = {
        let i = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateMetre), userInfo: nil, repeats: true)
        RunLoop.current.add(i, forMode: .commonModes)
        return i
    }()
    
    var recorder: AVAudioRecorder!
    
    private func requestRecordPermission(callback: @escaping (Bool) -> Void){
        
        // 授权状态
        // TODO:  返回的不应该是枚举吗？为什么返回的却是一个结构体。结构体还有一个rawValue,真瓜皮
        session.requestRecordPermission { (granted) in
            granted ? callback(true): callback(false)
        }
    }
    
    func beginRecord() {
        requestRecordPermission { (granted) in
            print("gram = \(granted)")
        }
    }
    
    @objc func updateMetre() {
        print("---")
    }
}

