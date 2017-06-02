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
        super.loadView()
        log.verbose("loadView")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        log.verbose("viewDidLoad")
        loadDeliveries()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Load data from API
    func loadDeliveries(){
        APIHelper.getDeliveries(offset: offset,completionHandler:
            { (success, response) in
                if(success){
                    log.verbose("success")
                }else{
                    log.verbose("fail")
                }
                log.verbose("response:"+response)
            }
        )
    }
}
