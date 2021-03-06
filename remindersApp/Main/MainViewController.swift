//
//  MainViewController.swift
//  remindersApp
//
//  Created by Arnas Sleivys on 2021-04-12.
//

import UIKit
import SnapKit
import UserNotifications
import CoreLocation

final class MainViewController: BaseViewController {
    
    // MARK: - UI constants

    private let EdgeMargin: CGFloat = 20
    private let SearchBarHeight: CGFloat = 50
    private let CollectionViewCellHeight: CGFloat = 75

    private var collectionViewCellWidth: CGFloat {
        (view.frame.width / 2) - EdgeMargin * 2
    }

    // MARK: - UI elements

    private lazy var editButton = {
        UIBarButtonItem(
            title: "Edit",
            style: .plain,
            target: nil,
            action: nil
        )
    }()

    private let searchController = UISearchController()
    private lazy var searchBar: UISearchBar = {
        let searchBar = searchController.searchBar
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "Search"
        return searchBar
    }()

    private lazy var remindersTypeCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.sectionInset = .zero
        collectionViewLayout.itemSize = CGSize(width: collectionViewCellWidth, height: CollectionViewCellHeight)

        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: collectionViewLayout)
        collectionView.dataSource = self
        collectionView.register(ReminderTypeCell.self, forCellWithReuseIdentifier: "ReminderTypeCell")
        collectionView.backgroundColor = .systemGray6

        return collectionView
    }()

    private let myListsLabel: UILabel = {
        let label = UILabel()
        label.text = "My list"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    private lazy var myListsTableView: UITableView = {
        let tableView = SelfSizingTableView(frame: view.frame)
        tableView.backgroundColor = .systemGray6
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.register(MyListsCell.self, forCellReuseIdentifier: "MyListsCell")

        tableView.layer.cornerRadius = 8
        tableView.layer.maskedCorners = [
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner,
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        return tableView
    }()
    
    private let bottomView = ActionsBottomView()
    private let contentView = UIView()
    private let scrollView = UIScrollView()
    private let manager = CLLocationManager()
    
    init(myListText: String = "My List") {
        super.init(nibName: nil, bundle: nil)
        self.myListsLabel.text = myListText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserNotificationManager.tryScheduleNotification(
            title: "Code academy!",
            body: "Welcome",
            after: 10
        )
        
        if manager.authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization()
        } else if manager.authorizationStatus == .denied || manager.authorizationStatus == .restricted {
            showFailedLocationAuthorizationAlert()
        }
        
        manager.delegate = self
        manager.startUpdatingLocation()
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
    
    @objc private func newReminderCancelled() {
        print("New reminder cancelled")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        bottomView.isTransparent = !isTableViewBehindBottomView()
    }
    
    override func setupView() {
        super.setupView()
        
        bottomView.actionsDelegate = self
        
        applyTheming()
        configureNavigationBar()
        configureScrollView()
                
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(remindersTypeCollectionView)
        contentView.addSubview(myListsLabel)
        contentView.addSubview(myListsTableView)
        view.addSubview(bottomView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view).offset(EdgeMargin)
            make.trailing.equalTo(view).inset(EdgeMargin)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView) // Scrolling only vertically
        }

        remindersTypeCollectionView.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.height.equalTo((2 * CollectionViewCellHeight) + EdgeMargin)
            make.leading.equalTo(contentView)
            make.trailing.equalTo(contentView)
        }

        myListsLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView)
            make.trailing.equalTo(contentView)
            make.top.equalTo(remindersTypeCollectionView.snp.bottom).offset(EdgeMargin)
        }

        myListsTableView.snp.makeConstraints { make in
            make.leading.equalTo(contentView)
            make.trailing.equalTo(contentView)
            make.top.equalTo(myListsLabel.snp.bottom).offset(EdgeMargin)
            make.bottom.equalTo(contentView)
        }
        
        bottomView.snp.makeConstraints { make in
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - View configuration

private extension MainViewController {

    func applyTheming() {
        view.backgroundColor = .systemGray6
        bottomView.isTransparent = !isTableViewBehindBottomView()
    }

    func configureNavigationBar() {
        navigationItem.rightBarButtonItem = editButton
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    func configureScrollView() {
        scrollView.delegate = self
        scrollView.contentInset.bottom = 64
        scrollView.showsVerticalScrollIndicator = false
    }
}

// MARK: - UICollectionViewDataSource methods

extension MainViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReminderTypeCell", for: indexPath)

        guard let reminderTypeCell = cell as? ReminderTypeCell else {
            return cell
        }

        reminderTypeCell.configureCell(type: ReminderTypeCell.ReminderType(rawValue: indexPath.row)!)
        return reminderTypeCell
    }
}

// MARK: - UITableViewDataSource methods

extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "MyListsCell", for: indexPath)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        // For performance reasons
        return 50
    }
}

// MARK: - Bottom View Transparency

extension MainViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        bottomView.isTransparent = !isTableViewBehindBottomView()
    }
    
    private func isTableViewBehindBottomView() -> Bool {
        // 1. Gauti paskutin?? table view cell
        
        guard let indexPath = myListsTableView.indexPathsForVisibleRows?.last else {
            return false
        }
        
        // 2. Su??inoti paskutin??s table view cell pozicij??
        
        // Gauname paskutin??s cell pozicij?? table view
        let cellFrameInTableView = myListsTableView.rectForRow(at: indexPath)
        
        // Gauname absoliu??i?? cell pozicij?? visame main view
        let cellFrameInMainView = myListsTableView.convert(cellFrameInTableView, to: view)
                
        // 3. Palyginti bottom view pozicij?? su table view cell pozicija
        return bottomView.frame.origin.y <= cellFrameInMainView.origin.y + cellFrameInMainView.height
    }
}

extension MainViewController: ActionsBottomViewDelegate {
    func actionsBottomViewAddListPressed() {
        let newListViewController = NewListViewController()
        let navigationController = UINavigationController(rootViewController: newListViewController)
        
        present(navigationController, animated: true, completion: nil)
    }

    func actionsBottomViewNewReminderPressed() {
        let newReminderViewController = NewReminderViewController()
        let navigationController = UINavigationController(rootViewController: newReminderViewController)

        present(navigationController, animated: true, completion: nil)
    }
}

extension MainViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let content = notification.request.content
        let alert = UIAlertController(
            title: content.title,
            message: content.body,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        
        present(alert, animated: true, completion: nil)
    }
}

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        if (error as NSError).code == CLError.locationUnknown.rawValue {
            print("Location unknown")
        } else {
            print(error)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        
        if location.horizontalAccuracy < 10 {
            // updateUI()
            // calculateSpeed()
            // sendToBackend()
        }
        
        print("\(location)")
    }
}

extension MainViewController {
    private func showFailedLocationAuthorizationAlert() {
        let alert = UIAlertController(
            title: "Location not allowed!",
            message: "Our application cannot work fully without location. Please enable it in settings",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "I don't care", style: .default))
        
        alert.addAction(UIAlertAction(title: "Grant permissions", style: .default, handler: { [unowned self] _ in
            self.openSettings()
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    private func openSettings() {
        if let appSettings = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
        }
    }
}

#if DEBUG
import SwiftUI

struct MainViewController_Preview: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable {
            return MainViewController(myListText: "My list")
        }
    }
}
#endif
