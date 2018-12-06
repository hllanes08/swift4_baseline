//
//  CalendarsListCell.swift
//  ios_baseline
//
//  Created by Harvin Llanes on 14/7/17.
//  Copyright © 2017 Harvin Llanes. All rights reserved.
//
import LBTAComponents
import SnapKit
import UIKit
import SwiftIconFont

class CalendarListCell: DatasourceCell {
    override var datasourceItem: Any? {
        didSet {
            guard let calendars = datasourceItem as? Calendar else {
                return
            }
            let dateformater = DateFormatter()
            dateformater.dateFormat = "yyyy-MM-dd"

            nameInfo.text = calendars.name
            labelDate.text = dateformater.string(from:calendars.start_date)
            ndayLabel.text = "Cada \(calendars.n_days) dias"
            calendarLabel.textColor = UIColors.greenStrong()
            //countryLabel.text = "\(branchOffice.countryName), \(branchOffice.city)"
            //courseImage.sd_setImage(with: URL(string: branchOffice.coverImageURL), placeholderImage: #imageLiteral(resourceName: "branch-image"))
            //flagImage.image = UIImage(named: branchOffice.countryFlag)
        }
    }
    
    let calendarIconView:UIView = {
        let uv = UIView()
        uv.backgroundColor = .clear
        uv.layer.masksToBounds = true
        return uv
    }()
    
    let nameView:UIView = {
        let uv = UIView()
        uv.backgroundColor = .clear
        uv.layer.masksToBounds = true
        return uv
    }()
    
    let rangeView:UIView = {
        let uv = UIView()
        uv.backgroundColor = .clear
        uv.layer.masksToBounds = true
        return uv
    }()
    let calendarLabel:UILabel = {
        let label = UILabel()
        label.font =  UIFont.icon(from: .iconic, ofSize: 30.0)
        label.textColor = UIColors.dbColor()
        label.text = String.fontIonIcon("ios-calendar-outline")
        return label
    }()
    
    let labelDate:UILabel = {
        let label = UILabel()
        label.font =  UIFont.icon(from: .iconic, ofSize: 11.0)
        label.textColor = UIColors.dbColor()
        label.text = "000-00-00"
        return label
    }()
    
    let infoView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .clear
        uv.layer.masksToBounds = true
        return uv
    }()
    
    let nameInfo: UILabel = {
        let label = UILabel()
        label.font =  UIFont.icon(from: .iconic, ofSize: 17.0)
        label.textColor = UIColors.dbColor()
        label.text = "  "
        return label

    }()
    let ndayLabel:  UILabel = {
        let label = UILabel()
        label.font =  UIFont.icon(from: .iconic, ofSize: 15.0)
        label.textColor = UIColors.lineColor()
        label.text = "  "
        return label
    }()
    
    
    let detailedView: UILabel = {
        let label = UILabel()
        label.font =  UIFont.icon(from: .iconic, ofSize: 17.0)
        label.textColor = UIColors.dbColor()
        label.text = String.fontIonIcon("ios-arrow-right")
        return label

    }()
    let lineView: UIView = {
       let uv = UIView()
       uv.layer.borderWidth = CGFloat(0.23)
       uv.layer.borderColor = UIColors.lineColor().cgColor
       return uv
    }()
    
   
    override func setupViews() {
        super.setupViews()
        addSubview(calendarIconView)
        
        calendarIconView.snp.makeConstraints{ (make) in
            make.left.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        calendarIconView.addSubview(calendarLabel)
        
        calendarLabel.snp.makeConstraints{ (make) in
           make.centerX.centerY.equalToSuperview()
           make.height.width.equalToSuperview().dividedBy(2)
        }
        
        calendarIconView.addSubview(labelDate)
        labelDate.snp.makeConstraints{ (make) in
            make.top.equalTo(calendarLabel).offset(40)
            make.height.equalToSuperview().dividedBy(2)
            make.width.equalToSuperview().dividedBy(1.2)
            make.centerX.equalToSuperview()
        }
        
        addSubview(infoView)
        
        infoView.snp.makeConstraints{ (make) in
            make.top.bottom.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
            make.right.equalToSuperview()
        }
        
        infoView.addSubview(nameInfo)
        
        nameInfo.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalTo(20)
        }
        infoView.addSubview(ndayLabel)
        
        ndayLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(nameInfo).offset(20)
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(20)
        }
        infoView.addSubview(detailedView)
        
        detailedView.snp.makeConstraints{ (make) in
            make.height.equalTo(40)
            make.top.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(20)
            make.width.equalToSuperview().dividedBy(3)
        }
        
        infoView.addSubview(lineView)
        lineView.snp.makeConstraints{ (make)  in
            make.height.equalTo(1)
            make.width.equalToSuperview()
            make.right.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
    
}
