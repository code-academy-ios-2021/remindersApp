//
//  MyListsCell.swift
//  remindersApp
//
//  Created by Arnas Sleivys on 2021-04-13.
//

import UIKit

final class MyListsCell: UITableViewCell {

    private let RoundedEdgesRadius: CGFloat = 15

    // MARK: - UI elements

    private lazy var iconContainerView = UIView()
    private lazy var iconView = UIImageView()
    private lazy var listNameLabel = configuredLabel(text: "Reminders Reminders Reminders Reminders Reminders", color: .black)
    private lazy var countLabel = configuredLabel(text: "100000000000", color: .placeholderText)

    private func configuredLabel(text: String, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = color
        return label
    }

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Configuration

    func configureCell() {
        iconView = UIImageView(image: #imageLiteral(resourceName: "list").withTintColor(.white))

        iconContainerView.layer.cornerRadius = RoundedEdgesRadius
        iconContainerView.clipsToBounds = true
        iconContainerView.backgroundColor = .systemBlue

        iconContainerView.addSubview(iconView)
        contentView.addSubview(iconContainerView)
        contentView.addSubview(listNameLabel)
        contentView.addSubview(countLabel)

        accessoryType = .disclosureIndicator
        selectionStyle = .none

        setupConstraints()
    }

    private func setupConstraints() {
        iconContainerView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.bottom.equalTo(contentView).inset(10)
            make.leading.equalTo(contentView).offset(10)
            make.height.width.equalTo(30)
        }

        iconView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(iconContainerView)
            make.width.height.equalTo(18)
        }

        listNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconContainerView.snp.trailing).offset(10)
            make.centerY.equalTo(contentView)
        }
        
        listNameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        countLabel.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(listNameLabel.snp.trailing).offset(10)
            make.trailing.equalTo(contentView).inset(10)
            make.centerY.equalTo(contentView)
        }
        
        countLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
}
