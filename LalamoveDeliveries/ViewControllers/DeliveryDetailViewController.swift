//
//  DeliveryDetailViewController.swift
//  LalamoveDeliveries
//
//  Created by KinWong on 1/6/2017.
//  Copyright © 2017 Kin. All rights reserved.
//

import Foundation
import UIKit
import PureLayout
import GoogleMaps

class DeliveryDetailViewController: UIViewController {
    let delivery:Delivery?
    var mapView:GMSMapView?
    var didSetupConstraints = false;
    
    let descTitleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "Description:"
        label.textColor = UIColor.gray
        return label
    }();
    
    let descLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }();
    
    let addressTitleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "Address:"
        label.textColor = UIColor.gray
        return label
    }();
    
    let addressLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }();
    
    init(_ delivery:Delivery){
        self.delivery = delivery
        self.mapView = nil
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.delivery = nil
        self.mapView = nil
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        super.loadView()
        
        self.title = "Deliver Details"
        
        self.view = UIView();
        self.view.backgroundColor = UIColor(white: 1, alpha: 1);
        
        guard self.delivery != nil else { return }
        let camera = GMSCameraPosition.camera(withLatitude: self.delivery!.latitude, longitude: self.delivery!.longitude, zoom: 17.0)
        self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        let position = CLLocationCoordinate2D(latitude: self.delivery!.latitude, longitude: self.delivery!.longitude)
        let marker = GMSMarker(position: position)
        marker.map = mapView
        
        self.view.addSubview(self.mapView!)
        self.view.addSubview(self.descTitleLabel)
        self.view.addSubview(self.descLabel)
        self.descLabel.text = self.delivery!.description
        self.view.addSubview(self.addressTitleLabel)
        self.view.addSubview(self.addressLabel)
        self.addressLabel.text = self.delivery!.address
        
        self.updateViewConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func updateViewConstraints() {
        if(!didSetupConstraints){
            
            // set mapView
            self.mapView!.autoPinEdge(toSuperviewEdge: .left)
            self.mapView!.autoPinEdge(toSuperviewEdge: .top)
            self.mapView!.autoPinEdge(toSuperviewEdge: .right)
            self.mapView!.autoSetDimension(.height, toSize: 400)
            
            // set descTitleLabel
            self.descTitleLabel.autoPinEdge(.top, to: .bottom, of: self.mapView!, withOffset: 10.0)
            self.descTitleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10.0)
            self.descTitleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 10.0)
            
            // set descLabel
            self.descLabel.autoPinEdge(.top, to: .bottom, of: self.descTitleLabel)
            self.descLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10.0)
            self.descLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 10.0)
            
            // set addressTitleLabel
            self.addressTitleLabel.autoPinEdge(.top, to: .bottom, of: self.descLabel, withOffset: 20.0)
            self.addressTitleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10.0)
            self.addressTitleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 10.0)
            
            // set addressLabel
            self.addressLabel.autoPinEdge(.top, to: .bottom, of: self.addressTitleLabel)
            self.addressLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10.0)
            self.addressLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 10.0)
            
            
            didSetupConstraints = true;
        }
        super.updateViewConstraints();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
