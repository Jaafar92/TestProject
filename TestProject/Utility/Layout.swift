//
//  Layout.swift
//  TestProject
//
//  Created by Jaafar on 08/07/2021.
//

import Foundation
import UIKit

class Layout {
    static func centerVertically(on view: UIView, withParent parentView: UIView) {
            view.translatesAutoresizingMaskIntoConstraints = false
            view.centerYAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.centerYAnchor).isActive = true
        }

        static func centerHorizontally(on view: UIView, withParent parentView: UIView) {
            view.translatesAutoresizingMaskIntoConstraints = false
            view.centerXAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.centerXAnchor).isActive = true
        }

        static func addTopConstraint(on view: UIView, to anchor: NSLayoutYAxisAnchor, by points: CGFloat = Constants.standardOffset) {
            view.translatesAutoresizingMaskIntoConstraints = false
            view.topAnchor.constraint(equalTo: anchor, constant: points).isActive = true
        }

        static func addBottomConstraint(on view: UIView, to anchor: NSLayoutYAxisAnchor, by points: CGFloat = Constants.standardOffset) {
            view.translatesAutoresizingMaskIntoConstraints = false
            view.bottomAnchor.constraint(equalTo: anchor, constant: -points).isActive = true
        }

        static func addLeadingConstraint(on view: UIView, to anchor: NSLayoutXAxisAnchor, by points: CGFloat = Constants.standardOffset) {
            view.translatesAutoresizingMaskIntoConstraints = false
            view.leadingAnchor.constraint(equalTo: anchor, constant: points).isActive = true
        }

        static func addTrailingConstraint(on view: UIView, to anchor: NSLayoutXAxisAnchor, by points: CGFloat = Constants.standardOffset) {
            view.translatesAutoresizingMaskIntoConstraints = false
            view.trailingAnchor.constraint(equalTo: anchor, constant: -points).isActive = true
        }

//        static func setupViewNavigationController(forView view: UIViewController, withTitle title: String) {
//            view.navigationController?.hideNavigationBar()
//            view.navigationController?.navigationBar.prefersLargeTitles = true
//            view.title = title
//        }

        static func setupFullPageConstraints(forView view: UIView, onParentView parentView: UIView, by points: CGFloat = Constants.standardOffset) {
            addTopConstraint(on: view, to: parentView.safeAreaLayoutGuide.topAnchor, by: points)
            addBottomConstraint(on: view, to: parentView.safeAreaLayoutGuide.bottomAnchor, by: points)
            addLeadingConstraint(on: view, to: parentView.safeAreaLayoutGuide.leadingAnchor, by: points)
            addTrailingConstraint(on: view, to: parentView.safeAreaLayoutGuide.trailingAnchor, by: points)
        }

        static func setupPopupViewContraints(forView view: UIView, onParentView parentView: UIViewController, forTopAndBottom topBottom: CGFloat = Constants.popupTopBottom, forSides sidePoints: CGFloat = Constants.popupLeadingTrailing) {
            addTopConstraint(on: view, to: parentView.view.safeAreaLayoutGuide.topAnchor, by: topBottom)
            addBottomConstraint(on: view, to: parentView.view.safeAreaLayoutGuide.bottomAnchor, by: topBottom)
            addLeadingConstraint(on: view, to: parentView.view.safeAreaLayoutGuide.leadingAnchor, by: sidePoints)
            addTrailingConstraint(on: view, to: parentView.view.safeAreaLayoutGuide.trailingAnchor, by: sidePoints)
        }

        static func centerAlignUILabels(uiLabelArry: [UILabel]) {
            for label in uiLabelArry {
                label.textAlignment = .center
            }
        }

        static func setLabelAsHeader(labels: [UILabel]) {
            for label in labels {
                label.font = UIFont.boldSystemFont(ofSize: Constants.headerSize)
            }
        }
}
