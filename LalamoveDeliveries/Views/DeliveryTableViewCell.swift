//
//  DeliveryTableViewCell.swift
//  LalamoveDeliveries
//
//  Created by KinWong on 3/6/2017.
//  Copyright © 2017 Kin. All rights reserved.
//

import Foundation
import UIKit
import PureLayout
import SDWebImage

class DeliveryTableViewCell: UITableViewCell{
    var didSetupConstraints = false
    
    let iconView:UIImageView = {
        let iconView = UIImageView()
        iconView.backgroundColor = UIColor(white: 1, alpha: 0)
        iconView.contentMode = .scaleAspectFit
        return iconView
    }()
    
    let addressTitleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "Address:"
        label.textColor = UIColor.gray
        return label
    }()
    
    let descLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let addressLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }();
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.iconView)
        self.contentView.addSubview(self.descLabel)
        self.contentView.addSubview(self.addressTitleLabel)
        self.contentView.addSubview(self.addressLabel)
        
        self.setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        if(!didSetupConstraints){
            // set iconView
            self.iconView.autoPinEdge(toSuperviewEdge: .left)
            self.iconView.autoPinEdge(toSuperviewEdge: .top, withInset: 10.0)
            self.iconView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10.0)
            self.iconView.autoSetDimensions(to: CGSize(width: 80.0, height: 80.0))
            
            // set descLabel
            self.descLabel.autoPinEdge(.left, to: .right, of: self.iconView, withOffset: 2.0)
            self.descLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 10.0)
            self.descLabel.autoSetDimension(.height, toSize: 15.0)
            
            self.addressTitleLabel.autoPinEdge(.top, to: .bottom, of: self.descLabel, withOffset: 20.0)
            self.addressTitleLabel.autoPinEdge(.left, to: .right, of: self.iconView, withOffset: 2.0)
            self.addressTitleLabel.autoPinEdge(toSuperviewEdge: .right)
            self.addressTitleLabel.autoSetDimension(.height, toSize: 10.0)
            
            self.addressLabel.autoPinEdge(.top, to: .bottom, of: self.addressTitleLabel, withOffset: 2.0)
            self.addressLabel.autoPinEdge(.left, to: .right, of: self.iconView, withOffset: 2.0)
            self.addressLabel.autoPinEdge(toSuperviewEdge: .right)
//            self.addressLabel.autoPinEdge(toSuperviewEdge: .bottom)
            
            didSetupConstraints = true;
        }
        super.updateConstraints()
    }
    
    func setContent(_ delivery:Delivery){
        self.iconView.sd_setImage(with: URL(string:delivery.imageUrl), placeholderImage: UIImage(named:"PlaceHolder"))
        self.descLabel.text = delivery.description
        self.addressLabel.text = delivery.address
        self.setNeedsUpdateConstraints();
    }
}
