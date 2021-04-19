//
//  ReminderTypeCell.swift
//  remindersApp
//
//  Created by Arnas Sleivys on 2021-04-12.
//

import UIKit

final class ReminderTypeCell: UICollectionViewCell {

    private let RoundedCornerRadius: CGFloat = 8

    enum ReminderType: Int {
        case today
        case scheduled
        case all
        case flagged
    }

    // MARK: - UI elements

    private lazy var iconContainerView = UIView()
    private lazy var iconView = UIImageView()
    private lazy var typeLabel = UILabel()
    private lazy var countLabel = UILabel()

    private func configuredLabel(text: String, color: UIColor, fontSize: CGFloat) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = color
        label.font = UIFont.boldSystemFont(ofSize: fontSize)
        return label
    }

    func configureCell(type: ReminderType) {
        let iconViewColor: UIColor

        switch type {
        case .today:
            iconView = UIImageView(image: #imageLiteral(resourceName: "calendar").withTintColor(.white))
            typeLabel = configuredLabel(text: "Today", color: .gray, fontSize: 15)
            countLabel = configuredLabel(text: "0", color: .black, fontSize: 30)
            iconViewColor = .systemBlue
        case .scheduled:
            iconView = UIImageView(image: #imageLiteral(resourceName: "glyphCalendar").withTintColor(.white))
            typeLabel = configuredLabel(text: "Scheduled", color: .gray, fontSize: 15)
            countLabel = configuredLabel(text: "1", color: .black, fontSize: 30)
            iconViewColor = .systemRed
        case .all:
            iconView = UIImageView(image: #imageLiteral(resourceName: "inbox").withTintColor(.white))
            typeLabel = configuredLabel(text: "All", color: .gray, fontSize: 15)
            countLabel = configuredLabel(text: "5", color: .black, fontSize: 30)
            iconViewColor = .systemGray
        case .flagged:
            iconView = UIImageView(image: #imageLiteral(resourceName: "flag").withTintColor(.white))
            typeLabel = configuredLabel(text: "Flagged", color: .gray, fontSize: 15)
            countLabel = configuredLabel(text: "0", color: .black, fontSize: 30)
            iconViewColor = .systemOrange
        }

        iconContainerView.layer.cornerRadius = 15
        iconContainerView.clipsToBounds = true
        iconContainerView.backgroundColor = iconViewColor

        setupCell(iconViewColor: iconViewColor)
    }
}

// MARK: - Private functionality

private extension ReminderTypeCell {

    func setupCell(iconViewColor: UIColor) {
        backgroundColor = .white
        layer.cornerRadius = RoundedCornerRadius
        iconContainerView.addSubview(iconView)
        addSubview(iconContainerView)
        addSubview(typeLabel)
        addSubview(countLabel)

        setupConstraints()
    }

    func setupConstraints() {
        iconContainerView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.leading.equalTo(contentView).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }

        iconView.snp.makeConstraints { make in
            make.centerX.equalTo(iconContainerView)
            make.centerY.equalTo(iconContainerView)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }

        typeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentView).inset(10)
            make.leading.equalTo(contentView).offset(10)
        }

        countLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.trailing.equalTo(contentView).inset(10)
        }
    }
}
