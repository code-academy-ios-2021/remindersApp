//
//  NewReminderDateCell.swift
//  remindersApp
//
//  Created by Education on 28/04/2021.
//

import UIKit

class NewReminderDateCell: BaseTableViewCell {
    private var EdgeMargin: CGFloat = 16
    
    private let dateIcon: UIImageView = {
        let imageView = UIImageView()
        let configuration = UIImage.SymbolConfiguration(pointSize: 40, weight: .medium)
        imageView.image = UIImage(systemName: "calendar", withConfiguration: configuration)?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .systemRed
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        return label
    }()
    
    private let switchView: UISwitch = {
        let switchView = UISwitch()
        
        return switchView
    }()
    
    override func setupView() {
        contentView.addSubview(dateIcon)
        contentView.addSubview(dateLabel)
        contentView.addSubview(switchView)
        
        backgroundColor = .systemGray6
        contentView.backgroundColor = .white
        contentView.layer.masksToBounds = true
    }
    
    override func setupConstraints() {
        dateIcon.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(EdgeMargin)
            make.top.equalTo(contentView).offset(EdgeMargin)
            make.width.height.equalTo(40)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(dateIcon.snp.right).offset(EdgeMargin)
            make.top.equalTo(contentView).offset(EdgeMargin)
        }
        
        switchView.snp.makeConstraints { make in
            make.right.equalTo(contentView).offset(EdgeMargin)
            make.top.equalTo(contentView).offset(EdgeMargin)
        }
        
        contentView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(50)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.cornerRadius = 8
        contentView.layer.maskedCorners = [
            .layerMaxXMinYCorner,
            .layerMinXMinYCorner,
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner
        ]
    }
}
