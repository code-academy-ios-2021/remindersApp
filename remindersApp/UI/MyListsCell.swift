//
//  MyListsCell.swift
//  remindersApp
//
//  Created by Arnas Sleivys on 2021-04-13.
//

import UIKit

final class MyListsCell: UITableViewCell {

    private let RoundedEdgesRadius: CGFloat = 8

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        applyTheming()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func applyTheming() {
        backgroundColor = .clear
        contentView.backgroundColor = .white

        contentView.layer.cornerRadius = RoundedEdgesRadius
        contentView.layer.maskedCorners = [
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner,
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
    }

    func configureCell(text: String) {
        textLabel?.text = text
    }
}
