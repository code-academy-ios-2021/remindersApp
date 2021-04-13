//
//  MainViewController.swift
//  remindersApp
//
//  Created by Arnas Sleivys on 2021-04-12.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {

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

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
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
        collectionView.delegate = self
        collectionView.register(ReminderTypeCell.self, forCellWithReuseIdentifier: "ReminderTypeCell")
        collectionView.backgroundColor = .systemGray6

        return collectionView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureSearchBar()
        configureCollectionView()
        applyTheming()
    }
}

// MARK: - View configuration

private extension MainViewController {

    func applyTheming() {
        view.backgroundColor = .systemGray6
    }

    func configureNavigationBar() {
        guard let navigationController = navigationController else { return }

        let clearImage = UIImage()
        navigationController.navigationBar.setBackgroundImage(clearImage, for: .default)
        navigationController.navigationBar.shadowImage = clearImage
        navigationItem.rightBarButtonItem = editButton
    }

    func configureSearchBar() {
        view.addSubview(searchBar)

        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view).offset(EdgeMargin)
            make.trailing.equalTo(view).inset(EdgeMargin)
            make.height.equalTo(SearchBarHeight)
        }
    }

    func configureCollectionView() {
        view.addSubview(remindersTypeCollectionView)

        remindersTypeCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(EdgeMargin)
            make.bottom.equalTo(view)
            make.leading.equalTo(searchBar)
            make.trailing.equalTo(searchBar)
        }
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

// MARK: - UICollectionViewDelegateFlowLayout methods

extension MainViewController: UICollectionViewDelegateFlowLayout {


}
