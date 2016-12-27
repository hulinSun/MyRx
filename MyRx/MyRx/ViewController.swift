//
//  ViewController.swift
//  MyRx
//
//  Created by Hony on 2016/12/23.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        
        Alamofire.request( "https://soa.ihuochaihe.com:442/v1/thread/momentsad", method: .post, parameters: param).responseString { (rsp) in
            print(rsp)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    

}

