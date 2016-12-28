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
import Moya_ObjectMapper


class ViewController: UIViewController {

    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        test()
//        rxAlam()
    }
    
    func test()  {
        
//        let provider = MoyaProvider<BanTService>()
//        provider.request(.newInfo) { (res) in
//            switch res{
//            case let .success(value):
//                print(value)
//            case let .failure(error):
//                print(error)
//            }
//        }
        
        let rxp = RxMoyaProvider<BanTService>()
        rxp.request(.newInfo).subscribe { (response) in
            guard let resp = response.element else{return}
            do{
//                let s = try resp.mapString()
                let s = try resp.mapObject(BanTJSON.self)
                print(s.data?.user?.nickname ?? "😝")
                print(s)
            }catch{
                print(error)
            }
        }.addDisposableTo(bag)
        
    }
    
    func rxAlam()  {
        
        let url = URL(string: "http://open3.bantangapp.com/topic/newInfo?app_id=com.jzyd.Better&app_installtime=1476251286&app_versions=1.5.1&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&device_token=711214f0edd8fe4444aa69d56119e0bbf83bc1675292e4b9e81b0a83a7cdff0a&id=6222&is_night=0&oauth_token=1cfdf7dc28066c076c23269874460b58&os_versions=10.0.2&screensize=750&statistics_uv=0&track_device_info=iPhone7%2C2&track_deviceid=18B31DD0-2B1E-49A9-A78A-763C77FD65BD&track_user_id=2670024&type_id=1&v=14")!
        
//        URLSession.shared.rx.json(url: url)
//            .observeOn(MainScheduler.instance)
//            .subscribe { (e) in
//            print(e.element ?? "")
//            }.addDisposableTo(bag)
        
//        request(.get, url).flatMap { req in
//           return req
//            .validate(statusCode: 200..<300)
//            .validate(contentType: ["text/json"])
//            .rx.string()
//        }.observeOn(MainScheduler.instance)
//        .subscribe { (e) in
//            print(e)
//        }.addDisposableTo(bag)
        
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
    
    
    func huochaihe() {
        
        // MARK: 今天的日子好像 好特别 (BREAK UP,DONT FORGIVE)
        let param = [
            "lastid": "0",
            "source": "APP",
            "uid": "1248932",
            "register_id": "",
            "platform": "IOS",
            "udid": "e0164119fcedd620533b1a6a163454b13b4be0e9",
            "user_id": "1248932",
            "version": "4.9.0",
            "token_key": "MTI0ODkzMizmiafov7dfLCw2ZGFmMzs5YWMwNmU0OWM0OWY5MTgzNjc0MGVlZTA5Njk5ZDBhYg=="
        ]
        
        
        //
        
        Alamofire.request( "https://soa.ihuochaihe.com:442/v1/thread/momentsad", method: .post, parameters: param).responseString { (rsp) in
            print("-----")
            print(rsp)
            print("-----\n")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}

