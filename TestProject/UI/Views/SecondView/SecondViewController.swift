//
//  SecondViewController.swift
//  TestProject
//
//  Created by Jaafar on 30/07/2021.
//

import UIKit
import Combine
import CoordinatorNavigation

class SecondViewController: BaseUIViewController {
    
    weak var changeTextButton: UIButton!
    weak var navigateToNextPageButton: UIButton!
    weak var pageIndicatorLabel: UILabel!
    weak var textContainerLabel: UILabel!
    
    private let viewModel: SecondViewModel
    
    init(viewModel: SecondViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        initializePageIndicatorLabel()
        initializeTextContainerLabel()
        initializeButtons()
        
        setupConstraints()
        super.viewDidLoad()
    }
    
    private func initializePageIndicatorLabel() {
        self.pageIndicatorLabel = LayoutFactory.getLabel(text: "Second View", parentView: self.view)
    }
    
    private func initializeTextContainerLabel() {
        self.textContainerLabel = LayoutFactory.getLabel(text: "", parentView: self.view)
    }
    
    private func initializeButtons() {
        self.changeTextButton = LayoutFactory.getButton(title: "Navigate to Forth (SwiftUI)", parentView: self.view)
        self.changeTextButton.addTarget(self, action: #selector(navigateToForthPage(_:)), for: .touchUpInside)
        
        self.navigateToNextPageButton = LayoutFactory.getButton(title: "Navigate to third", parentView: self.view)
        self.navigateToNextPageButton.addTarget(self, action: #selector(navigateToThirdPage(_:)), for: .touchUpInside)
    }
    
    override func setUpBindings() {
        viewModel.$text
            .receive(on: DispatchQueue.main)
            .assign(to: \.text!, on: self.textContainerLabel)
            .store(in: &bindings)
    }
    
    @objc func navigateToForthPage(_ sender: UIButton) {
        viewModel.navigateToForthView()
    }
    
    @objc func navigateToThirdPage(_ sender: UIButton) {
        viewModel.navigateToThirdView()
    }
    
    private func setupConstraints() {
        Layout.addTopConstraint(on: self.pageIndicatorLabel, to: self.textContainerLabel.bottomAnchor, by: Constants.hugeOffset)
        Layout.centerHorizontally(on: self.pageIndicatorLabel, withParent: self.view)
        
        Layout.centerHorizontally(on: self.textContainerLabel, withParent: self.view)
        Layout.centerVertically(on: self.textContainerLabel, withParent: self.view)
        
        Layout.addBottomConstraint(on: self.navigateToNextPageButton, to: self.changeTextButton.topAnchor, by: Constants.standardOffset)
        Layout.addLeadingConstraint(on: self.navigateToNextPageButton, to: self.view.leadingAnchor)
        Layout.addTrailingConstraint(on: self.navigateToNextPageButton, to: self.view.trailingAnchor)
        
        Layout.addBottomConstraint(on: self.changeTextButton, to: self.view.safeAreaLayoutGuide.bottomAnchor, by: Constants.standardOffset)
        Layout.addLeadingConstraint(on: self.changeTextButton, to: self.view.leadingAnchor)
        Layout.addTrailingConstraint(on: self.changeTextButton, to: self.view.trailingAnchor)
    }
}
