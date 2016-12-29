//
//  ViewController.swift
//  MyRx
//
//  Created by Hony on 2016/12/23.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import Alamofire
import Moya
import RxAlamofire
import RxSwift
import RxCocoa
import Then
import HandyJSON
import ManualLayout

class ViewController: UIViewController {

    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        then()
        moyaTest()
        
    }
    
    
    func then() {
        
        let i = UILabel().then{
            $0.font = UIFont.systemFont(ofSize: 16)
            $0.backgroundColor = .red
            $0.numberOfLines = 1
            $0.textColor = .blue
            $0.frame = CGRect(x: 100, y: 100, width: 200, height: 60)
            $0.text = "I Love Hony"
            $0.textAlignment = .center
        }
        view.addSubview(i)
        
    }
    
    /// rxAlamofire Demo
    func rxAlamofire()  {
        let url = URL(string: "http://open3.bantangapp.com/topic/newInfo?app_id=com.jzyd.Better&app_installtime=1476251286&app_versions=1.5.1&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&device_token=711214f0edd8fe4444aa69d56119e0bbf83bc1675292e4b9e81b0a83a7cdff0a&id=6222&is_night=0&oauth_token=1cfdf7dc28066c076c23269874460b58&os_versions=10.0.2&screensize=750&statistics_uv=0&track_device_info=iPhone7%2C2&track_deviceid=18B31DD0-2B1E-49A9-A78A-763C77FD65BD&track_user_id=2670024&type_id=1&v=14")!
        
        // 1
        URLSession.shared.rx.json(url: url)
            .observeOn(MainScheduler.instance)
            .subscribe { (e) in
                print(e.element ?? "")
            }.addDisposableTo(bag)
        
        // 2
        request(.get, url).flatMap { req in
            return req
                .validate(statusCode: 200..<300)
                .validate(contentType: ["text/json"])
                .rx.string()
            }.observeOn(MainScheduler.instance)
            .subscribe { (e) in
                print(e)
            }.addDisposableTo(bag)
        
        // 3
        let mgr = Manager.default
        _ = mgr.rx.request(.get, url)
            .flatMap { request -> Observable<(String?, RxProgress)> in
                let validatedRequest = request
                    .validate(statusCode: 200 ..< 300)
                
                let stringPart = validatedRequest
                    .rx.string()
                    .map { d -> String? in d }
                    .startWith(nil as String?)
                let progressPart = validatedRequest.rx.progress()
                return Observable.combineLatest(stringPart, progressPart) { ($0, $1) }
            }
            .observeOn(MainScheduler.instance)
            .subscribe { print($0) }

    }
    
    /// Moya + HandyJson & Moya + ObjectMapper
    
    // 这里我自己写了一个针对HandyJSON 对moya 的封装、因为觉得ObjectMapper 使用起来太繁琐，需要重复的写序列化的方法。 = =
    func moyaTest() {
        
        let provider = MoyaProvider<BanTService>()
        provider.request(.newInfo) { (res) in
            switch res{
            case let .success(value):
                
                // HandyJSON
                if let model = value.mapObject(BanTJSON.self){
                    print(model.data?.user?.avatar ?? "xxx")
                }
                
                if let m = value.mapObject(BanTUser.self, designatedPath: "data.user"){
                    print(m.nickname ?? "xxxx")
                }

                // ObjectMapper
//                if let model = try? value.mapObject(BanTJSON.self){
//                    print(model.data?.user?.avatar ?? "xixi")
//                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    /// RxMoya
    func rxMoya()  {
        
        let rxp = RxMoyaProvider<BanTService>()
        rxp.request(.newInfo).subscribe { (response) in
            guard let resp = response.element else { return }
            if let s =  resp.mapObject(BanTJSON.self){
                print(s.data?.user?.nickname ?? "😝")
            }
        }.addDisposableTo(bag)
    }
    
    func huochaihe() {
        // MARK: 今天的日子好像 好特别 (BREAK UP,DONT FORGIVE)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

