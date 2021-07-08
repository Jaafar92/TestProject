//
//  LayoutFactory.swift
//  TestProject
//
//  Created by Jaafar on 08/07/2021.
//

import Foundation
import UIKit

class LayoutFactory {
    static func getCollectionView<T: UICollectionViewCell>(cellType type: T.Type, cellIdentifier: String) -> UICollectionView {
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
            collectionView.register(T.self, forCellWithReuseIdentifier: cellIdentifier)
            collectionView.alwaysBounceVertical = true
            collectionView.backgroundColor = .white
            collectionView.showsVerticalScrollIndicator = false

            return collectionView
        }

        static func getTableView<T: UITableViewCell>(cellType type: T.Type, cellIdentifier: String, parentView: UIView) -> UITableView {
            let tableView = UITableView()
            tableView.rowHeight = Constants.tableViewRowHeight
            tableView.tableFooterView = UIView()
            tableView.register(T.self, forCellReuseIdentifier: cellIdentifier)
            parentView.addSubview(tableView)

            return tableView
        }

        static func getSmallHeader(text: String, parentView: UIView) -> UILabel {
            let tempLabel = UILabel()
            tempLabel.text = text
            tempLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
            parentView.addSubview(tempLabel)

            return tempLabel
        }

        static func getLabel(text: String?, parentView: UIView) -> UILabel {
            let tempLabel = UILabel()

            if let text = text {
                tempLabel.text = text
            }

            tempLabel.textColor = .black
            parentView.addSubview(tempLabel)

            return tempLabel
        }

        static func getButton(title: String, parentView: UIView, buttonHeight: CGFloat = Constants.standardButtonHeight) -> UIButton {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .black
            button.layer.cornerRadius = Constants.standardCornerRadius
            button.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
            parentView.addSubview(button)

            return button
        }

        static func getStackView(content: [UIView?], orientation: NSLayoutConstraint.Axis, parentView: UIView) -> UIStackView {
            let stackView = UIStackView()
            stackView.axis = orientation
            stackView.alignment = .leading
            stackView.spacing = Constants.standardOffset
            stackView.distribution = .fillEqually

            for view in content {
                if let view = view {
                    stackView.addArrangedSubview(view)
                }
            }

            parentView.addSubview(stackView)

            return stackView
        }

        static func getAlert(withTitle title: String, withMessage message: String) -> UIAlertController {
               let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
               return alert
        }

        static func getTextField(placeholder: String, parentView view: UIView) -> UITextField {
            let textField = UITextField()
            textField.placeholder = placeholder
            textField.textAlignment = .center
            textField.borderStyle = .roundedRect
            view.addSubview(textField)

            return textField
        }

        static func getSpinner(forParent view: UIView) -> UIView {
            let spinnerView = UIView.init(frame: view.bounds)
            let colorAndAlpha = CGFloat(0)
            spinnerView.backgroundColor = UIColor.init(red: colorAndAlpha, green: colorAndAlpha, blue: colorAndAlpha, alpha: colorAndAlpha)

            return spinnerView
        }

        static func getSegmentedControl(withItems items: [String], forParent view: UIView) -> UISegmentedControl {
            let segmentedControl = UISegmentedControl(items: items)
            segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
            segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
            segmentedControl.selectedSegmentIndex = 0
            segmentedControl.layer.cornerRadius = Constants.standardCornerRadius
            segmentedControl.backgroundColor = .black
            segmentedControl.tintColor = .white

            view.addSubview(segmentedControl)

            return segmentedControl
        }

        static func getSearchBar() -> UISearchController {
            let searchController = UISearchController(searchResultsController: nil)
            searchController.obscuresBackgroundDuringPresentation = false

            return searchController
        }
}
