//
//  NewReminderViewController.swift
//  remindersApp
//
//  Created by Arnas Sleivys on 2021-04-21.
//

import UIKit

final class NewReminderViewController: BaseViewController {

    private let addBarButtonItem = UIBarButtonItem(
        title: "Add",
        style: .done,
        target: self,
        action: #selector(cancelPressed)
    )

    private lazy var newReminderTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        tableView.rowHeight = 50
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NewReminderCell.self, forCellReuseIdentifier: "NewReminderCell")
        return tableView
    }()

    override func setupView() {
        super.setupView()
        title = "New Reminder"
        view.backgroundColor = .systemGray6
        configureNavigationBar()
        view.addSubview(newReminderTableView)
    }

    override func setupConstraints() {
        super.setupConstraints()

        newReminderTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view).offset(15)
            make.trailing.equalTo(view).inset(15)
        }
    }

    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(cancelPressed)
        )
        navigationItem.rightBarButtonItem = addBarButtonItem
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()

        addBarButtonItem.isEnabled = false
    }

    @objc private func cancelPressed() {
        dismiss(animated: true, completion: nil)
    }
}

extension NewReminderViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewReminderCell", for: indexPath)

        guard let newReminderCell = cell as? NewReminderCell else {
            return cell
        }

        switch indexPath.section {
        case 0:
            newReminderCell.setupCell(type: .textField)
        case 1:
            newReminderCell.setupCell(type: .details)
        case 2:
            newReminderCell.setupCell(type: .list)
        default:
            fatalError("Unexpected section!")
        }

        let numberOfRowsInSection = tableView.numberOfRows(inSection: indexPath.section)

        guard numberOfRowsInSection > 1 else {
            newReminderCell.roundAllCorners()
            return newReminderCell
        }

        switch indexPath.row {
        case 0:
            newReminderCell.roundTopCorners()
        case numberOfRowsInSection - 1:
            newReminderCell.roundBottomCorners()
        default:
            newReminderCell.removeRounding()
        }

        return newReminderCell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }
}

extension NewReminderViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        20
    }
}
