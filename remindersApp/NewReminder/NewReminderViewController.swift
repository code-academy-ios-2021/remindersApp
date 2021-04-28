//
//  NewReminderViewController.swift
//  remindersApp
//
//  Created by Arnas Sleivys on 2021-04-21.
//

import UIKit

struct NewReminderCellModel {
    let identifier: String
}

struct NewReminderSectionModel {
    let cells: [NewReminderCellModel]
}

final class NewReminderViewController: BaseViewController {
    let sections: [NewReminderSectionModel] = [
        NewReminderSectionModel(cells: [
            NewReminderCellModel(identifier: NewReminderTextFieldCell.reuseID),
            NewReminderCellModel(identifier: NewReminderTextFieldCell.reuseID),
        ]),
        NewReminderSectionModel(cells: [
                                    NewReminderCellModel(identifier: NewReminderDetailsCell.reuseID)]),
        NewReminderSectionModel(cells: [
                                    NewReminderCellModel(identifier: NewReminderListCell.reuseID)]
        )
    ]

    private var EdgeInset: CGFloat = 16

    private lazy var newReminderTableView: UITableView = {
        let tableView = SelfSizingTableView()
        tableView.backgroundColor = .systemGray6
        tableView.rowHeight = 50
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NewReminderTextFieldCell.self, forCellReuseIdentifier: NewReminderTextFieldCell.reuseID)
        tableView.register(NewReminderDetailsCell.self, forCellReuseIdentifier: NewReminderDetailsCell.reuseID)
        tableView.register(NewReminderListCell.self, forCellReuseIdentifier: NewReminderListCell.reuseID)

        return tableView
    }()
    
    private let informationLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter information about your reminders"
        label.textColor = .systemGray3
        label.textAlignment = .center
        return label
    }()
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        
        picker.datePickerMode = .dateAndTime
        picker.preferredDatePickerStyle = .inline
        picker.locale = Locale(identifier: "lt")
        picker.minimumDate = Date()
        
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeKeyboardNotifications()
        observeTouchesOnView()
    }

    override func setupView() {
        super.setupView()
        title = "New Reminder"
        view.backgroundColor = .systemGray6
        configureNavigationBar()
        view.addSubview(newReminderTableView)
        view.addSubview(informationLabel)
        view.addSubview(datePicker)
    }

    override func setupConstraints() {
        super.setupConstraints()

        newReminderTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view).offset(EdgeInset)
            make.trailing.equalTo(view).inset(EdgeInset)
        }
        
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(newReminderTableView.snp.bottom)
            make.leading.equalTo(view).offset(EdgeInset)
            make.trailing.equalTo(view).inset(EdgeInset)
        }
        
        informationLabel.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(EdgeInset)
            make.centerX.equalTo(view)
        }
    }
    
    override func keyboardWillAppear(_ keyboardHeight: CGFloat) {
        super.keyboardWillAppear(keyboardHeight)
        
        informationLabel.snp.updateConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(EdgeInset + keyboardHeight)
        }
        
        UIView.animate(withDuration: 1.5, animations: view.layoutIfNeeded)
    }
    
    override func keyboardWillDisappear() {
        super.keyboardWillDisappear()
        
        informationLabel.snp.updateConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(EdgeInset)
        }
        
        UIView.animate(withDuration: 1.5, animations: view.layoutIfNeeded)
    }

    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(cancelPressed)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Add",
            style: .done,
            target: self,
            action: #selector(addPressed)
        )
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @objc private func addPressed() {
        UserNotificationManager.tryScheduleNotification(
            title: "Notification!",
            body: "Test",
            date: datePicker.date
        )
        
        dismiss(animated: true, completion: nil)
    }

    @objc private func cancelPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    private func observeTouchesOnView() {
        let recognizer = UITapGestureRecognizer(
            target: view,
            action: #selector(view.endEditing(_:))
        )
        recognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(recognizer)
    }
}

extension NewReminderViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = sections[indexPath.section].cells[indexPath.row]
        guard let newReminderCell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath) as? BaseTableViewCell else {
            return UITableViewCell()
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
        return sections.count
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }
}

extension NewReminderViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Pressed")
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        20
    }
}
