//
//  DeliveryListViewController.swift
//  LalamoveDeliveries
//
//  Created by KinWong on 1/6/2017.
//  Copyright © 2017 Kin. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class DeliveryListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var offset = 1
    var deliveriesArray: NSMutableArray! = NSMutableArray()
    var didSetupConstraints = false;
    
    let DELIVERY_CELL_ID = "DELIVERY_CELL";
    let deliveryTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        return tableView;
    }()
    
    override func loadView() {
        super.loadView()
        
        self.title = "Things to Deliver"
        
        self.view = UIView();
        self.view.backgroundColor = UIColor(white: 1, alpha: 1);
        
        self.view.addSubview(self.deliveryTableView);
        self.deliveryTableView.delegate = self;
        self.deliveryTableView.dataSource = self;
        self.deliveryTableView.register(DeliveryTableViewCell.self, forCellReuseIdentifier: DELIVERY_CELL_ID);
        
        self.updateViewConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDeliveries()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func updateViewConstraints() {
        if(!didSetupConstraints){
            // set tripTableView
            self.deliveryTableView.autoPinEdge(toSuperviewEdge: .left);
            self.deliveryTableView.autoPinEdge(toSuperviewEdge: .right);
            self.deliveryTableView.autoPinEdge(toSuperviewEdge: .bottom);
            self.deliveryTableView.autoPinEdge(toSuperviewEdge: .top);
            
            didSetupConstraints = true;
        }
        super.updateViewConstraints();
    }
    
    
    // MARK: - Load data from API
    func loadDeliveries(){
        APIHelper.getDeliveries(offset: offset,completionHandler:
            { (success, response) in
                if(success){
                    log.verbose("success")
                    if(!response.isEmpty){
                        do{
                            guard let deliveriesJson = try JSONSerialization.jsonObject(with: response.data(using: .utf8)!, options: []) as? [Any] else { return }
                            
                            for delivery in deliveriesJson{
                                let deliveryModel = try Delivery(json:(delivery as? [String:Any])!)
                                if(deliveryModel != nil){
                                    self.deliveriesArray.add(deliveryModel!)
                                }
                            }
                            
                            self.deliveryTableView.reloadData()
                        }catch let error{
                            log.error(error)
                        }
                    }
                }else{
                    log.verbose("fail")
                }
                log.verbose("response:"+response)
            }
        )
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveriesArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentDelivery: Delivery = deliveriesArray.object(at: indexPath.row) as! Delivery
        let deliveryTableViewCell = tableView.dequeueReusableCell(withIdentifier: DELIVERY_CELL_ID) as! DeliveryTableViewCell
        deliveryTableViewCell.setContent(currentDelivery)
        return deliveryTableViewCell;
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard self.deliveriesArray != nil else { return }
        let delivery = deliveriesArray.object(at: indexPath.row) as! Delivery
        self.navigationController?.pushViewController(DeliveryDetailViewController(delivery), animated: true)
        
        tableView.deselectRow(at: indexPath, animated: false);
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}
