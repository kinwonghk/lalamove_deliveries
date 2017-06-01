//
//  DeliveryListViewController.swift
//  LalamoveDeliveries
//
//  Created by KinWong on 1/6/2017.
//  Copyright © 2017 Kin. All rights reserved.
//

import Foundation
import UIKit

class DeliveryListViewController: UIViewController {
    var offset = 1
    
    override func loadView() {
        log.verbose("loadView")
        super.loadView()
    }
    
    override func viewDidLoad() {
        log.verbose("viewDidLoad")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        loadDeliveries()
        test()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Load data from API
    func loadDeliveries(){
        APIHelper.getDeliveries(offset: offset,
                                completionHandler: { success in
                                    if(success){
                                        log.verbose("success")
                                    }else{
                                        log.verbose("fail")
                                    }
                                })
    }
    
    func test(){
        APIHelper.login(loginname: "test", password: "test", completionHandler: {success in
            if(success){
                log.info("success")
            }else{
                log.info("fail")
            }
        });
    }
}
