//
//  MainViewController.swift
//  remindersApp
//
//  Created by Arnas Sleivys on 2021-04-12.
//

import UIKit
import SnapKit

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
    
    private lazy var searchController = UISearchController()
    
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

    private lazy var myListsLabel: UILabel = {
        let label = UILabel()
        label.text = "My lists"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    private lazy var myListsTableView: AdaptiveHeightTableView = {
        let tableView = AdaptiveHeightTableView(frame: view.frame)
        tableView.backgroundColor = .systemGray6
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MyListsCell.self, forCellReuseIdentifier: "MyListsCell")

        // Table view needs to be adaptive height for corner radius to work
        tableView.layer.cornerRadius = 8
        tableView.layer.maskedCorners = [
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner,
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        return tableView
    }()
    
    private lazy var bottomView = ActionsBottomView()
    private lazy var contentView = UIView()
    private lazy var scrollView = UIScrollView()
    
    override func setupView() {
        super.setupView()
        
        bottomView.actionsDelegate = self
        
        applyTheming()
        configureNavigationBar()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.alwaysBounceVertical = true
        scrollView.delegate = self
        
        contentView.addSubview(remindersTypeCollectionView)
        contentView.addSubview(myListsLabel)
        contentView.addSubview(myListsTableView)
        view.addSubview(bottomView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view).offset(16)
            make.trailing.equalTo(view).inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
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
            make.leading.equalTo(remindersTypeCollectionView)
            make.trailing.equalTo(remindersTypeCollectionView)
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
        guard let navigationController = navigationController else { return }

        let clearImage = UIImage()
        navigationController.navigationBar.setBackgroundImage(clearImage, for: .default)
        navigationController.navigationBar.shadowImage = clearImage
        navigationItem.rightBarButtonItem = editButton
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
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
        2
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
        // 1. Gauti paskutinę table view cell
        
        guard let indexPath = myListsTableView.indexPathsForVisibleRows?.last else {
            return false
        }
        
        // 2. Sužinoti paskutinės table view cell poziciją
        
        // Gauname paskutinės cell poziciją table view
        let cellFrameInTableView = myListsTableView.rectForRow(at: indexPath)
        
        // Gauname absoliučią cell poziciją visame main view
        let cellFrameInMainView = myListsTableView.convert(cellFrameInTableView, to: view)
                
        // 3. Palyginti bottom view poziciją su table view cell pozicija
        return bottomView.frame.intersects(cellFrameInMainView)
    }
}

extension MainViewController: ActionsBottomViewDelegate {
    func actionsBottomViewAddListPressed() {
        let newListViewController = NewListViewController()
        let navigationController = UINavigationController(rootViewController: newListViewController)
        
        present(navigationController, animated: true, completion: nil)
    }
}
