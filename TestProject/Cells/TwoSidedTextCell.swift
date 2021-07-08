//
//  TwoSidedTextCell.swift
//  TestProject
//
//  Created by Jaafar on 08/07/2021.
//

import UIKit

class TwoSidedTextCell: UITableViewCell {

    static var identifier: String = "TwoSidedTextCell"

    weak var leftLabel: UILabel!
    weak var rightLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        initializeRightLabel()
        initializeLeftLabel()

        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initializeLeftLabel() {
        self.leftLabel = LayoutFactory.getLabel(text: nil, parentView: self.contentView)
    }

    private func initializeRightLabel() {
        self.rightLabel = LayoutFactory.getLabel(text: nil, parentView: self.contentView)
    }

    private func setupConstraints() {
        Layout.addTopConstraint(on: self.leftLabel, to: self.contentView.topAnchor)
        Layout.addBottomConstraint(on: self.leftLabel, to: self.contentView.bottomAnchor)
        Layout.addLeadingConstraint(on: self.leftLabel, to: self.contentView.leadingAnchor)

        Layout.addTopConstraint(on: self.rightLabel, to: self.contentView.topAnchor)
        Layout.addBottomConstraint(on: self.rightLabel, to: self.contentView.bottomAnchor)
        Layout.addTrailingConstraint(on: self.rightLabel, to: self.contentView.trailingAnchor)
    }
}
